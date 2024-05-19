//
//  SwiftDataPracticeApp.swift
//  SwiftDataPractice
//
//  Created by imac-3373 on 2024/2/4.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataPracticeApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [DataModel.self, DataModel2.self])
    }
}
