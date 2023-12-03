//
//  HoneymoonApp.swift
//  Honeymoon
//
//  Created by SHIRAISHI HIROYUKI on 2023/11/24.
//

import SwiftUI

@main
struct HoneymoonApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
