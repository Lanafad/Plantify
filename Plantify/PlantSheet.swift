//
//  PlantSheet.swift
//  Plantify
//
//  Created by lana alfaadhel on 14/02/2024.
//

import SwiftUI

struct PlantSheet: View {
    
    @StateObject var plantCardViewModel : PlantCardViewModel
    @StateObject var checkCardViewModel : CheckCardViewModel
    @State var planttype = ""
    @State var plantlight = ""
    @State var plantpot = ""

    var body: some View {
        VStack{
            
            
            Button(action: {
                print("Adding plant...")
                    plantCardViewModel.addPlant(PlantName: "voo", PlantType: "Succulents", PotSize: "4-6 inch", Light: "direct light", Watering: 8)
                    print("Plant added.")
                    plantCardViewModel.isShowingSheet = false
            }, label: {
                Text("Button")
            
            })
            
        }
    }
}

