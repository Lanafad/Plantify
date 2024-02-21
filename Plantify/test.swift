//
//  test.swift
//  Plantify
//
//  Created by MARWAH MOHAMMED ISMAIL on 11/08/1445 AH.
//

import UIKit
import CoreML
import Vision
import SwiftUI

struct testView: View {
    @State private var photo: Data?
    @State private var plant: String = ""
    @State private var shouldPresentPhotoPicker: Bool = false
    @State private var error: Bool = false
    @State private var isLoading: Bool = false
    @State private var showResult: Bool = false // Added state variable to control navigation
    
    var body: some View {
        NavigationView { // Wrap the content in NavigationView
            ZStack(alignment: .center){
                
                VStack{
                    
                    HStack{
                        Spacer()
                        if photo != nil{
                            Button(action: {
                                withAnimation{ self.photo = nil ; self.plant = ""}
                            }
                            , label: {
                                Image(systemName: "gobackward")
                                    .font(.system(size: 25, weight: .semibold, design: .rounded))
                                    .foregroundColor(.green)
                            }
                            )
                        }
                    }
                    .padding()
                    .padding(.vertical,20)
                    
                    VStack(alignment: .center, spacing: -30){
                        if photo == nil {
                            Button(action: {
                                shouldPresentPhotoPicker.toggle()
                            }, label: {
                                ZStack{
                                    
//                                    Image("Blackblurebackground")
//                                        .resizable()
//                                        .scaledToFit()
//                                        .opacity(0.8)
//                                        .frame(width: 343)
                                    
                                    VStack{
                                        Spacer()
                                        Image("Blackblurebackground")
                                            .resizable()
                                            .scaledToFit()
                                            .opacity(0.8)
                                            .frame(width: 343)
                                            .padding()
                                        Text("Click the Plant To Upload Photo!")
                                            .font(.system(size: 25, weight: .semibold, design: .rounded))
                                            .foregroundColor(.white)
                                            .padding()
                                    }
                                    
                                }})
                                .fullScreenCover(isPresented: $shouldPresentPhotoPicker){
                                    PhotoPickerView(photoData: $photo)
                                }
                                .padding(.horizontal)
                                .padding(.top, 50)
                            
                        } else {
                            if let Img = UIImage(data: photo!){
                                
                                Image(uiImage: Img)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 343, height: 343)
                                    .clipShape(RoundedRectangle(cornerRadius:17,style: .circular))
                                    .padding(.top, 50)
                            }
                        }
                        if plant == ""{
                            Button(action: {
                                if photo != nil{
                                    withAnimation{ isLoading = true ;
                                        predictPlant()
                                    }
                                }
                                
                            }, label: {Text("Predict")
                                .font(.system(size: 17, weight: .semibold, design: .rounded)).foregroundColor(self.photo == nil ? .gray : .green)
                                .padding(10)
                                .frame(width:245)
                                
                                
                            })
                            
                            .buttonStyle(.bordered)
                            .padding(.top, 140)
                        } else {
                            
                            if !error {
                                VStack(alignment: .leading){
                                    HStack{
                                        Text(self.plant == "" ?"" :"This plant is : \(plantType(string: plant))")
                                            .font(.title2)
                                            .bold()
                                        Spacer()
                                    }
                                    //Text(plant)
                                }.padding(25)
                                .background((Color("color")).opacity(0.8).blur(radius: 5))
                                Spacer()
                            }
                            
                        }
                        Spacer()
                        
                        
                        
                    }
                }.alert(isPresented: $error){
                    Alert(
                        title: Text("Predection Error !"),
                        message: Text("The photo has uploaded is not an Plant"),
                        
                        primaryButton: .destructive(
                            Text("Select other photo"),
                            
                            action: { withAnimation{ photo = nil
                                
                            }}
                        ),
                        secondaryButton: .cancel()
                    )
                }
                
                if isLoading{
                    VStack{
                        ActivityIndicatorView()
                        
                        Text("Predicting...")
                            .bold()
                            .foregroundColor(.green)
                    }
                    .frame(width: 150, height: 155)
                    .background(Color(.black).opacity(0.8))
                    
                    .cornerRadius(16)
                }
                
            }
            //.navigationBarTitle(Text("Plant Prediction"), displayMode: .inline) // Set navigation bar title
            
            // Navigate to ResultView when showResult is true
            .sheet(isPresented: $showResult) {
                ResultView(plant: self.plant) // Pass the predicted plant type to ResultView
            }
        }
    }
    
    func plantType(string: String) -> String{
        return string.components(separatedBy: ", ")[0]
    }
    
    func predictPlant(){
        
        do {
            let config = MLModelConfiguration()
            config.computeUnits = .cpuOnly
            
            //          let Model = try AAClassifier(configuration: config)
            let Model = try plantDD1(configuration: config)
            
            if let data = self.photo,
               let image = UIImage.init(data: data),
               let resizedImage = image.resizeImageTo(size:CGSize(width: 227, height: 227)),
               let bufferImage = resizedImage.convertToBuffer(){
                
                print("✓ Photo done")
                let prediction = try Model.prediction(image: bufferImage)
                print("✓ Prediction done")
                
                
                self.plant = prediction.target
                print("the prediction is: \(self.plant)".uppercased())
                isLoading = false
                showResult = true // Set showResult to true to navigate to ResultView
            }
            
        } catch {
            self.error = true
            print("something went wrong! \n \(error.localizedDescription) \n \n More Info: \n \(error)")
        }
    }
    
}

