
//
//  SuccessfullyView.swift
//  Plantify
//
//  Created by MARWAH MOHAMMED ISMAIL on 05/08/1445 AH.
//
import SwiftUI

struct SuccessfullyView: View {
    

    
    @Environment (\.dismiss) var dismiss
    @State var isShowingSheet : Bool


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
            
            Button(action: {
                dismiss()
                isShowingSheet = false
            }, label: {
                ZStack{
                RoundedRectangle(cornerRadius: 10)
                        .frame(width: 358, height: 50)
                        .foregroundColor(.buttonsBackground)
                        .padding()
                    
                    Text("Done")
                        .font(.headline)
                        .foregroundColor(.screenBackground)
                        .padding()
                }
            })
        }
    }
}


