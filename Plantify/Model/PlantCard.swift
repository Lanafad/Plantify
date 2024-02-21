//
//  Plant.swift
//  Plantify
//
//  Created by lana alfaadhel on 13/02/2024.
//

//import SwiftUI

struct PlantCard : Hashable{

    var PlantName : String
    var PlantType : PlantCardViewModel.PlantTypes
    var PotSize : PlantCardViewModel.PotSize
    var Light : PlantCardViewModel.Lighting
    var Watering : Int
    var CheckCards : CheckCard
    
}

