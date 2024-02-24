//
//  PlantifyApp.swift
//  Plantify
//
//  Created by lana alfaadhel on 13/02/2024.
//

import SwiftUI
import SwiftData

@main
struct PlantifyApp: App {
    
    let container : ModelContainer = {
        let schema = Schema([Plant.self, PlantCard.self, CheckCard.self])
        let config = ModelConfiguration("group.lana.Plantify")
        let container = try! ModelContainer(for: schema, configurations: [config])
        return container
    }()
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(container)

    }
}
