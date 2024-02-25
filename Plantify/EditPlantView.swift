//
//  EditPlantView.swift
//  Plantify
//
//  Created by lana alfaadhel on 17/02/2024.
//

import SwiftUI
import AVFoundation
import UIKit
import ImageIO
import UIKit
import CoreML
import Vision
import SwiftUI


struct EditPlantView: View {
    @State private var isShowingImagePicker = false
    @State private var images: [UIImage] = [] // Array to store multiple images
    var plantCard : PlantCard

    @State var LightDictionary = [String : String]()
    @State var PotDictionary = [String : String]()
    
    
    
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack {
                    VStack(alignment: .leading){
                        HStack{
                            Rectangle()
                                .fill(Color.tagsBackground)
                                .frame(height: 22)
                                .cornerRadius(4)
                                .overlay(
                                    HStack{
                                        Image(systemName: "leaf")
                                            .font(.system(size: 11))
                                            .foregroundColor(.icons)
                                        
                                        Text("\(plantCard.PlantType.rawValue)")
                                            .font(.caption2)
                                            .foregroundColor(.bodyText)
                                    }
                                )
                            
                            Rectangle()
                                .fill(Color.tagsBackground)
                                .frame(height: 22)
                                .cornerRadius(4)
                                .overlay(
                                    HStack{
                                        Image(systemName: "drop")
                                            .font(.system(size: 11))
                                            .foregroundColor(.icons)
                                        
                                        Text("\(plantCard.Watering) / week")
                                            .font(.caption2)
                                            .foregroundColor(.bodyText)
                                    }
                                )
                            
                            Rectangle()
                                .fill(Color.tagsBackground)
                                .frame(height: 22)
                                .cornerRadius(4)
                                .overlay(
                                    HStack{
                                        Image(systemName: "sun.max")
                                            .font(.system(size: 11))
                                            .foregroundColor(.icons)
                                        
                                        Text("\(plantCard.Light.rawValue)")
                                            .font(.caption2)
                                            .foregroundColor(.bodyText)
                                    }
                                )
                            
                            Rectangle()
                                .fill(Color.tagsBackground)
                                .frame(height: 22)
                                .cornerRadius(4)
                                .overlay(
                                    HStack{
                                        Image(systemName: "hockey.puck")
                                            .font(.system(size: 11))
                                            .foregroundColor(.icons)
                                        
                                        Text("\(plantCard.PotSize.rawValue)")
                                            .font(.caption2)
                                            .foregroundColor(.bodyText)
                                    }
                                )
                            
                        }
                        Rectangle()
                            .fill(Color.tagsBackground)
                            .frame(width: 78, height: 22)
                            .cornerRadius(4)
                            .overlay(
                                HStack{
                                    Image(systemName: "hourglass.bottomhalf.filled")
                                        .font(.system(size: 11))
                                        .foregroundColor(.icons)
                                    
                                    Text("0 weeks")
                                        .font(.caption2)
                                        .foregroundColor(.bodyText)
                                }
                            )
                        
                    }
                    
                    Text("Advice")
                        .font(.system(size: 20))
                        .bold()
                        .padding()
                        .padding(.top,20)
                        .padding(.trailing,255)
                    
                    Rectangle()
                        .fill(Color.tagsBackground)
                        .frame(width: 350, height: 52)
                        .cornerRadius(8)
                        .overlay(
                            Text("\(getLightAdvice(plantType: plantCard.PlantType.rawValue, plantLight: plantCard.Light.rawValue) ?? "Advice Not Found")")
                                .font(.caption)
                                .foregroundColor(.bodyText)
                                .frame(width: 330, height: 52, alignment: .leading)
                                .padding()
                        )
                    
                    
                    
                    Rectangle()
                        .fill(Color.tagsBackground)
                        .frame(width: 350, height: 52)
                        .cornerRadius(8)
                        .overlay(
                            Text("\(getPottAdvice(plantType: plantCard.PlantType.rawValue, plantPot: plantCard.PotSize.rawValue) ?? "Advice Not Found")")
                                .font(.caption)
                                .foregroundColor(.bodyText)
                                .frame(width: 330, height: 52, alignment: .leading)
                                .padding()                        )
                    
                    
                    HStack {
                        Text("Photo Gallery")
                            .font(.system(size: 20))
                            .bold()
                            .lineLimit(1)
                            .padding()
                            .padding(.trailing, 164)
                        Button(action: {
                            self.isShowingImagePicker = true
                        }) {
                            Image(systemName: "plus")
                                .foregroundColor(Color.buttonsBackground)
                        }
                    }
                    

                    LazyVGrid(columns: [
                        GridItem(),
                        GridItem()
                        
                    ] , spacing: 10, content: {
                                            ForEach(images.chunked(into: 2), id: \.self) { imagePair in
                                                    ForEach(imagePair, id: \.self) { image in
                                                        VStack(spacing : 0) {
                                                            Image(uiImage: image)
                                                                .resizable()
                                                                .scaledToFill()
                                                                .frame(width: 165, height: 165)
                                                                .cornerRadius(4)
                                                                .clipped()
                                                                .alignmentGuide(.top) { _ in 0 } // Aligns the top of the image
                        
                                                            Rectangle()
                                                                .fill(Color.cardBackground)
                                                                .frame(width: 165, height: 29)
                                                                .cornerRadius(4)
                                                                .alignmentGuide(.top) { _ in 0 } // Aligns the top of the rectangle
                                                                .overlay(
                                                                    Text(Date().formattedString(dateFormat: "MMMM dd, yyyy"))
                                                                        .font(.caption)
                                                                        .foregroundColor(Color.buttonsBackground)
                                                                        .padding(.top, 4) // Add padding to move the date up
                                                                )
                                                        }
                                                    }

                                            }
 })
                    
                    Spacer()
                }
                .onAppear(perform: setDictionaries)
                .navigationBarTitle(plantCard.PlantName)
                .toolbarBackground(.visible)
                .navigationBarTitleDisplayMode(.inline)
                .padding()
                .toolbar {

                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: EditPlantView(plantCard: plantCard)) {
                            Text("Edit")
                                .foregroundColor(Color.buttonsBackground)
                        }
                    }
                }
                .toolbarBackground(Color(.screenBackground), for: .navigationBar)
            }
        }
        .fullScreenCover(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
            CameraView(images: $images)
        }
    }
        
    
        
    
    func setDictionaries() -> Void{
        LightDictionary["Succulents,direct light"] = "Provide 6-8 hours of bright sunlight and monitor soil moisture closely."
        LightDictionary["Succulents,partial light"] = "Ensure 4-6 hours of indirect light, rotate plants for even growth."
        LightDictionary["Succulents,no light"] = "Use artificial lighting for 10-12 hours, maintain appropriate distance from plants."
        
        LightDictionary["Ferns,direct light"] = "Provide a few hours of gentle morning or late afternoon sun, monitor soil moisture closely."
        LightDictionary["Ferns,partial light"] = "Ensure bright, indirect light for a few hours each day, avoid direct sunlight."
        LightDictionary["Ferns,no light"] = "Use artificial lighting for 10-12 hours, some fern species may struggle in extremely low-light environments."
        
        LightDictionary["Pothos,direct light"] = "Provide filtered sunlight and monitor soil moisture closely."
        LightDictionary["Pothos,partial light"] = "Ensure sufficient indirect light and adjust watering frequency."
        LightDictionary["Pothos,no light"] = "Place near artificial light sources and be cautious not to overwater."
        
        LightDictionary["Peace lilies,direct light"] = "Protect from direct sunlight, provide filtered light, and monitor soil moisture closely."
        LightDictionary["Peace lilies,partial light"] = "Ensure some indirect light, avoid direct sunlight, and adjust watering accordingly."
        LightDictionary["Peace lilies,no light"] = "Provide bright, indirect artificial light sources, and ensure some exposure to promote healthy growth."
        
        LightDictionary["Ficus,direct light"] = "Protect from intense sunlight, provide filtered light, and monitor soil moisture closely."
        LightDictionary["Ficus,partial light"] = "Ensure some indirect light, supplement with artificial lighting if needed, and adjust watering accordingly."
        LightDictionary["Ficus,no light"] = "Provide artificial lighting for 10-12 hours daily, monitor soil moisture, and avoid overwatering."
        
        LightDictionary["Palm,direct light"] = "Protect from intense sunlight, provide filtered light, and monitor soil moisture closely."
        LightDictionary["Palm,partial light"] = "Ensure significant indirect light, supplement with artificial lighting if needed, and water when top inch of soil is dry."
        LightDictionary["Palm,no light"] = "Provide artificial lighting for 10-12 hours daily, adjust watering for lower light levels, and avoid overwatering."
        
        
        //
        
        PotDictionary["Succulents,4-6 inch"] = "Use well-draining soil, water sparingly when soil is dry."
        PotDictionary["Succulents,6-10 inch"] = "Ensure proper drainage, water deeply but infrequently, allow soil to dry out."
        PotDictionary["Succulents,10-16 inch+"] = "Use pots with drainage, water deeply but infrequently, allow soil to almost completely dry out."
        
        PotDictionary["Ferns,4-6 inch"] = "Use well-draining potting mix, ensure proper drainage, and monitor soil moisture."
        PotDictionary["Ferns,6-10 inch"] = "Provide room for root growth, check soil moisture regularly, maintain consistently moist but not waterlogged conditions."
        PotDictionary["Ferns,10-16 inch+"] = "Ensure proper drainage, use well-draining potting mix, water deeply but infrequently, allow slight drying between waterings."
        
        PotDictionary["Pothos,4-6 inch"] = "Monitor soil moisture closely and consider repotting if necessary."
        PotDictionary["Pothos,6-10 inch"] = "Allow top inch of soil to dry between waterings and adjust frequency based on light conditions."
        PotDictionary["Pothos,10-16 inch+"] = "Adjust watering schedule for longer moisture retention and ensure proper drainage."
        
        PotDictionary["Peace lilies,4-6 inch"] = "Use well-draining pots, water when the top inch of soil is dry."
        PotDictionary["Peace lilies,6-10 inch"] = "Allow the top 1-2 inches of soil to dry between waterings, ensure proper drainage."
        PotDictionary["Peace lilies,10-16 inch+"] = "Check soil moisture regularly, water deeply when the top 2-3 inches of soil is dry, ensure proper drainage."
        
        PotDictionary["Ficus,4-6 inch"] = "Use well-draining pots, water thoroughly but allow the soil to partially dry between waterings."
        PotDictionary["Ficus,6-10 inch"] = "Allow the soil to partially dry out between waterings, ensure proper drainage."
        PotDictionary["Ficus,10-16 inch+"] = "Check soil moisture regularly, water deeply but infrequently, ensure proper drainage."
        
        PotDictionary["Palm,4-6 inch"] = "Use well-draining pots, water thoroughly but allow soil to slightly dry between waterings."
        PotDictionary["Palm,6-10 inch"] = "Allow soil to partially dry between waterings, ensure proper drainage."
        PotDictionary["Palm,10-16 inch+"] = "Check soil moisture regularly, water deeply but infrequently, ensure proper drainage."
    }
    

    
    func getLightAdvice(plantType : String, plantLight : String) -> String? {
        let key = ("\(plantType),\(plantLight)")
        
        return LightDictionary[key]
        
        
    }
    
    func getPottAdvice(plantType : String, plantPot : String) -> String? {
        let key = ("\(plantType),\(plantPot)")
        
        return PotDictionary[key]
        
    }
    

}

