//
//  MainView.swift
//  Honeymoon
//
//  Created by SHIRAISHI HIROYUKI on 2023/11/27.
//

import SwiftUI

struct MainView: View {
    // MARK: - プロパティー

    @StateObject private var honeymoonViewmodel = HoneymoonViewModel()
    @State private var isSHowlAlert: Bool = false
    @State var isShowGuidView: Bool = false
    @State var isShowInfomation: Bool = false
    @GestureState private var dragState: DragState = .inactive

    private var cardViews: CardViews = {
        var cardViews: CardViews = []

        for data in TestData.shrred.honeymoonTestData {
            cardViews.append(CardView(honeymoonData: data))
        }

        return cardViews
    }()

    // MARK: - ボディー

    var body: some View {
        VStack {
            HeaderView(isShowGuidView: $isShowGuidView, isShowInfomation: $isShowInfomation)
                .opacity(dragState.isDragging ? 0.0 : 1.0)

            Spacer()

            ZStack {
                ForEach(cardViews) { view in
                    view
                    /// カードのZインデックス（重なり順）の設定
                    /// 現在のトップカード（スタックの最前面にあるカード）にはzIndexを1に設定し、それ以外のカードは0に設定
                    /// これにより、トップカードが他のカードよりも前面に表示される
                        .zIndex(self.isTopCard(cardView: view) ? 1: 0)

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
                        )
                }
            }

            Spacer()

            FooterView(isShowBookingAlert: $isSHowlAlert)
                .opacity(dragState.isDragging ? 0.0 : 1.0)
        }
        .alert(isPresented: $isSHowlAlert) {
            Alert(title: Text("完了".uppercased()), message: Text("好きな時間が過ごせるように願っています"), dismissButton: .default(Text("OK")))
        }
    }//: ボディー

    private func isTopCard(cardView: CardView) -> Bool {
        guard let index = cardViews.firstIndex(where: {   $0.id == cardView.id }) else {
            return false
        }
        return index == 0
    }
}

enum DragState {
    case inactive
    case pressing
    case dragging(translation: CGSize)

    var translation: CGSize {
        switch self {
        case .inactive, .pressing:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }

    var isDragging: Bool {
        switch self {
        case .dragging:
            return true
        case .pressing, .inactive:
            return false
        }
    }

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
