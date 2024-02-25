//
//  PersistenceController.swift
//  Plantify
//
//  Created by lana alfaadhel on 25/02/2024.
//

import SwiftData
import Foundation

struct PersistenceController {
static let shared = PersistenceController()

var container: ModelContainer = {
    var config = ModelConfiguration(url: sharedStoreURL)
    return try! ModelContainer(for: CheckCard.self,Plant.self,PlantCard.self, configurations: config)
}()

static var sharedStoreURL: URL{
    let appGroup = "group.lana.Plantify"
    let databaseName = "Plantify.sqlite"
     let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup)!
     return container.appendingPathComponent(databaseName)
 }
}
