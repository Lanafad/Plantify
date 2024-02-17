//
//  PlantView.swift
//  Plantify
//
//  Created by lana alfaadhel on 13/02/2024.
//

import SwiftUI

struct PlantCardView: View {
    var plantCard : PlantCard
    @StateObject var plantCardViewModel : PlantCardViewModel
    @StateObject var viewModelsCoordinator : ViewModelCoordinator


    var body: some View {
        

        ZStack{
            RoundedRectangle(cornerSize: CGSize(width: 16, height: 16))
                .fill(.cardBackground)
                .frame(width: 350, height: 128)
            
            HStack{
                ZStack{
                    RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
                        .fill(.screenBackground)
                        .frame(width: 112, height: 112)
                    
                    Image(systemName: "camera.macro")
                        .font(.system(size: 32))
                        .foregroundColor(.primaryGreen)
                    
                }
                
                VStack(alignment: .leading){
                    Text("\(plantCard.PlantName)")
                        .font(.title3)
                        .foregroundColor(.bodyText)
                    
                    RoundedRectangle(cornerSize: CGSize(width: 4, height: 4))
                        .fill(.tagsBackground)
                        .frame(height: 21)
                        .overlay(
                            HStack{
                                Image(systemName: "leaf")
                                    .font(.system(size: 11))
                                    .foregroundColor(.icons)
                                
                                Text("\(plantCard.PlantType)")
                                    .font(.caption2)
                                    .foregroundColor(.bodyText)
                            }
                        )
                    RoundedRectangle(cornerSize: CGSize(width: 4, height: 4))
                        .fill(.tagsBackground)
                        .frame(width: 95, height: 21)
                        .overlay(
                            HStack{
                                Image(systemName: "hourglass.bottomhalf.filled")
                                    .font(.system(size: 11))
                                    .foregroundColor(.icons)
                                
                                Text("0 weeks old")
                                    .font(.caption2)
                                    .foregroundColor(.bodyText)
                            }
                        )
                }
                .frame(width: 95)
                
                ZStack{
                    Circle()
                        .fill(.tagsBackground)
                        .frame(width: 71)
                    
                    Circle()
                        .trim(from: 0, to: viewModelsCoordinator.hh() )
                        .stroke(
                            Color.buttonsBackground,
                            style: StrokeStyle(lineWidth: 4, lineCap: .round))
                        .frame(width: 71)
                        .rotationEffect(.degrees(-90))
                    
                    
                    VStack{
                        Image(systemName: "drop")
                            .font(.system(size: 20))
                            .foregroundColor(.icons)
                        
                        Text("\(plantCard.Watering) / week")
                            .font(.caption2)
                            .foregroundColor(.subtitleText)
                    }
                }
                .frame(width: 95)

            }
            .frame(width: 350, height: 128)

        }
    }
}

