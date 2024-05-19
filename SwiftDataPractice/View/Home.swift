//
//  Home.swift
//  SwiftDataPractice
//
//  Created by imac-3373 on 2024/2/5.
//

import SwiftUI
import SwiftData
import Charts

struct Home: View {
    
    @Environment(\.modelContext) private var modelContext
        
    @Query private var datas: [DataModel]
    
    private let fruitColors: [Color] = [.red, .orange, .yellow]
    private let vegetableColors: [Color] = [.green, .mint, .teal]
    private let snackColors: [Color] = [.blue, .purple, .indigo]
    
    var style: String
    
    var sort: Bool
    
    private var chartColors: [Color] {
        switch style {
        case "Fruit":
            return self.fruitColors
        case "Vegetable":
            return self.vegetableColors
        case "Snack":
            return self.snackColors
        default:
            return []
        }
    }
    
    init(style: String, sort: Bool) {
        self.style = style
        self.sort = sort
        
        let predicate = #Predicate<DataModel> { data in
            data.style == style
        }
        
        var sortDescriptor: [SortDescriptor<DataModel>] {
            if sort {
                return [SortDescriptor(\DataModel.name)]
            } else {
                return [SortDescriptor(\DataModel.name, order: .reverse)]
            }
        }
        _datas = Query(filter: predicate, sort: sortDescriptor)
    }
    
    var body: some View {
        
        if datas.isEmpty {
            Text("No data")
        } else {
            Chart(datas, id: \.name) { data in
                SectorMark(
                    angle: .value("Value", data.quantity),
                    innerRadius: .ratio(0.618),
                    outerRadius: 120
                )
                .cornerRadius(5) // 扇形圓角
                .foregroundStyle(by: .value("Product category", data.name))
                .opacity(1)
            }
            .frame(minHeight: 0,maxHeight: 300)
            .chartLegend(alignment: .center)
            .fontWidth(.expanded)
            .chartForegroundStyleScale(domain: .automatic, range: chartColors)
        }
    }
}
