//
//  FooterView.swift
//  Honeymoon
//
//  Created by SHIRAISHI HIROYUKI on 2023/11/27.
//

import SwiftUI

struct FooterView: View {
    // MARK: - プロパティー
    @Binding var isShowBookingAlert: Bool

    // MARK: - ボディー
    var body: some View {
        HStack {
            noneImageView

            Spacer()

            bookDestination

            Spacer()

            likeImageView
        }
        .padding()
    }//: ボディー
}

// MARK: - FooterViewアイテム

private extension FooterView {

    /// バツ
    private var noneImageView: some View {
        Image(systemName: "xmark.circle")
            .font(.system(size: 24, weight: .regular))
    }

    private var bookDestination: some View {
        Button {
            isShowBookingAlert.toggle()
        } label: {
            Text("お気に入りを予約する")
                .font(.system(.subheadline, design: .rounded))
                .fontWeight(.heavy)
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .tint(.pink)
                .background(
                    Capsule()
                        .stroke(Color.pink, lineWidth: 2)
                )
        }
    }

    /// LIke
    private var likeImageView: some View {
        Image(systemName: "heart.circle")
            .font(.system(size: 24, weight: .regular))
    }
}

#Preview {
    FooterView(isShowBookingAlert: .constant(false))
}
