//
//  MainView.swift
//  Plantify
//
//  Created by lana alfaadhel on 13/02/2024.
//

import SwiftUI

struct MainView: View {
    @State private var PickerSelection = 0
    @State private var pickerSelection = ""
    @StateObject var plantCardViewModel = PlantCardViewModel()

    var body: some View {
        
        NavigationStack{
        
        ZStack{
            VStack{
                
                HStack{
                    Text("Watering")
                        .font(Font.title2.bold())
                        .foregroundColor(.titleText)
                    
                    Spacer()
                    

                    NavigationLink(destination: SeeAllView(), label:
                                    {
                        Text("See All")
                            .font(.system(size: 12,weight: .light))
                            .foregroundColor(.buttonsBackground)})
                    
                }
                
                Picker("Watering", selection: $PickerSelection){
                    Text("Today")
                        .tag(0)
                    Text("Next Week")
                        .tag(1)
                    Text("Overdue")
                        .tag(2)
                }
                .pickerStyle(.segmented)
                .colorMultiply(.buttonsBackground)
                .background(.cardBackground)
                
                VStack{
                    
                    Image(systemName: "zzz")
                        .font(.system(size: 32))
                        .foregroundColor(.icons)
                        .padding()
                    
                    Text("You don't have any plants that need watering!")
                        .font(.caption)
                        .foregroundColor(.subtitleText)
                    
                }
                .frame(height: 270)
                
                HStack{
                    Text("Office Plants")
                        .font(Font.title2.bold())
                        .foregroundColor(.titleText)
                    
                    Spacer()
                    
                    Button(action: {
                        plantCardViewModel.isShowingSheet.toggle()
                        print("Is Showing Sheet: \(plantCardViewModel.isShowingSheet)")

                    }
                        
                           ,label: {
                        Image(systemName: "plus")
                            .font(.system(size: 24))
                            .foregroundColor(.buttonsBackground)
                    })
                    .sheet(isPresented: $plantCardViewModel.isShowingSheet, content: {
                        PlantSheet(plantCardViewModel: PlantCardViewModel())
                    })
                    

                }
                
                ScrollView{
                    
                    
                    if (plantCardViewModel.PlantCards.isEmpty){
                        
                        VStack{
                            
                            Image(systemName: "leaf")
                                .font(.system(size: 32))
                                .foregroundColor(.icons)
                                .padding()
                            
                            Text("Tap  ")
                                .font(.system(size: 17))
                                .foregroundColor(.subtitleText)
                            + Text(Image(systemName: "plus"))
                                .font(.system(size: 22))
                                .foregroundColor(.buttonsBackground)
                            
                            + Text(" to add one")
                                .font(.system(size: 17))
                                .foregroundColor(.subtitleText)
                            
                            Text("You can add all plants you have in your office!")
                                .font(.caption)
                                .foregroundColor(.subtitleText)
                            
                            
                        }
                        .frame(height: 270)
                    } else {
                        ForEach(plantCardViewModel.PlantCards, id: \.self){
                            PlantCard in PlantCardView(            plantCard: PlantCard, plantCardViewModel: self.plantCardViewModel)
                        }
                    }

                }
            }
            
        }
        .padding()

        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                    Text("My Plants")
                        .foregroundColor(.titleText)
                        .font(.headline)
            }
        }
        .toolbarBackground(Color(.screenBackground) , for: .navigationBar)
        .toolbarBackground(.visible)
        
        
    }
        .accentColor(.buttonsBackground)

    }
//    init(){
//        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
//
//
//        }
}



#Preview {
    MainView()
}
