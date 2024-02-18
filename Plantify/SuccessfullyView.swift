//
//  SuccessfullyView.swift
//  Plantify
//
//  Created by MARWAH MOHAMMED ISMAIL on 05/08/1445 AH.
//
import SwiftUI

struct SuccessfullyView: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 100))
                .foregroundColor(.icons)
                .padding()
            
            Text("Successfully Added!!")
                .font(.title)
                .foregroundColor(.primary)
                .padding()
            
            Spacer()
            
            Button("Done") {
                // Perform any action here when "I'm done" button is tapped
            }
            .frame(width: 300, height: 25)
            .foregroundColor(.bodyText)
            .padding()
            .background(Color.buttonsBackground)
            .cornerRadius(10)
            .padding()
        }
    }
}

struct SuccessfullyView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessfullyView()
    }
}
