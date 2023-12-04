//
//  MainView.swift
//  Honeymoon
//
//  Created by SHIRAISHI HIROYUKI on 2023/11/27.
//

import SwiftUI

struct MainView: View {
    // MARK: - プロパティー

    /// ハネムーンビューモデルの状態オブジェクト
    @StateObject private var honeymoonViewmodel = HoneymoonViewModel()

    /// アラート表示状態の管理用
    @State private var isShowAlert: Bool = false

    /// ガイドビュー表示状態の管理用
    @State var isShowGuideView: Bool = false

    /// 情報表示状態の管理用
    @State var isShowInformation: Bool = false

    /// ドラッグ操作の状態を追跡するジェスチャー状態
    @GestureState private var dragState: DragState = .inactive

    /// カードの最後のインデックスを追跡するステート変数
    @State private var lastCardIndex: Int = 1

    /// ドラッグエリアのしきい値を定義
    private var dragAreaThreshold: CGFloat = 65.0

    /// カード削除時のトランジションを定義
    @State private var cardRemovalTransition = AnyTransition.trailingBottom

    /// ハネムーンデータからカードビューの配列を生成
    @State private var cardViews: CardViews = {
        var cardViews: CardViews = []

        for data in TestData.shared.honeymoonTestData {
            cardViews.append(CardView(honeymoonData: data))
        }
        return cardViews
    }()

    // MARK: - ボディー

    var body: some View {
        VStack {
            HeaderView(isShowGuidView: $isShowGuideView, isShowInfomation: $isShowGuideView)
                .opacity(dragState.isDragging ? 0.0 : 1.0)

            Spacer()

            ZStack {
                ForEach(cardViews) { view in
                    view
                    /// カードのZインデックス（重なり順）の設定
                    /// 現在のトップカード（スタックの最前面にあるカード）にはzIndexを1に設定し、それ以外のカードは0に設定
                    /// これにより、トップカードが他のカードよりも前面に表示される
                        .zIndex(self.isTopCard(cardView: view) ? 1: 0)

                        .overlay(
                            ZStack {
                                /// ドラッグ中のカードが左に移動してしきい値を超えた場合、バツマークを表示
                                /// これはユーザーがカードを「否定的」にスワイプしていることを示す
                                Image(systemName: "x.circle")
                                    .modifier(SymbolModifier())
                                    .opacity(self.dragState.translation.width < -self.dragAreaThreshold && self.isTopCard(cardView: view) ? 1.0 : 0.0)

                                /// ドラッグ中のカードが右に移動してしきい値を超えた場合、ハートマークを表示
                                /// これはユーザーがカードを「肯定的」にスワイプしていることを示す
                                Image(systemName: "heart.circle")
                                    .modifier(SymbolModifier())
                                    .opacity(self.dragState.translation.width > self.dragAreaThreshold && self.isTopCard(cardView: view) ? 1.0 : 0.0)
                            }
                        )
                    /// ドラッグ状態に応じてカードのオフセット（位置）を変更
                    /// ドラッグ中のカード（トップカード）は、ユーザーのドラッグ動作によって移動
                    /// dragState.translationはドラッグの距離と方向を表し、それに基づいてカードの位置が変わる
                        .offset(x: self.isTopCard(cardView: view) ?  self.dragState.translation.width : 0, y: self.isTopCard(cardView: view) ?  self.dragState.translation.height : 0)

                    /// ドラッグ動作に対するアニメーションを設定
                    /// interpolatingSpringは、自然なバネのような動きを提供し、カードが放されたときに元の位置に戻るようなる
                    /// stiffnessとdampingはアニメーションの挙動を制御
                        .animation(.interpolatingSpring(stiffness: 120, damping: 120), value: dragState.isDragging)

                    /// ドラッグ中のカードを縮小表示するための設定
                    /// ドラッグ中のトップカードはスケールが0.85に設定され、少し小さく表示される
                        .scaleEffect(self.dragState.isDragging && self.isTopCard(cardView: view) ? 0.85 : 1.0)

                    /// ドラッグ中のカードに回転効果を適用
                    /// ドラッグの距離に応じてカードが回転し、ドラッグの方向と量に応じて回転角が変わる
                    /// / 12は回転量を調整するための値
                        .rotationEffect(Angle(degrees: self.isTopCard(cardView: view) ? Double(self.dragState.translation.width / 12) : 0))

                    /// カードに長押しとドラッグのジェスチャを組み合わせて適用
                    /// LongPressGestureは短い遅延後に発火し、その後にDragGestureが続く
                    /// このジェスチャの状態はdragStateに反映され、カードのビューが適切に更新される
                        .gesture(LongPressGesture(minimumDuration: 0.01)

                                 /// 長押しジェスチャー(LongPressGesture)とドラッグジェスチャー(DragGesture)を連続して適用するための設定をしている
                                 /// sequenced(before:)メソッドは、一つのジェスチャーが完了した後に別のジェスチャーを開始するために使用される
                                 /// 押しジェスチャーがトリガーされ、その後にドラッグジェスチャーが開始されるように設定
                            .sequenced(before: DragGesture())

                                 /// ジェスチャーの状態（DragState）を更新するためのもの(updatingメソッドは、ジェスチャーの状態が変化するたびに呼び出され、dragStateプロパティを適切に更新)
                            .updating(self.$dragState, body: { (value, state, transaction) in
                                switch value {
                                case .first(true):
                                    state = .pressing
                                case .second(true, let drag):
                                    state = .dragging(translation: drag?.translation ?? .zero)
                                default:
                                    break
                                }
                            })
                                .onChanged({ (value) in
                                    /// ジェスチャーの状態が変化したときの処理
                                    /// ジェスチャーの第二段階（ドラッグ）をチェック
                                    guard case .second(true, let drag?) = value else {
                                        return
                                    }

                                    /// ドラッグした距離が左方向のしきい値を超えた場合、カード削除のトランジションを左下方向に設定
                                    if drag.translation.width < -self.dragAreaThreshold {
                                        self.cardRemovalTransition = .leadingBottom
                                    }

                                    /// ドラッグした距離が右方向のしきい値を超えた場合、カード削除のトランジションを右下方向に設定
                                    if drag.translation.width > self.dragAreaThreshold {
                                        self.cardRemovalTransition = .trailingBottom
                                    }
                                })
                                .onEnded({ (value) in
                                    /// ジェスチャーが終了したときの処理
                                    /// ジェスチャーの第二段階（ドラッグ）をチェック
                                    guard case .second(true, let drag?) = value else {
                                        return
                                    }

                                    /// ドラッグした距離が左または右のしきい値を超えた場合、サウンドを再生しカードを動かす
                                    if drag.translation.width < -self.dragAreaThreshold || drag.translation.width > self.dragAreaThreshold {
                                        playSound(sound: "sound-rise", type: "mp3")
                                        self.moveCards()
                                    }
                                })
                        )
                }
            }
            Spacer()
            FooterView(isShowBookingAlert: $isShowAlert)
                .opacity(dragState.isDragging ? 0.0 : 1.0)
        }
        .alert(isPresented: $isShowAlert) {
            Alert(title: Text("完了".uppercased()), message: Text("好きな時間が過ごせるように願っています"), dismissButton: .default(Text("OK")))
        }
    }//: ボディー


