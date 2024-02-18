//
//  PlantViewModel.swift
//  Plantify
//
//  Created by lana alfaadhel on 13/02/2024.
//

import Foundation
import SwiftUI

class PlantCardViewModel : ObservableObject {
    
    var coordinator: ViewModelCoordinator?

    @Published var PlantCards : [PlantCard] = []
    @Published var isShowingSheet = false
    @Published var LightDictionary = [String : String]()
    @Published var PotDictionary = [String : String]()
    @Published var progress : CGFloat = 0
    @Published var checkWatering = 0
    
    @Published var types : [PlantTypes] = [.succulents, .ferns, .pothos, .palm, .peaceLilies, .ficus]
    @Published var pots : [PotSize] = [.four, .six, .ten]
    @Published var lights : [Lighting] = [.direct, .partial, .noLight]

    
    enum PlantTypes : String {
    case succulents = "Succulents"
    case ferns = "Ferns"
    case pothos = "Pothos"
    case peaceLilies = "Peace lilies"
    case ficus = "Ficus"
    case palm = "Palm"
    case none = ""
    }
    
    enum PotSize : String {
    case four = "4-6 inch"
    case six = "6-10 inch"
    case ten = "10-16 inch+"
    case none = ""
    }
    
    enum Lighting : String {
    case direct = "direct light"
    case partial = "partial light"
    case noLight = "no light"
    case none = ""
    }
    
    
    func setLightDictionary(){
        LightDictionary["Succulents,direct light"] = "Provide 6-8 hours of bright sunlight and monitor soil moisture closely."
        LightDictionary["Succulents,partial light"] = "Ensure 4-6 hours of indirect light, rotate plants for even growth."
        LightDictionary["Succulents,no light"] = "Use artificial lighting for 10-12 hours, maintain appropriate distance from plants."
        
        LightDictionary["Ferns,direct light"] = "Provide a few hours of gentle morning or late afternoon sun, monitor soil moisture closely."
        LightDictionary["Ferns,partial light"] = "Ensure bright, indirect light for a few hours each day, avoid direct sunlight."
        LightDictionary["Ferns,no light"] = "Use artificial lighting for 10-12 hours, some fern species may struggle in extremely low-light environments."
        
        LightDictionary["Pothos,direct light"] = "Provide filtered sunlight and monitor soil moisture closely."
        LightDictionary["Pothos,partial light"] = "Ensure sufficient indirect light and adjust watering frequency."
        LightDictionary["Pothos,no light"] = "Place near artificial light sources and be cautious not to overwater."
        
        LightDictionary["Peace lilies,direct light"] = "Protect from direct sunlight, provide filtered light, and monitor soil moisture closely."
        LightDictionary["Peace lilies,partial light"] = "Ensure some indirect light, avoid direct sunlight, and adjust watering accordingly."
        LightDictionary["Peace lilies,no light"] = "Provide bright, indirect artificial light sources, and ensure some exposure to promote healthy growth."
        
        LightDictionary["Ficus,direct light"] = "Protect from intense sunlight, provide filtered light, and monitor soil moisture closely."
        LightDictionary["Ficus,partial light"] = "Ensure some indirect light, supplement with artificial lighting if needed, and adjust watering accordingly."
        LightDictionary["Ficus,no light"] = "Provide artificial lighting for 10-12 hours daily, monitor soil moisture, and avoid overwatering."
        
        LightDictionary["Palm,direct light"] = "Protect from intense sunlight, provide filtered light, and monitor soil moisture closely."
        LightDictionary["Palm,partial light"] = "Ensure significant indirect light, supplement with artificial lighting if needed, and water when top inch of soil is dry."
        LightDictionary["Palm,no light"] = "Provide artificial lighting for 10-12 hours daily, adjust watering for lower light levels, and avoid overwatering."
        
    }    
    
