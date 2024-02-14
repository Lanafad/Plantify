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
//    @ObservedObject var plantCardViewModel : PlantCardViewModel

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
                        .font(.footnote.bold())
                    Text("Next Week")
                        .tag(1)
                        .font(.footnote.bold())
                    Text("Overdue")
                        .tag(2)
                        .font(.footnote.bold())
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
//                    
//                    Button(action: {plantCardViewModel.isShowingSheet.toggle()}, label: {
//                        Image(systemName: "plus")
//                            .font(.system(size: 24))
//                            .foregroundColor(.buttonsBackground)
//                    })
//                    .sheet(isPresented: $plantCardViewModel.isShowingSheet, content: {
//                        PlantSheet(plantCardViewModel: plantCardViewModel, PickerSelection: pickerSelection)
//                    })
                    

                }
                
                
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
}

#Preview {
    MainView()
}
