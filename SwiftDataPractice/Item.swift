//
//  Item.swift
//  SwiftDataPractice
//
//  Created by imac-3373 on 2024/2/4.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
