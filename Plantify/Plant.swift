//
//  Plant.swift
//  Plantify
//
//  Created by lana alfaadhel on 23/02/2024.
//


import Foundation
import SwiftData

@Model
class Plant: Hashable {
    
    var PlantName : String
    var PlantType : MainView.PlantTypes
    var PotSize : MainView.PotSize
    var Light : MainView.Lighting
    var Watering : Int
    var PlantCard : PlantCard
    var CheckCards : [CheckCard]
    
    init(PlantName: String, PlantType: MainView.PlantTypes, PotSize: MainView.PotSize, Light: MainView.Lighting, Watering: Int, PlantCard: PlantCard, CheckCards: [CheckCard]) {
        self.PlantName = PlantName
        self.PlantType = PlantType
        self.PotSize = PotSize
        self.Light = Light
        self.Watering = Watering
        self.PlantCard = PlantCard
        self.CheckCards = CheckCards
    }
    
    
    
}

