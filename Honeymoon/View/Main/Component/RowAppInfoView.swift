//
//  RowAppInfoView.swift
//  Honeymoon
//
//  Created by SHIRAISHI HIROYUKI on 2023/12/03.
//

import SwiftUI

struct RowAppInfoView: View {
    // MARK: - プロパティー
    var leftItem: String
    var rightItem: String

    // MARK: - ボディー

    var body: some View {
            HStack {
                Text(leftItem)
                    .foregroundStyle(.gray)

                Spacer(minLength: 10)

                Text(rightItem)
            }
    }//: ボディー
}

#Preview {
    RowAppInfoView(leftItem: "Application", rightItem: "Honeymoon")
}
