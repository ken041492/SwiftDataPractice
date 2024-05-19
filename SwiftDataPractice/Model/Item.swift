//
//  Item.swift
//  SwiftDataPractice
//
//  Created by imac-3373 on 2024/2/4.
//

import Foundation
import SwiftData


@Model
class DataModel {

    var style: Style = Style.fruit
    
    var name: String

    var quantity: Double

    var calories: Int

    init(
        name: String,
        quantity: Double,
        calories: Int,
        style: Style
    ) {
        self.name = name
        self.quantity = quantity
        self.calories = calories
        self.style = style
    }
    
    enum Style: String, Codable, CaseIterable {
        case fruit = "Fruit"
        case vegetable = "Vegetable"
        case snack = "Snack"
        
        var style: String {
            switch self {
                case .fruit:
                    return "Fruit"
                case .vegetable:
                    return "Vegetable"
                case .snack:
                    return "Snack"
            }
        }
    }
}
