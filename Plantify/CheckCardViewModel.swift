//
//  CheckCardViewModel.swift
//  Plantify
//
//  Created by lana alfaadhel on 16/02/2024.
//

import Foundation

class CheckCardViewModel: ObservableObject{
    @Published var checkCards: [CheckCard] = []

    
    func addCheckCard(plantName : String , plantType : String){
        let newCard = CheckCard(plantName: plantName, plantType: plantType)
        
        checkCards.append(newCard)
    }
    
    func wateringDone(checkCard : CheckCard){
        if let index = checkCards.firstIndex(of: checkCard){
            checkCards.remove(at: index)
        }
    }
    
    
    
}
