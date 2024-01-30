//
//  Item.swift
//  TuhDo
//
//  Created by Samuel Gray on 1/30/24.
//

import Foundation
import SwiftData
import CoreLocation

typealias Item = ItemSchemaV2.Item

enum ItemSchemaV1: VersionedSchema {
    static var versionIdentifier: Schema.Version = Schema.Version(1, 0, 0)
    static var models: [any PersistentModel.Type] {
        [Item.self]
    }
    
    @Model
    final class Item {
        var timestamp: Date
        var text: String
        var title: String?
    //    var latitude: CLLocationDegrees?
    //    var longitude: CLLocationDegrees?
        
        init(timestamp: Date, text: String = "", title: String? = nil, location: CLLocation? = nil) {
            self.timestamp = timestamp
            self.text = text
            self.title = title
    //        self.latitude = location?.coordinate.latitude
    //        self.longitude = location?.coordinate.longitude
        }
    }
}

enum ItemSchemaV2: VersionedSchema {
    static var versionIdentifier: Schema.Version = Schema.Version(2, 0, 0)
    static var models: [any PersistentModel.Type] {
        [Item.self]
    }
    
    @Model
    final class Item {
        var timestamp: Date = Date.now
        @Attribute(originalName: "timestamp") var createdDate: Date
        var lastUpdatedDate: Date
        var text: String
        var title: String?
        var latitude: CLLocationDegrees?
        var longitude: CLLocationDegrees?
        
        init(createdDate: Date = Date.now, lastUpdatedDate: Date = Date.now, text: String = "", title: String? = nil, location: CLLocation? = nil) {
            self.createdDate = createdDate
            self.lastUpdatedDate = lastUpdatedDate
            self.text = text
            self.title = title
            self.latitude = location?.coordinate.latitude
            self.longitude = location?.coordinate.longitude
        }
    }
}

enum ItemSchemaV3: VersionedSchema {
    static var versionIdentifier: Schema.Version = Schema.Version(3, 0, 0)
    static var models: [any PersistentModel.Type] {
        [Item.self]
    }
    
    @Model
    final class Item {
        var createdDate: Date
        var lastUpdatedDate: Date
        var text: String
        var title: String?
        var latitude: CLLocationDegrees?
        var longitude: CLLocationDegrees?
        
        init(createdDate: Date = Date.now, lastUpdatedDate: Date = Date.now, text: String = "", title: String? = nil, location: CLLocation? = nil) {
            self.createdDate = createdDate
            self.lastUpdatedDate = lastUpdatedDate
            self.text = text
            self.title = title
            self.latitude = location?.coordinate.latitude
            self.longitude = location?.coordinate.longitude
        }
    }
}

enum ItemMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [ItemSchemaV1.self, ItemSchemaV2.self, ItemSchemaV3.self]
    }
    
    static var stages: [MigrationStage] {
        [migrateV1toV2]
    }
    
    static let migrateV1toV2 = MigrationStage.lightweight(
        fromVersion: ItemSchemaV1.self, toVersion: ItemSchemaV3.self)
    
//    static let migrateV1toV2 = MigrationStage.custom(fromVersion: ItemSchemaV1.self,
//                                                     toVersion: ItemSchemaV2.self,
//                                                     willMigrate: { context in
//        let items = try context.fetch(FetchDescriptor<ItemSchemaV1.Item>())
//        
//        for item in items {
//            let newItem = ItemSchemaV2.Item(createdDate: item.timestamp, lastUpdatedDate: item.timestamp, text: item.text, title: item.title, location: CLLocation(latitude: 0, longitude: 0))
//            
//            context.delete(item)
//            context.insert(newItem)
//        }
//        
//        try context.save()
//    }, didMigrate: nil)
}
