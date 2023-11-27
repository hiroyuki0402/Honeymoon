//
//  HeaderView.swift
//  Honeymoon
//
//  Created by SHIRAISHI HIROYUKI on 2023/11/27.
//

import SwiftUI

struct HeaderView: View {
    // MARK: - プロパティー

    // MARK: - ボディー
    var body: some View {
        HStack {
            informationButton

            Spacer()

            headertitle

            Spacer()

            guaidButton
        }
        .padding()
    }//: ボディー
}

// MARK: - HeaderViewアイテム

private extension HeaderView {

    /// インフォメーションボタン
    private var informationButton: some View {
        Button {

        } label: {
            Image(systemName: "info.circle")
                .font(.system(size: 24, weight: .regular))
        }
        .tint(.primary)
    }

    private var headertitle: some View {
        Image(.logoHoneymoonPink)
            .resizable()
            .scaledToFit()
            .frame(height: 28)
    }

    /// ガイドボタン
    private var guaidButton: some View {
        Button {

        } label: {
            Image(systemName: "questionmark.circle")
                .font(.system(size: 24, weight: .regular))
        }
        .tint(.primary)
    }
}

#Preview {
    HeaderView()
}
