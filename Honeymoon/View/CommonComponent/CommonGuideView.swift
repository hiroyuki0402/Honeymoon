//
//  CommonGuideView.swift
//  Honeymoon
//
//  Created by SHIRAISHI HIROYUKI on 2023/11/27.
//

import SwiftUI

struct CommonGuideView: View {
    // MARK: - プロパティー
    var guidData: GuidData

    // MARK: - ボディー
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Image(systemName: guidData.image)
                .font(.largeTitle)
                .foregroundStyle(.pink)

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(guidData.title.uppercased())
                        .font(.title)
                        .fontWeight(.heavy)

                    Spacer()

                    Text(guidData.subTitle.uppercased())
                        .font(.footnote)
                        .fontWeight(.heavy)
                        .foregroundStyle(.pink)
                        .fixedSize(horizontal: false, vertical: true)
                }

                Divider()
                    .padding(.bottom, 4)

                Text(guidData.description)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

        }
    }//: ボディー
}

#Preview {
    CommonGuideView(guidData: TestData.shared.guidTestData[0])
}
