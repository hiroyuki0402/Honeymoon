//
//  FoterModeifire.swift
//  Honeymoon
//
//  Created by SHIRAISHI HIROYUKI on 2023/12/03.
//

import Foundation
import SwiftUI

struct FooterModeifire: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(Capsule().fill(.pink))
            .foregroundStyle(.white)
    }
}
