//
//  TitleModeifire.swift
//  Honeymoon
//
//  Created by SHIRAISHI HIROYUKI on 2023/12/03.
//

import Foundation
import SwiftUI

struct TitleModeifire: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.pink)
    }
}
