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
    @StateObject var checkCardViewModel = CheckCardViewModel()


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
                .padding(.bottom)

                
                    
                    if (!plantCardViewModel.PlantCards.isEmpty){
                        
                        VStack{
                            

                        
                        ForEach(checkCardViewModel.checkCards, id: \.self){
                            CheckCard in CheckCardView(checkCard: CheckCard, checkCardViewModel: self.checkCardViewModel)
                        }
                        
                        
                    }
                    .frame(width: 350, height: 270, alignment: .top)

                    } else {
                        
                        VStack{

                        
                        Image(systemName: "zzz")
                            .font(.system(size: 32))
                            .foregroundColor(.icons)
                            .padding()
                        
                        Text("You don't have any plants that need watering!")
                            .font(.caption)
                            .foregroundColor(.subtitleText)
                        }
                        .frame(width: 350, height: 270, alignment: .center)
                    
                    }
                    

            
                
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
                        PlantSheet(plantCardViewModel: plantCardViewModel, checkCardViewModel: checkCardViewModel)
                    })
                    

                }
                
                    
                    
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
                        
                        ScrollView{
                            
                            
                            ForEach(plantCardViewModel.PlantCards, id: \.self){
                                PlantCard in PlantCardView(plantCard: PlantCard, plantCardViewModel: self.plantCardViewModel)
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

    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .buttonsBackground
        
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.screenBackground], for: .selected)
        
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.bodyText], for: .normal)
    }
}



#Preview {
    MainView()
}
