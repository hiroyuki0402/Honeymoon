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


    // MARK: - ボディー

    var body: some View {
        VStack {
            HeaderView()

            Spacer()

            CardView(honeymoonData: honeymoonViewmodel.getDestinationData(at: 1))
                .padding()

            Spacer()

            FooterView()
        }
    }//: ボディー
}

#Preview {
    MainView()
}
