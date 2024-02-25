//
//  PlantifyAppIntent.swift
//  PlantifyWidgetExtension
//
//  Created by lana alfaadhel on 25/02/2024.
//

import AppIntents
import SwiftData

struct PlantifyAppIntent : AppIntent{

    
    let container = PersistenceController.shared.container


    static var title: LocalizedStringResource = "Check Cards"
    static var description: IntentDescription? = "Checks the watering Cards"
    
    @Parameter(title: "Check Cards Name") var CheckCardName : String
    
    init(CheckCardName: String) {
        self.CheckCardName = CheckCardName
    }
    init() {
        CheckCardName = ""
    }
    
    func perform() async throws -> some IntentResult {
        
        let descriptor = FetchDescriptor<CheckCard>(predicate: #Predicate { checkCard in
            checkCard.plantName == CheckCardName
            })
        var checkCards = try? await container.mainContext.fetch(descriptor)
        
        if let checkCard = checkCards?.first{
            checkCards?.removeFirst()
        }
        
        return .result()
    }
}
