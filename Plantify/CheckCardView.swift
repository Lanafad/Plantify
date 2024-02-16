//
//  CheckCardView.swift
//  Plantify
//
//  Created by lana alfaadhel on 16/02/2024.
//

import SwiftUI

struct CheckCardView: View {
    
    var checkCard : CheckCard
    @StateObject var viewModelsCoordinator : ViewModelCoordinator

    
    var body: some View {
        ZStack{
            
            RoundedRectangle(cornerSize: CGSize(width: 16, height: 16))
                .fill(Color(.cardBackground))
                .frame(width: 350, height: 66)
            
            HStack{
                
                Button(action: {
                    viewModelsCoordinator.wateringDone(checkCard: checkCard, WateringPerWeek: checkCard.watering)
                }, label: {
                    
                    Circle()
                        .stroke(
                            Color.icons,
                            style: StrokeStyle(lineWidth: 2))
                        .frame(width: 24,height: 24)
                        .padding()
                })
                
               
                
                VStack(alignment: .leading){
                    Text("\(checkCard.plantName)")
                        .font(.title3)
                        .foregroundColor(.bodyText)
                    
                    Text("\(checkCard.plantType)")
                        .font(.caption)
                        .foregroundColor(.subtitleText)
                }
                
            }
            .frame(width: 350, height: 66, alignment: .leading)

        }
    }
}

