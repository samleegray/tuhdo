//
//  Item.swift
//  TuhDo
//
//  Created by Samuel Gray on 1/30/24.
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
