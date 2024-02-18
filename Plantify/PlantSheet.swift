

//
//  ContentView.swift
//  Plantify
//
//  Created by lana alfaadhel on 13/02/2024.
//

import SwiftUI

struct PlantSheet: View {
    
    @StateObject var plantCardViewModel : PlantCardViewModel
    @StateObject var viewModelCoordinator : ViewModelCoordinator
    
    @State private var selectedType : PlantCardViewModel.PlantTypes = .none
    @State private var selectedPot : PlantCardViewModel.PotSize = .none
    @State private var selectedLight : PlantCardViewModel.Lighting = .none
    @State private var selectedName: String = ""
    @State private var selectedWatering = 0
    
    @State private var successfullyNavigation = false
    @State private var isSelected = false
    
    var isShowingSheet: Binding<Bool>


    
    var body: some View {
        VStack {

                NavigationStack {
                    ZStack{
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: 350,height: 46)
                            .foregroundColor(.cardBackground)
                        HStack{
                            Text("Name")
                            TextField("Coco “or app name!", text: $selectedName)
                        }
                        .padding()
                    }
                    
                    
                    Section(header: HStack { Text("Plant Type") }.frame(width: 350, alignment: .leading)) {plantTypeView}
                    Section(header: HStack { Text("Pot Size") }.frame(width: 350, alignment: .leading)) {plantPotView}
                    Section(header: HStack { Text("Light") }.frame(width: 350, alignment: .leading)) {plantLightView}
                    

                    ZStack{
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: 350,height: 46)
                            .foregroundColor(.cardBackground)
                        HStack{
                            Text("Watering")
                                Spacer()
                            TextField("kk", value: $selectedWatering, format: .number)
                            Text("/ week")
                        }
                        .padding()
                    }
                    
                    .navigationBarItems(
                        leading: Button("Cancel") {
                            plantCardViewModel.isShowingSheet = false
                        }.foregroundColor(.buttonsBackground),
                        
                        trailing:
                        HStack {
                            
                                Button("Add") {
                                    viewModelCoordinator.createPlantCard(PlantName: selectedName, PlantType: selectedType, PotSize: selectedPot, Light:selectedLight, Watering: selectedWatering)
                                        successfullyNavigation.toggle()
                                    }
                                .foregroundColor(.buttonsBackground)
                                .fullScreenCover(isPresented: $successfullyNavigation) {
                                    SuccessfullyView(isShowingSheet: isShowingSheet)
                                }
                            
    

                        }
                    )
                    .navigationBarTitle("Add Office Plant", displayMode: .inline)

                }
                .padding()
        }
    }
    
    
    
    private var plantTypeView : some View {
        
        LazyVGrid(columns: [
            GridItem(),
            GridItem(),
            GridItem(),
            GridItem()
            
        ] , spacing: 10, content: {
            ForEach(plantCardViewModel.types,id: \.self) { plant in
                Button {
                    selectedType = plant
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(selectedType == plant ? .buttonsBackground : .cardBackground)
                            .frame(height: 46)
                        
                        Text(plant.rawValue)
                            .font(.caption)
                            .foregroundColor(selectedType == plant ? .screenBackground : .bodyText)
                    }
                }
            }})
    }
    
    private var plantPotView : some View {
        LazyVGrid(columns: [
            GridItem(),
            GridItem(),
            GridItem(),
            GridItem()
            
        ] , spacing: 10, content: {
            ForEach(plantCardViewModel.pots,id: \.self) { pot in
                Button {
                    selectedPot = pot
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(selectedPot == pot ? .buttonsBackground : .cardBackground)
                            .frame(height: 46)
                        
                        Text(pot.rawValue)
                            .font(.caption)
                            .foregroundColor(selectedPot == pot ? .screenBackground : .bodyText)
                    }
                }
            }})

    }  
    
    private var plantLightView : some View {
        LazyVGrid(columns: [
            GridItem(),
            GridItem(),
            GridItem(),
            GridItem()
            
        ] , spacing: 10, content: {
            ForEach(plantCardViewModel.lights,id: \.self) { light in
                Button {
                    selectedLight = light
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(selectedLight == light ? .buttonsBackground : .cardBackground)
                            .frame(height: 46)
                        
                        Text(light.rawValue)
                            .font(.caption)
                            .foregroundColor(selectedLight == light ? .screenBackground : .bodyText)
                    }
                }
            }})
    }
    
    
}


