//
//  ContentView.swift
//  SwiftDataPractice
//
//  Created by imac-3373 on 2024/2/4.
//

import SwiftUI
import SwiftData
import Combine
//            if tests.isEmpty {
//                Text("No data")
//            } else {
//                List {
//                    ForEach(tests, id: \.self) { test in
//                        Text(test.name)
//                    }
//                }
//            }
struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Query private var datas: [DataModel]
    
    @Query private var tests: [DataModel2]
    
    @State private var oddName: String = ""
    
    @State private var newName: String = ""
    
    @State var style: String = "Fruit"
    
    @State var sort: Bool = false
    
    @State var edit: Bool = false
    
    @State private var showAdd: Bool = false
    
    @State private var showDelete: Bool = false
    
    @State private var name: String = ""
    
    @State private var quantity: String = ""
    
    @State private var calories: String = ""
    
    var body: some View {
        NavigationStack {
            Picker("", selection: $style) {
                ForEach(DataModel.Style.allCases, id: \.self) { style in
                    Text(style.rawValue)
                        .tag(style.rawValue)
                }
            }
            .buttonStyle(.bordered)
            Spacer()
            Home(style: style, sort: sort)
            .toolbar {
                // add item
                ToolbarItem(placement: .bottomBar) {
                    Button() {
                        showAdd.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .fontWeight(.light)
                            .font(.system(size: 42))
                    }
                    .alert("Add what you like to eat", isPresented: $showAdd) {
                            TextField("name", text: $name)
                            NumberTextField(text: $quantity, placeholder: "Quantity")
                            NumberTextField(text: $calories, placeholder: "Calories")
                            Button("Add", action: add)
                        Button("Cancel", role: .cancel) { }
                    }
                }
                // delete item
                ToolbarItem(placement: .bottomBar) {
                    Button() {
                        showDelete.toggle()
                    } label: {
                        Image(systemName: "trash")
                            .fontWeight(.light)
                            .font(.system(size: 42))
                    }
                    .alert("Delete what you don not like to eat", isPresented: $showDelete) {
                        TextField("name", text: $name)
                        Button("Delete", action: delete)
                        Button("Cancel", role: .cancel) { }
                    }
                }
            }
            .navigationTitle("Style List")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(leading: 
                Button() {
                    sort.toggle()
                } label: {
                    Image(systemName: "arrow.up.arrow.down")
                        .fontWeight(.light)
                        .font(.system(size: 18))
                }
            )
            .navigationBarItems(trailing:
                Button() {
                    edit.toggle()
                } label: {
                    Image(systemName: "pencil.circle.fill")
                        .fontWeight(.light)
                        .font(.system(size: 18))
                }
                .alert("Update The name", isPresented: $edit) {
                        TextField("OddName", text: $oddName)
                        TextField("NewName", text: $newName)
                        Button("Update", action: update)
                    Button("Cancel", role: .cancel) { }
                }
            )
            .onAppear {
                if datas.isEmpty {
                    initData()
                }
            }
            Spacer()
        }
    }
}

extension ContentView {
    
    func initData() {
        
        let data1 = DataModel(name: "Apple", quantity: 100, calories: 52, style: .fruit)
        let data2 = DataModel(name: "Banana", quantity: 100, calories: 89, style: .fruit)
        
        let data3 = DataModel(name: "Carrot", quantity: 100, calories: 41, style: .vegetable)
        let data4 = DataModel(name: "Broccoli", quantity: 100, calories: 34, style: .vegetable)

        let data5 = DataModel(name: "Potato Chips", quantity: 50, calories: 536, style: .snack)
        let data6 = DataModel(name: "Chocolate", quantity: 50, calories: 546, style: .snack)

        let dataModels: [DataModel] = [data1, data2, data3, data4, data5, data6]
        
        dataModels.forEach { data in
            modelContext.insert(data)
        }
    }
    
    func add() {
        
        modelContext.insert(DataModel(
            name: name,
            quantity: Int(quantity)!,
            calories: Int(calories)!,
            style: DataModel.Style(rawValue: style)!)
        )
        name = ""
        quantity = ""
        calories = ""
        
        modelContext.insert(DataModel2(name: "Test", age: 12))
    }
    
    func delete() {
        
        for data in datas {
            if data.name == name {
                modelContext.delete(data)
            }
        }
        name = ""
    }
    
    func update() {
        for data in datas {
            if data.name == oddName {
                data.name = newName
            }
        }
        oddName = ""
        newName = ""
    }
}

struct NumberTextField: View {

    @Binding var text: String // 綁定變數保持 UI 狀態一致

    var placeholder: String

    var body: some View {

        TextField(placeholder, text: $text)
            .keyboardType(.numberPad)
            .onReceive(Just(text)) { newValue in // 將 text 包裝成一個Publisher  才能使用OnReceive
                let filtered = newValue.filter { "0123456789".contains($0) }
                if filtered != newValue {
                    self.text = filtered
                }
            }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: DataModel.self, inMemory: true)
}
