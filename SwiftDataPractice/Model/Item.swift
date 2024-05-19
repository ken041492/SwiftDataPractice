//
//  Item.swift
//  SwiftDataPractice
//
//  Created by imac-3373 on 2024/2/4.
//

import Foundation
import SwiftData


@Model
class DataModel2 {
    var name: String
    
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        
        self.age = age
    }
}

@Model
class DataModel {

    var style: Style.RawValue
    
    var name: String

    var quantity: Int

    var calories: Int

    init(
        name: String,
        quantity: Int,
        calories: Int,
        style: Style
    ) {
        self.name = name
        self.quantity = quantity
        self.calories = calories
        self.style = style.rawValue
    }
    
    enum Style: String, CaseIterable {
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
