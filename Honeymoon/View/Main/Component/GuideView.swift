//
//  GuideView.swift
//  Honeymoon
//
//  Created by SHIRAISHI HIROYUKI on 2023/11/28.
//

import SwiftUI

enum GuidItem: Int { case like, dismis, book}

struct GuideView: View {
    // MARK: - プロパティー
    private var giuidView: GuidDatas
    @Environment(\.dismiss) var dismis

    init() {
        self.giuidView = TestData.shared.guidTestData
    }

    // MARK: - ボディー

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 20) {
                /// ヘッダー
                CommonHeaderView()

                Text("Get Started")
                    .fontWeight(.black)
                    .modifier(TitleModeifire())

                Text("ロマンチックなハネムーンに最適な目的地を見つけて選んでください")
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)

                Spacer(minLength: 10)

                VStack(alignment: .leading, spacing: 25) {
                    CommonGuideView(guidData: giuidView[GuidItem.like.rawValue])

                    CommonGuideView(guidData: giuidView[GuidItem.dismis.rawValue])

                    CommonGuideView(guidData: giuidView[GuidItem.book.rawValue])
                }

                Spacer(minLength: 10)

                Button {
                    dismis()
                } label: {
                    Text("continue".uppercased())
                        .modifier(FooterModeifire())
                }
            }//: VStack
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.top, 15)
            .padding(.bottom, 25)
            .padding(.horizontal, 25)
        }//: ScrollView
    }
}

#Preview {
    GuideView()
}
