//
//  ViewModelsCoordinator.swift
//  Plantify
//
//  Created by lana alfaadhel on 17/02/2024.
//

import Foundation

class ViewModelCoordinator : ObservableObject {
    
    var plantCardViewModel: PlantCardViewModel
    @Published var checkCards: [CheckCard] = []

    init() {
        self.plantCardViewModel = PlantCardViewModel()
        self.plantCardViewModel.coordinator = self
    }

    func createPlantCard(PlantName : String, PlantType : PlantCardViewModel.PlantTypes, PotSize :PlantCardViewModel.PotSize , Light : PlantCardViewModel.Lighting, Watering : Int) {
        
            
        let newCheckCard = createCheckCard(PlantName: PlantName, PlantType: PlantType, watering: Watering)
            
            let newPlant = PlantCard(PlantName: PlantName, PlantType: PlantType, PotSize: PotSize, Light: Light, Watering: Watering, CheckCards: newCheckCard)
            
            plantCardViewModel.PlantCards.append(newPlant)
            print("Plant added: \(newPlant)")

            
        
    }

    func createCheckCard(PlantName : String, PlantType : PlantCardViewModel.PlantTypes, watering : Int) -> CheckCard {
        
        let newCard = CheckCard(plantName: PlantName, plantType: PlantType, watering: watering)
        
        checkCards.append(newCard)
        print("check card added \(checkCards)")
        
        return newCard
        
    }
    
    func wateringDone(checkCard : CheckCard, WateringPerWeek : Int){
        plantCardViewModel.checkWatering += 1
        print("watering progress \(plantCardViewModel.progress)")

        plantCardViewModel.progress = CGFloat(plantCardViewModel.checkWatering) / CGFloat(WateringPerWeek)
        
        print("watering progress updated \(plantCardViewModel.progress)")
        if let index = checkCards.firstIndex(of: checkCard){
            checkCards.remove(at: index)
            print("card removed\(checkCards)")
        }

        
        
    }
    
    func CircleTrim() -> CGFloat{
        
        if(plantCardViewModel.progress == 1){
            return 1
        } else{
            
            return plantCardViewModel.progress
        }
    }
    


}
