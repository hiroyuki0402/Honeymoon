//
//  CommonHeaderView.swift
//  Honeymoon
//
//  Created by SHIRAISHI HIROYUKI on 2023/11/27.
//

import SwiftUI

struct CommonHeaderView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Capsule()
                .frame(width: 120, height: 6)
                .foregroundStyle(.secondary)
                .opacity(0.2)

            Image(.logoHoneymoon)
                .resizable()
                .scaledToFit()
                .frame(height: 28)

        }
    }
}

#Preview {
    CommonHeaderView()
}
