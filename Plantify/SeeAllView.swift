//
//  SeeAllView.swift
//  Plantify
//
//  Created by lana alfaadhel on 13/02/2024.
//


import SwiftUI

struct SeeAllView: View {
    @State private var PickerSelection = 0
    
    @State var checkCards : [CheckCard]


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
            
                    
            if (checkCards.isEmpty){
                    
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

                        ForEach(checkCards, id: \.self){
                            CheckCard in
                            ZStack{
                                
                                RoundedRectangle(cornerSize: CGSize(width: 16, height: 16))
                                    .fill(Color(.cardBackground))
                                    .frame(width: 350, height: 66)
                                
                                HStack{
                                    
                                    Button(action: {
//                                        wateringDone(checkCard: CheckCard, WateringPerWeek: CheckCard.watering)
                                        
                                    }, label: {
                                        
                                        Circle()
                                            .stroke(
                                                Color.icons,
                                                style: StrokeStyle(lineWidth: 2))
                                            .frame(width: 24,height: 24)
                                            .padding()
                                    })
                                    
                                   
                                    
                                    VStack(alignment: .leading){
                                        Text("\(CheckCard.plantName)")
                                            .font(.title3)
                                            .foregroundColor(.bodyText)
                                        
                                        Text("\(CheckCard.plantType.rawValue)")
                                            .font(.caption)
                                            .foregroundColor(.subtitleText)
                                    }
                                    
                                }
                                .frame(width: 350, height: 66, alignment: .leading)

                            }
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

