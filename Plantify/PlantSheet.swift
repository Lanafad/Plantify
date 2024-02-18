

//
//  ContentView.swift
//  Plantify
//
//  Created by lana alfaadhel on 13/02/2024.
//

import SwiftUI

//enum PlanetType : String {
//case succulents = "Succulents"
//case ferns = "Ferns"
//case none = ""
//}

struct PlantSheet: View {
    
    @StateObject var plantCardViewModel : PlantCardViewModel
    @StateObject var viewModelCoordinator : ViewModelCoordinator

    
//    @State private var showingSheet = false
    @State private var Option: String = ""
    @State private var numberInput = 0
    @State private var SucculentsSelected = false
    @State private var FernsSelected = false
    @State private var PothosSelected = false
    @State private var PlamSelected = false
    @State private var PeaceliliesSelected = false
    @State private var FicusSelected = false
    @State private var PotSize1Selected = false
    @State private var PotSize2Selected = false
    @State private var PotSize3Selected = false
    @State private var DirectlightSelected = false
    @State private var PartiallightSelected = false
    @State private var noLightSelected = false
    @State private var isSuccessfullyNavigated = false
    @State private var PlantName: String = ""
    
    
    @State private var selectedType : PlantCardViewModel.PlantTypes = .none
    @State private var selectedPot : PlantCardViewModel.PotSize = .none
    @State private var selectedLight : PlantCardViewModel.Lighting = .none
    
    
    var body: some View {
        VStack {
//            Button("Show Sheet") {
//                showingSheet.toggle()
//            }
//            .sheet(isPresented: $plantCardViewModel.isShowingSheet) {
                NavigationStack {
                    ZStack{
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: 350,height: 46)
                            .foregroundColor(.cardBackground)
                        HStack{
                            Text("Name")
                            TextField("Coco “or app name!", text: $PlantName)
                        }
                        .padding()
                    }
                    
                    
                    Section(header:
                        HStack {
                            Text("Plant Type")
                            Spacer()
                        }) {
                        plantTypeView
                        .padding() }
                    
                        .padding()
                    
                    Section(header:
                                HStack {
                                    Text("Pot Size")
                                    Spacer()
                                }) {
                                plantPotView
                                        .padding()}
                                .padding()

                    Section(header:
                                HStack {
                                    Text("Light")
                                    Spacer()
                                }) {
                                    plantLightView
                                        .padding()}
                                .padding()

                    ZStack{
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: 350,height: 46)
                            .foregroundColor(.cardBackground)
                        HStack{
                            Text("Watering")
                                Spacer()
                            TextField("kk", value: $numberInput, format: .number)
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
                                // Add button action
                                // You can perform any action here when Add is tapped
                                viewModelCoordinator.createPlantCard(PlantName: PlantName, PlantType: selectedType, PotSize: selectedPot, Light: selectedLight, Watering: numberInput)
                                plantCardViewModel.isShowingSheet = false
                                isSuccessfullyNavigated = true
                            }.foregroundColor(.buttonsBackground)
                            .background(
                                //NavigationLink(destination: SuccessfullyView(), isActive: $isSuccessfullyNavigated) { EmptyView() }
                            )
                        }
                    )
                    .navigationBarTitle("Add Office Plant", displayMode: .inline)

                }
                .padding()
//            }
        }
    }
    
    
    
    private var plantTypeView : some View {
//        VStack(alignment: .leading){
            LazyVGrid(columns: [
                
                GridItem(),
                GridItem(),
                GridItem(),
                GridItem()
                            
                            
                            
                            ], spacing: -5, content: {
                ForEach(plantCardViewModel.types,id: \.self) { plant in
                    Button {
                        selectedType = plant
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
                            
                            
                        }

                    }
                    
                    
                }
            }
            )

//        }
    }
    
    private var plantPotView : some View {
        VStack(alignment: .leading){
            LazyHGrid(rows: [GridItem(.fixed(20))], spacing: 12, content: {
                ForEach(plantCardViewModel.pots,id: \.self) { pot in
                    Button {
                        selectedPot = pot
                    } label: {
                        Text(pot.rawValue)
                            .padding()
//                            .background(.red)
//                        VStack {
//                            Text(title)
                                .frame(height: 46)
                                .font(.headline)
                                .foregroundColor(/*isSelected ? Color.screenBackground :*/Color.bodyText)
                                .padding(8)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundColor(/*isSelected ? Color.buttonsBackground : */Color.cardBackground)
                                )
//                        }
                    }
                }
            })

        }
    }  
    
    private var plantLightView : some View {
        VStack(alignment: .leading){
            LazyHGrid(rows: [GridItem(.fixed(20))], spacing: 12, content: {
                ForEach(plantCardViewModel.lights,id: \.self) { light in
                    Button {
                        selectedLight = light
                    } label: {
                        Text(light.rawValue)
                            .padding()
//                            .background(.red)
//                        VStack {
//                            Text(title)
                                .frame(height: 46)
                                .font(.headline)
                                .foregroundColor(/*isSelected ? Color.screenBackground :*/Color.bodyText)
                                .padding(8)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundColor(/*isSelected ? Color.buttonsBackground : */Color.cardBackground)
                                )
//                        }
                    }
                }
            })

        }
    }
    
    
}

struct OptionButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Text(title)
                    .frame(height: 46)
                    .font(.headline)
                    .foregroundColor(isSelected ? Color.screenBackground :Color.bodyText)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(isSelected ? Color.buttonsBackground : Color.cardBackground)
                    )
            }
        }
    }
}



//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlantSheet()
//    }
//}
