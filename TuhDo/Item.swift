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
    var text: String
    var title: String?
    
    init(timestamp: Date, text: String = "", title: String? = nil) {
        self.timestamp = timestamp
        self.text = text
        self.title = title
    }
}
