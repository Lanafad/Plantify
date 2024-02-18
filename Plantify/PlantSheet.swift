

//
//  ContentView.swift
//  Plantify
//
//  Created by lana alfaadhel on 13/02/2024.
//

import SwiftUI

struct PlantSheet: View {
    @State private var showingSheet = false
    @State private var Option: String = ""
    @State private var numberInput: String = ""
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

    var body: some View {
        VStack {
            Button("Show Sheet") {
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) {
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
                        }
                    )
                    {
                        VStack(alignment: .leading){
                            HStack(spacing: 10) {
                                OptionButton(title: "Succulents", isSelected: SucculentsSelected) {
                                    SucculentsSelected.toggle()
                                    FernsSelected = false
                                    PothosSelected = false
                                    PlamSelected = false
                                    PeaceliliesSelected = false
                                    FicusSelected = false
                                    if SucculentsSelected {
                                        Option = "Succulents"
                                    } else {
                                        Option = ""
                                    }
                                }
                                OptionButton(title: "Ferns", isSelected: FernsSelected) {
                                    FernsSelected.toggle()
                                    SucculentsSelected = false
                                    PothosSelected = false
                                    PlamSelected = false
                                    PeaceliliesSelected = false
                                    FicusSelected = false
                                    if FernsSelected {
                                        Option = "Ferns"
                                    } else {
                                        Option = ""
                                    }
                                }
                                OptionButton(title: "Pothos", isSelected: PothosSelected) {
                                    PothosSelected.toggle()
                                    SucculentsSelected = false
                                    FernsSelected = false
                                    PlamSelected = false
                                    PeaceliliesSelected = false
                                    FicusSelected = false
                                    if PothosSelected {
                                        Option = "Pothos"
                                    } else {
                                        Option = ""
                                    }
                                }
                                OptionButton(title: "Plam", isSelected: PlamSelected) {
                                    PlamSelected.toggle()
                                    SucculentsSelected = false
                                    PothosSelected = false
                                    FernsSelected = false
                                    PeaceliliesSelected = false
                                    FicusSelected = false
                                    if PlamSelected {
                                        Option = "Plam"
                                    } else {
                                        Option = ""
                                    }
                                }
                            }
                            HStack{
                                OptionButton(title: "Peace Lilies", isSelected: PeaceliliesSelected) {
                                    PeaceliliesSelected.toggle()
                                    SucculentsSelected = false
                                    PothosSelected = false
                                    FernsSelected = false
                                    PlamSelected = false
                                    FicusSelected = false
                                    if PartiallightSelected {
                                        Option = "Peace Lilies"
                                    } else {
                                        Option = ""
                                    }
                                }
                                OptionButton(title: "Ficus", isSelected: FicusSelected) {
                                    FicusSelected.toggle()
                                    SucculentsSelected = false
                                    PothosSelected = false
                                    FernsSelected = false
                                    PlamSelected = false
                                    PeaceliliesSelected = false
                                    if FicusSelected {
                                        Option = "Peace Lilies"
                                    } else {
                                        Option = ""
                                    }
                                }
                            }
                           
                        }
                        .padding()
                }
                    Section(header:
                                HStack {
                                    Text("Pot Size")
                                    Spacer()
                                }) {
                        VStack{
                            HStack(spacing: 10) {
                                OptionButton(title: "4-6 inch", isSelected: PotSize1Selected) {
                                    PotSize1Selected.toggle()
                                    PotSize2Selected = false
                                    PotSize3Selected = false
                                    if PotSize1Selected {
                                        Option = "4-6 inch"
                                    } else {
                                        Option = ""
                                    }
                                }
                                OptionButton(title: "6-10 inch", isSelected: PotSize2Selected) {
                                    PotSize2Selected.toggle()
                                    PotSize1Selected = false
                                    PotSize3Selected = false
                                    if PotSize2Selected {
                                        Option = "6-10 inch"
                                    } else {
                                        Option = ""
                                    }
                                }
                                OptionButton(title: "10-16 inch+", isSelected: PotSize3Selected) {
                                    PotSize3Selected.toggle()
                                    PotSize2Selected = false
                                    PotSize1Selected = false
                                    if PotSize3Selected {
                                        Option = "10-16 inch+"
                                    } else {
                                        Option = ""
                                    }
                                }
                            }
                           
                        }
                        .padding()
                }
                    Section(header:
                                HStack {
                                    Text("Light")
                                    Spacer()
                                }) {
                        VStack(alignment: .leading){
                            HStack(spacing: 10) {
                                OptionButton(title: "Direct Light", isSelected: DirectlightSelected) {
                                    DirectlightSelected.toggle()
                                    PartiallightSelected = false
                                    noLightSelected = false
                                    if DirectlightSelected {
                                        Option = "Direct Light"
                                    } else {
                                        Option = ""
                                    }
                                }
                                OptionButton(title: "Partial Light", isSelected: PartiallightSelected) {
                                    PartiallightSelected.toggle()
                                    DirectlightSelected = false
                                    noLightSelected = false
                                    if PartiallightSelected {
                                        Option = "6-10 inch"
                                    } else {
                                        Option = ""
                                    }
                                }
                                OptionButton(title: "No Light", isSelected: noLightSelected) {
                                    noLightSelected.toggle()
                                    DirectlightSelected = false
                                    PartiallightSelected = false
                                    if noLightSelected {
                                        Option = "No Light"
                                    } else {
                                        Option = ""
                                    }
                                }
                            }
                           
                        }
                        .padding()
                }
                    ZStack{
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: 350,height: 46)
                            .foregroundColor(.cardBackground)
                        HStack{
                            Text("Watering")
                                Spacer()
                            TextField("0", text: $numberInput)
                            Text("/ week")
                        }
                        .padding()
                    }
                    
                    .navigationBarItems(
                        leading: Button("Cancel") {
                            showingSheet = false
                        }.foregroundColor(.buttonsBackground),
                        
                        trailing:
                        HStack {
                            Button("Add") {
                                // Add button action
                                // You can perform any action here when Add is tapped
                                showingSheet = false
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
            }
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



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PlantSheet()
    }
}