struct ResultView: View {
    var plant: String
    
    var body: some View {
        VStack {
            if plant.lowercased() == "healthy" {
                Spacer()
                VStack{
                    Image("Hplant")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .foregroundColor(.green)
                    Text("Great!!")
                        .font(.title)
                        .bold()
                        .foregroundColor(.primary)
                    Text("This is a beautiful plant, keep it like this.")
                        .font(.title)
                        .foregroundColor(.primary)
                        .padding()
                }
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
            } else {
                Spacer()
                Image("UHplant")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.red)
                Text("Oh, Nooo")
                    .font(.title)
                    .bold()
                    .padding()
                Text("This plant seems sick, please take care of it.")
                    .font(.title)
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
}

struct PhotoPickerView: UIViewControllerRepresentable {
    // 1
    @Binding var photoData: Data?

    // 2
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    // 3
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        private let parent: PhotoPickerView

        init(parent: PhotoPickerView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            let image = info[.originalImage] as? UIImage
            let imageData = image?.jpegData(compressionQuality: 1)
            // 4
            self.parent.photoData = imageData

            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }

    }

    func makeUIViewController(context: Context) -> some UIViewController {
        let imagePicker = UIImagePickerController()
        // 5
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

    }
}

struct ActivityIndicatorView: UIViewRepresentable{
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let v = UIActivityIndicatorView(style: .large)
        v.color = .green
        v.startAnimating()
        return v
    }
    typealias UIViewType = UIActivityIndicatorView

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        
    }
}
extension UIImage {
    
    func resizeImageTo(size: CGSize) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resizedImage
    }
    
     func convertToBuffer() -> CVPixelBuffer? {
        
        let attributes = [
            kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue,
            kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue
        ] as CFDictionary
        
        var pixelBuffer: CVPixelBuffer?
        
        let status = CVPixelBufferCreate(
            kCFAllocatorDefault, Int(self.size.width),
            Int(self.size.height),
            kCVPixelFormatType_32ARGB,
            attributes,
            &pixelBuffer)
        
        guard (status == kCVReturnSuccess) else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        
        let context = CGContext(
            data: pixelData,
            width: Int(self.size.width),
            height: Int(self.size.height),
            bitsPerComponent: 8,
            bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!),
            space: rgbColorSpace,
            bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        
        UIGraphicsPushContext(context!)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        UIGraphicsPopContext()
        
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        
        return pixelBuffer
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        testView()
            .preferredColorScheme(.dark)
        
    }
}
