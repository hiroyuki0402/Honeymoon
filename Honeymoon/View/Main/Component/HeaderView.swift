//
//  HeaderView.swift
//  Honeymoon
//
//  Created by SHIRAISHI HIROYUKI on 2023/11/27.
//

import SwiftUI

struct HeaderView: View {
    // MARK: - プロパティー
    @Binding var isShowGuidView: Bool
    @Binding var isShowInfomation: Bool

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
            isShowInfomation.toggle()
        } label: {
            Image(systemName: "info.circle")
                .font(.system(size: 24, weight: .regular))
        }
        .sheet(isPresented: $isShowInfomation, content: {
            InfomationView()
        })
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
            isShowGuidView.toggle()
        } label: {
            Image(systemName: "questionmark.circle")
                .font(.system(size: 24, weight: .regular))
        }
        .tint(.primary)
        .sheet(isPresented: $isShowGuidView, content: {
            GuideView()
        })
    }
}

#Preview {
    HeaderView(isShowGuidView: .constant(false), isShowInfomation: .constant(false))
}
