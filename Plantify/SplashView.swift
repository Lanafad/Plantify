//
//  SplashView.swift
//  Plantify
//
//  Created by lana alfaadhel on 19/02/2024.
//

import SwiftUI

struct SplashView: View {
    @State private var scale: CGFloat = 1.0
    @State private var opacity: Double = 1.0
    @State private var isActive = false
    
    var body: some View {
        
        if isActive{
            MainView()
        } else{
            
            VStack {
                Spacer()
                
                Image(systemName: "camera.macro")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.primaryGreen)
                    .scaleEffect(scale)
                    .opacity(opacity)
                
                Spacer()
            }
            .onAppear{
                withAnimation(Animation.easeInOut(duration: 2.0)) {scale = 2.0; opacity = 0.0}
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                    withAnimation{
                        self.isActive = true

                    }
                }
            }
        }
    }
}
