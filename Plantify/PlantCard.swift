//
//  Plant.swift
//  Plantify
//
//  Created by lana alfaadhel on 13/02/2024.
//
import Foundation
import SwiftData

@Model
class PlantCard : Hashable{

    var PlantName : String
    var PlantType : MainView.PlantTypes
    var PotSize : MainView.PotSize
    var Light : MainView.Lighting
    var Watering : Int
    
    init(PlantName: String, PlantType: MainView.PlantTypes, PotSize: MainView.PotSize, Light: MainView.Lighting, Watering: Int) {
        self.PlantName = PlantName
        self.PlantType = PlantType
        self.PotSize = PotSize
        self.Light = Light
        self.Watering = Watering
    }
    
}
