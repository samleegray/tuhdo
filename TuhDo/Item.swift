//
//  Item.swift
//  TuhDo
//
//  Created by Samuel Gray on 1/30/24.
//

import Foundation
import SwiftData
import CoreLocation

typealias Item = ItemSchemaV7.Item

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

enum ItemSchemaV4: VersionedSchema {
    static var versionIdentifier: Schema.Version = Schema.Version(4, 0, 0)
    static var models: [any PersistentModel.Type] {
        [Item.self]
    }
    
    @Model
    final class Item {
        @Attribute(.unique) let id: UUID
        var createdDate: Date
        var lastUpdatedDate: Date
        var text: String
        var title: String?
        var latitude: CLLocationDegrees?
        var longitude: CLLocationDegrees?
        
        init(id: UUID = UUID(), createdDate: Date = Date.now, lastUpdatedDate: Date = Date.now, text: String = "", title: String? = nil, location: CLLocation? = nil) {
            self.id = id
            self.createdDate = createdDate
            self.lastUpdatedDate = lastUpdatedDate
            self.text = text
            self.title = title
            self.latitude = location?.coordinate.latitude
            self.longitude = location?.coordinate.longitude
        }
    }
}

enum ItemSchemaV5: VersionedSchema {
    static var versionIdentifier: Schema.Version = Schema.Version(5, 0, 0)
    static var models: [any PersistentModel.Type] {
        [Item.self]
    }
    
    @Model
    final class Item {
        @Attribute(.unique) let id: UUID
        var createdDate: Date
        var lastUpdatedDate: Date
        @Attribute(originalName: "text") var notes: String
        var title: String?
        var latitude: CLLocationDegrees?
        var longitude: CLLocationDegrees?
        
        init(id: UUID = UUID(), createdDate: Date = Date.now, lastUpdatedDate: Date = Date.now, notes: String = "", title: String? = nil, location: CLLocation? = nil) {
            self.id = id
            self.createdDate = createdDate
            self.lastUpdatedDate = lastUpdatedDate
            self.notes = notes
            self.title = title
            self.latitude = location?.coordinate.latitude
            self.longitude = location?.coordinate.longitude
        }
    }
}

enum ItemSchemaV6: VersionedSchema {
    static var versionIdentifier: Schema.Version = Schema.Version(6, 0, 0)
    static var models: [any PersistentModel.Type] {
        [Item.self]
    }
    
    @Model
    final class Item {
        @Attribute(.unique) let id: UUID
        var createdDate: Date
        var lastUpdatedDate: Date
        var lastActionTakenDate: Date
        var notes: String
        var title: String?
        var latitude: CLLocationDegrees?
        var longitude: CLLocationDegrees?
        
        init(id: UUID = UUID(), createdDate: Date = Date.now, lastUpdatedDate: Date = Date.now, lastActionTakenDate: Date = Date.now, notes: String = "", title: String? = nil, location: CLLocation? = nil) {
            self.id = id
            self.createdDate = createdDate
            self.lastUpdatedDate = lastUpdatedDate
            self.lastActionTakenDate = lastActionTakenDate
            self.notes = notes
            self.title = title
            self.latitude = location?.coordinate.latitude
            self.longitude = location?.coordinate.longitude
        }
    }
}

enum ItemSchemaV7: VersionedSchema {
    static var versionIdentifier: Schema.Version = Schema.Version(7, 0, 0)
    static var models: [any PersistentModel.Type] {
        [Item.self]
    }
    
    enum Priority: Codable {
        case none
        case low
        case mid
        case high
        case emergency
    }
    
    @Model
    final class Item {
        @Attribute(.unique) let id: UUID
        var createdDate: Date
        var lastUpdatedDate: Date
        var lastActionTakenDate: Date
        var dueDate: Date?
        var reminderTimes: [Date]?
        var priority: Priority = Priority.none
        var notes: String
        var title: String?
        var latitude: CLLocationDegrees?
        var longitude: CLLocationDegrees?
        
        init(id: UUID = UUID(), createdDate: Date = Date.now, lastUpdatedDate: Date = Date.now, lastActionTakenDate: Date = Date.now, notes: String = "", title: String? = nil, location: CLLocation? = nil, priority: Priority = .none) {
            self.id = id
            self.createdDate = createdDate
            self.lastUpdatedDate = lastUpdatedDate
            self.lastActionTakenDate = lastActionTakenDate
            self.priority = priority
            self.notes = notes
            self.title = title
            self.latitude = location?.coordinate.latitude
            self.longitude = location?.coordinate.longitude
        }
    }
}

enum ItemMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [ItemSchemaV1.self, ItemSchemaV2.self, 
         ItemSchemaV3.self, ItemSchemaV4.self,
         ItemSchemaV5.self, ItemSchemaV6.self,
         ItemSchemaV7.self]
    }
    
    static var stages: [MigrationStage] {
        [migrateV1toV2,
        migrateV2toV3,
        migrateV3toV4,
        migrateV4toV5,
        migrateV5toV6,
        migrateV6toV7]
    }
    
    static let migrateV1toV2 = MigrationStage.lightweight(
        fromVersion: ItemSchemaV1.self, toVersion: ItemSchemaV2.self)
    static let migrateV2toV3 = MigrationStage.lightweight(
        fromVersion: ItemSchemaV2.self, toVersion: ItemSchemaV3.self)
    static let migrateV3toV4 = MigrationStage.lightweight(
        fromVersion: ItemSchemaV3.self, toVersion: ItemSchemaV4.self)
    static let migrateV4toV5 = MigrationStage.lightweight(
        fromVersion: ItemSchemaV4.self, toVersion: ItemSchemaV5.self)
    static let migrateV5toV6 = MigrationStage.custom(
        fromVersion: ItemSchemaV5.self, toVersion: ItemSchemaV6.self, willMigrate: { context in
            let items = try context.fetch(FetchDescriptor<ItemSchemaV5.Item>())
            
            for item in items {
                let newItem = ItemSchemaV6.Item(createdDate: item.createdDate,
                                                lastUpdatedDate: item.createdDate,
                                                lastActionTakenDate: item.createdDate,
                                                notes: item.notes,
                                                title: item.title,
                                                location: CLLocation(latitude: 0, longitude: 0))
                
                context.delete(item)
                context.insert(newItem)
            }
            
            try context.save()
        }, didMigrate: nil)
    static let migrateV6toV7 = MigrationStage.custom(
        fromVersion: ItemSchemaV6.self, toVersion: ItemSchemaV7.self, willMigrate: nil, didMigrate: nil)
    
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
