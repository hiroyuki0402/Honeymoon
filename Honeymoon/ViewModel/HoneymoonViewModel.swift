//
//  HoneymoonViewModel.swift
//  Honeymoon
//
//  Created by SHIRAISHI HIROYUKI on 2023/11/27.
//

import Foundation

class HoneymoonViewModel: ObservableObject {
    @Published var destinationDatas: DestinationDatas = []

    init() {
        destinationDatas = TestData.shared.honeymoonTestData
    }

    func getDestinationData(at index: Int) -> DestinationData {
        return destinationDatas[index]
    }
}