func loadImage() {
    // Handle image selection
}



struct CameraView: UIViewControllerRepresentable {
    @Binding var isActive: Bool
    @Binding var capturedImage: Data?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: CameraView

        init(parent: CameraView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.capturedImage = image.jpegData(compressionQuality: 0.5)
            }
            parent.isActive = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isActive = false
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // No update needed
    }
}

struct ML: View {
    @State private var photo: Data?
    @State private var plant: String = ""
    @State private var error: Bool = false
    @State private var isLoading: Bool = false
    @State private var isCameraActive: Bool = false
    @State private var isCaptureAvailable: Bool = UIImagePickerController.isSourceTypeAvailable(.camera)
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
                            if isCaptureAvailable{
                                Button(action: {
                                    isCameraActive.toggle()
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
                                .fullScreenCover(isPresented: $isCameraActive){
                                    CameraView(isActive: $isCameraActive, capturedImage:  $photo)
                                }
                                .padding(.horizontal)
                                .padding(.top, 50)
                            }
                        }else {
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
            } else if (plant.lowercased() == "unhealthy") {
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


extension Date {
func formattedString(dateFormat: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    return dateFormatter.string(from: self)
}
}

extension Array {
func chunked(into size: Int) -> [[Element]] {
    return stride(from: 0, to: count, by: size).map {
        Array(self[$0 ..< Swift.min($0 + size, count)])
    }
}
}