    /// 指定されたカードがトップカードかどうかを判断する関数
    /// - Parameter cardView: 判定するカードビュー
    /// - Returns: トップカードであればtrueを返し、そうでなければfalseを返す
    private func isTopCard(cardView: CardView) -> Bool {
        guard let index = cardViews.firstIndex(where: { $0.id == cardView.id }) else {
            return false
        }
        return index == 0
    }

    /// カードビューの配列を更新する関数
    private func moveCards() {
        /// 最初のカードを配列から削除
        cardViews.removeFirst()

        /// カードインデックスを更新
        self.lastCardIndex += 1

        /// 新しいカードデータを取得してカードビューを作成
        let honeymoon = TestData.shared.honeymoonTestData[lastCardIndex % TestData.shared.honeymoonTestData.count]
        let newCardView = CardView(honeymoonData: honeymoon)

        /// 新しいカードビューを配列の最後に追加
        cardViews.append(newCardView)
    }

}


enum DragState {
    /// ドラッグジェスチャーが非アクティブな状態
    case inactive

    /// ユーザーが画面を長押ししているが、まだドラッグを開始していない状態
    case pressing

    /// ユーザーがドラッグを行っている状態
    case dragging(translation: CGSize)

    /// 現在のドラッグジェスチャーの移動量を表す
    var translation: CGSize {
        switch self {
        case .inactive, .pressing:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }

    /// ドラッグ中かどうかを示すブール値
    var isDragging: Bool {
        switch self {
        case .dragging:
            return true
        case .pressing, .inactive:
            return false
        }
    }

    /// 長押し中、またはドラッグ中かどうかを示すブール値
    var isPressing: Bool {
        switch self {
        case .pressing, .dragging:
            return true
        case .inactive:
            return false
        }
    }
}


#Preview {
    MainView()
}
