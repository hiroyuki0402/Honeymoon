//
//  CardView.swift
//  Honeymoon
//
//  Created by SHIRAISHI HIROYUKI on 2023/11/27.
//

import SwiftUI

typealias CardViews = [CardView]

struct CardView: View, Identifiable {
    // MARK: - プロパティー
    
    var id  = UUID()
    var honeymoonData: DestinationData

    // MARK: - ボディー
    var body: some View {
        Image(honeymoonData.image)
            .resizable()
            .scaledToFit()
            .cornerRadius(24)
            .frame(minWidth: 0, maxWidth: .infinity)
            .overlay (
                VStack {
                    Text(honeymoonData.place.uppercased())
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .shadow(radius: 1)
                        .padding(.horizontal, 18)
                        .padding(.vertical, 4)
                        .overlay (
                            Rectangle()
                                .fill(.white)
                                .frame(height: 1),
                            alignment: .bottom
                        )

                    Text(honeymoonData.country.uppercased())
                        .foregroundColor(.black)
                        .font(.footnote)
                        .fontWeight(.bold)
                        .frame(minWidth: 85)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(
                            Capsule().fill(.white)
                        )
                }
                .frame(minWidth: 280)
                .padding(.bottom, 50),
                alignment: .bottom
            )
    }//: ボディー
}

#Preview {
    CardView(honeymoonData:  HoneymoonViewModel().getDestinationData(at: 0))
}
