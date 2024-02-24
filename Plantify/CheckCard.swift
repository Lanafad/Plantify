//
//  CheckCard.swift
//  Plantify
//
//  Created by lana alfaadhel on 23/02/2024.
//

import Foundation
import SwiftData

@Model
class CheckCard : Hashable {

    var plantName : String
    var plantType : MainView.PlantTypes
    var watering : Int
    

    init(plantName: String, plantType: MainView.PlantTypes, watering: Int) {
        self.plantName = plantName
        self.plantType = plantType
        self.watering = watering
    }
}

