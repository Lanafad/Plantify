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
    @State var plantname = ""
    @State var plantwatering = 0

    var body: some View {
        VStack{
            
            

 

            VStack{
                TextField(text:  $plantname, label: {
                    Text("name")
                })                
                
                TextField(text:  $planttype, label: {
                    Text("type")
                })
                
                TextField(text:  $plantlight, label: {
                    Text("light")
                })
                
                TextField(text:  $plantpot, label: {
                    Text("pot")
                })

                
                TextField(value: $plantwatering, format: .number, label: {
                    Text("watering")
                })
                 
                
            }
                    VStack{

//                        Picker("mm", selection: $planttype){
//
//                            ForEach(plantCardViewModel.PlantTypesArray.indices){ index in
//                                Text(plantCardViewModel.PlantTypesArray[index])
//                            }
//                        }
//
//                        Picker( "mm", selection: $plantlight  , content: {
//
//                            ForEach(plantCardViewModel.LightingArray.indices){ index in
//                                Text(plantCardViewModel.LightingArray[index])
//                            }
//                        })
//
//                        Picker( "mm", selection: $plantpot  , content: {
//
//                            ForEach(plantCardViewModel.PotSizeArray.indices){ index in
//                                Text(plantCardViewModel.PotSizeArray[index])
//                            }
//
//                    }
//                                )
                }

            
                        Button(action: {
                            print("Adding plant...")
                            viewModelCoordinator.createPlantCard(PlantName: plantname, PlantType: planttype, PotSize: plantpot, Light: plantlight, Watering: plantwatering)
                                print("Plant added.")
                                plantCardViewModel.isShowingSheet = false
                        }, label: {
                            Text("Button")
            
                        })
        }
    }
}

