//
//  PlantSheet.swift
//  Plantify
//
//  Created by lana alfaadhel on 14/02/2024.
//

import SwiftUI

struct PlantSheet: View {
    
    @ObservedObject var plantCardViewModel : PlantCardViewModel
    @State  var PickerSelection : String

    var body: some View {
        ZStack{
            
            Button(action: {}, label: {
                Text("Button")
            })
            
            Picker( "mm", selection: $PickerSelection  , content: {
                
                ForEach(plantCardViewModel.PlantTypesArray.indices){ index in
                    Text(plantCardViewModel.PlantTypesArray[index])
                }
            })           
            
            Picker( "mm", selection: $PickerSelection  , content: {
                
                ForEach(plantCardViewModel.LightingArray.indices){ index in
                    Text(plantCardViewModel.LightingArray[index])
                }
            })           
            
            Picker( "mm", selection: $PickerSelection  , content: {
                
                ForEach(plantCardViewModel.PotSizeArray.indices){ index in
                    Text(plantCardViewModel.PotSizeArray[index])
                }
            })
            
        }
    }
}
//
//#Preview {
//    PlantSheet()
//}
