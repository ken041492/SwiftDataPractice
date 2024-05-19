//
//  ContentView.swift
//  SwiftDataPractice
//
//  Created by imac-3373 on 2024/2/4.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Query private var datas: [DataModel]

    var body: some View {
        Home()
    }

    
    
}

#Preview {
    ContentView()
        .modelContainer(for: DataModel.self, inMemory: true)
}
