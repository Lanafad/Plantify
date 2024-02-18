//
//  SeeAllView.swift
//  Plantify
//
//  Created by lana alfaadhel on 13/02/2024.
//

import SwiftUI

struct SeeAllView: View {
    @State private var PickerSelection = 0
    @StateObject var viewModelsCoordinator : ViewModelCoordinator


    var body: some View {
        VStack{
            
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
            
                    
            if (viewModelsCoordinator.checkCards.isEmpty){
                    
                    VStack{

                    
                    Image(systemName: "zzz")
                        .font(.system(size: 32))
                        .foregroundColor(.icons)
                        .padding()
                    
                    Text("You don't have any plants that need watering!")
                        .font(.caption)
                        .foregroundColor(.subtitleText)
                    }
                    .frame(width: 350, height: 600, alignment: .center)
                    

                } else {
                    

                    VStack{

                        ForEach(viewModelsCoordinator.checkCards, id: \.self){
                            CheckCard in CheckCardView(checkCard: CheckCard, viewModelsCoordinator: viewModelsCoordinator)
                    }
                    
                }
                .frame(width: 350, height: 600, alignment: .top)
                
                }

        }
        
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
                ToolbarItem(placement: .principal) {
                        Text("Watering")
                            .foregroundColor(.titleText)
                            .font(.headline)
                            .padding()
                }
            }
            .toolbarBackground(Color(.screenBackground) , for: .navigationBar)
            .toolbarBackground(.visible)
        
        
        
            }
}

