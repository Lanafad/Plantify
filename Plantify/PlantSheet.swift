//
//  PlantSheet.swift
//  Plantify
//
//  Created by lana alfaadhel on 14/02/2024.
//

import SwiftUI

struct PlantSheet: View {
    
    @StateObject var plantCardViewModel : PlantCardViewModel    
    @StateObject var viewModelCoordinator : ViewModelCoordinator
    @State var planttype = ""
    @State var plantlight = ""
    @State var plantpot = ""

    var body: some View {
        VStack{
            
            
            Button(action: {
                print("Adding plant...")
                viewModelCoordinator.createPlantCard(PlantName: "b", PlantType: "c", PotSize: "4-6 d", Light: "direct e", Watering: 4)
                    print("Plant added.")
                    plantCardViewModel.isShowingSheet = false
            }, label: {
                Text("Button")
            
            })
            
        }
    }
}

