//
//  InfomationView.swift
//  Honeymoon
//
//  Created by SHIRAISHI HIROYUKI on 2023/12/03.
//

import SwiftUI

struct InfomationView: View {
    // MARK: - プロパティー
    @Environment(\.dismiss) var dismiss

    // MARK: - ボディー

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 20) {
                
                /// ヘッダー
                headerViewArea

                /// アプリインフォメーション
                appInfoArea

                /// クレジット
                creditArea

                /// 続けるボタンエリア
                continueButtonArea


            }//: VStack
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.top, 15)
            .padding(.bottom, 25)
            .padding(.horizontal, 25)

        }//: ScrollView

    }//: ボディー
}

private extension InfomationView {
    /// ヘッダー
    private var headerViewArea: some View {
        CommonHeaderView()
    }

    /// アプリインフォメーション
    private var appInfoArea: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("App Info")
                .fontWeight(.black)
                .modifier(TitleModeifire())
            RowAppInfoView(leftItem: "Application", rightItem: "Honeymoon")
            Divider()

            RowAppInfoView(leftItem: "Compatibility", rightItem: "iPhone and iPad")
            Divider()

            RowAppInfoView(leftItem: "Developer", rightItem: "H.SHIRAISHI")
            Divider()

            RowAppInfoView(leftItem: "Designer", rightItem: "Robert Petras")
            Divider()

            RowAppInfoView(leftItem: "Website", rightItem: "github.com/hiroyuki0402")
            Divider()

            RowAppInfoView(leftItem: "Version", rightItem: "1.0.0")
            Divider()
        }
    }

    /// クレジット
    private var creditArea: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Credit")
                .fontWeight(.black)
                .modifier(TitleModeifire())

            HStack {
                Text("Photos")
                    .foregroundStyle(.gray)

                Spacer(minLength: 10)

                Text("UnPlash")
            }

            Divider()

            Text("Photographers")
                .foregroundStyle(.gray)

            Text("Shifaaz Shamoon (Maldives), Grillot Edouard (France), Evan Wise (Greece), Christoph Schulz (United Arab Emirates), Andrew Coelho (USA), Damiano Baschiera (Italy), Daniel Olah (Hungary), Andrzej Rusinowski (Poland), Lucas Miguel (Slovenia), Florencia Potter (Spain), Ian Simmonds (USA), Ian Keefe (Canada), Denys Nevozhai (Thailand), David Köhler (Italy), Andre Benz (USA), Alexandre Chambon (South Korea), Roberto Nickson (Mexico), Ajit Paul Abraham (UK), Jeremy Bishop (USA), Davi Costa (Brazil), Liam Pozz (Australia)")
              .multilineTextAlignment(.leading)
              .font(.footnote)
        }
    }

    private var continueButtonArea: some View {
        Button {
            dismiss()
        } label: {
            Text(" Continue".uppercased())
                .modifier(FooterModeifire())
        }
    }
}

#Preview {
    InfomationView()
}
