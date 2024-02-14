//
//  PlantSheet.swift
//  Plantify
//
//  Created by lana alfaadhel on 14/02/2024.
//

import SwiftUI

struct PlantSheet: View {
    
    @ObservedObject var plantCardViewModel : PlantCardViewModel
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
//
//            
//            Picker( "mm", selection: $planttype  , content: {
//                
//                ForEach(plantCardViewModel.PlantTypesArray.indices){ index in
//                    Text(plantCardViewModel.PlantTypesArray[index])
//                }
//            })   
//            
//            
//            Picker( "mm", selection: $plantlight  , content: {
//                
//                ForEach(plantCardViewModel.LightingArray.indices){ index in
//                    Text(plantCardViewModel.LightingArray[index])
//                }
//            })   
//            
//            
//            Picker( "mm", selection: $plantpot  , content: {
//                
//                ForEach(plantCardViewModel.PotSizeArray.indices){ index in
//                    Text(plantCardViewModel.PotSizeArray[index])
//                }
//            })
//            
//            
//            Button(action: {
//                
//                plantCardViewModel.addPlant(PlantName: planttype, PlantType: planttype, PotSize: plantpot, Light: plantlight, Watering: 4)
//                plantCardViewModel.isShowingSheet = false
//                
//            }, label: {
//                Text("Button")
//            })
            
        }
    }
}
//
//#Preview {
//    PlantSheet()
//}
