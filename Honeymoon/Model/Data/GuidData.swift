//
//  GuidData.swift
//  Honeymoon
//
//  Created by SHIRAISHI HIROYUKI on 2023/11/27.
//

import Foundation

struct GuidData: Identifiable, Codable {
    var id = UUID()
    var title: String
    var subTitle: String
    var description: String
    var image: String
}

typealias GuidDatas = [GuidData]
