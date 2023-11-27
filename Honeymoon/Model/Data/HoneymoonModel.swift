//
//  HoneymoonModel.swift
//  Honeymoon
//
//  Created by SHIRAISHI HIROYUKI on 2023/11/27.
//

import Foundation
import SwiftUI

struct DestinationData: Identifiable, Codable {
    var id = UUID()
    var place: String
    var country: String
    var image: String
}

typealias DestinationDatas = [DestinationData]