    func setPotDictionary(){
        PotDictionary["Succulents,4-6 inch"] = "Use well-draining soil, water sparingly when soil is dry."
        PotDictionary["Succulents,6-10 inch"] = "Ensure proper drainage, water deeply but infrequently, allow soil to dry out."
        PotDictionary["Succulents,10-16 inch+"] = "Use pots with drainage, water deeply but infrequently, allow soil to almost completely dry out."
        
        PotDictionary["Ferns,4-6 inch"] = "Use well-draining potting mix, ensure proper drainage, and monitor soil moisture."
        PotDictionary["Ferns,6-10 inch"] = "Provide room for root growth, check soil moisture regularly, maintain consistently moist but not waterlogged conditions."
        PotDictionary["Ferns,10-16 inch+"] = "Ensure proper drainage, use well-draining potting mix, water deeply but infrequently, allow slight drying between waterings."
        
        PotDictionary["Pothos,4-6 inch"] = "Monitor soil moisture closely and consider repotting if necessary."
        PotDictionary["Pothos,6-10 inch"] = "Allow top inch of soil to dry between waterings and adjust frequency based on light conditions."
        PotDictionary["Pothos,10-16 inch+"] = "Adjust watering schedule for longer moisture retention and ensure proper drainage."
        
        PotDictionary["Peace lilies,4-6 inch"] = "Use well-draining pots, water when the top inch of soil is dry."
        PotDictionary["Peace lilies,6-10 inch"] = "Allow the top 1-2 inches of soil to dry between waterings, ensure proper drainage."
        PotDictionary["Peace lilies,10-16 inch+"] = "Check soil moisture regularly, water deeply when the top 2-3 inches of soil is dry, ensure proper drainage."
        
        PotDictionary["Ficus,4-6 inch"] = "Use well-draining pots, water thoroughly but allow the soil to partially dry between waterings."
        PotDictionary["Ficus,6-10 inch"] = "Allow the soil to partially dry out between waterings, ensure proper drainage."
        PotDictionary["Ficus,10-16 inch+"] = "Check soil moisture regularly, water deeply but infrequently, ensure proper drainage."
        
        PotDictionary["Palm,4-6 inch"] = "Use well-draining pots, water thoroughly but allow soil to slightly dry between waterings."
        PotDictionary["Palm,6-10 inch"] = "Allow soil to partially dry between waterings, ensure proper drainage."
        PotDictionary["Palm,10-16 inch+"] = "Check soil moisture regularly, water deeply but infrequently, ensure proper drainage."
            }
    
    func getLightAdvice(plantType : String, plantLight : String) -> String? {
        let key = ("\(plantType),\(plantLight)")
        
        return LightDictionary[key]


    }    
    
    func getPottAdvice(plantType : String, plantPot : String) -> String? {
        let key = ("\(plantType),\(plantPot)")

        return PotDictionary[key]

    }
    
    func wateringSchedule(watering : Int) -> [Int]{
        var arr = [0]
        switch watering{
        case 1:
            arr.append(1)
            return arr
            
        case 2:
            let T = [1,4]
            arr.append(contentsOf: T)
            return arr        
        
        case 3:
            let T = [2,4,6]
            arr.append(contentsOf: T)
            return arr        
        
        case 4:
            let T = [1,3,5,7]
            arr.append(contentsOf: T)
            return arr        
        
        case 5:
            let T = [1,3,4,5,7]
            arr.append(contentsOf: T)
            return arr        
        
        case 6:
            let T = [1,2,3,4,5,6]
            arr.append(contentsOf: T)
            return arr        
        
        case 7:
            let T = [1,2,3,4,5,6,7]
            arr.append(contentsOf: T)
            return arr

     
        default:
            return arr
        }
        
    }
    
    func isToday(_ array: [Int]) -> Bool{
        let calendar = Calendar.current
        let today = Date()
        let weekday = calendar.component(.weekday, from: today)
        
        return array.contains(weekday)
    }
    

    
    

}

