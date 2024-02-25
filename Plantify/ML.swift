
//
//  ContentView.swift
//  testjds
//
//  Created by RazanAlzahrani on 15/08/1445 AH.
//

import SwiftUI

import UIKit
import CoreML
import Vision
import SwiftUI




//struct ResultView: View {
//    var plant: String
//    
//    var body: some View {
//        VStack {
//            if plant.lowercased() == "healthy" {
//                Spacer()
//                VStack{
//                    Image("Hplant")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 100, height: 100)
//                        .foregroundColor(.green)
//                    Text("Great!!")
//                        .font(.title)
//                        .bold()
//                        .foregroundColor(.primary)
//                    Text("This is a beautiful plant, keep it like this.")
//                        .font(.title)
//                        .foregroundColor(.primary)
//                        .padding()
//                }
//                Spacer()
//                Button("Done") {
//                    // Perform any action here when "I'm done" button is tapped
//                }
//                .frame(width: 300, height: 25)
//                .foregroundColor(.bodyText)
//                .padding()
//                .background(Color.buttonsBackground)
//                .cornerRadius(10)
//                .padding()
//            } else if (plant.lowercased() == "unhealthy") {
//                Spacer()
//                Image("UHplant")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 100, height: 100)
//                    .foregroundColor(.red)
//                Text("Oh, Nooo")
//                    .font(.title)
//                    .bold()
//                    .padding()
//                Text("This plant seems sick, please take care of it.")
//                    .font(.title)
//                    .padding()
//                Spacer()
//                Button("Done") {
//                    // Perform any action here when "I'm done" button is tapped
//                }
//                .frame(width: 300, height: 25)
//                .foregroundColor(.bodyText)
//                .padding()
//                .background(Color.buttonsBackground)
//                .cornerRadius(10)
//                .padding()
//            }
//        }
//    }
//}
//
//
//struct ActivityIndicatorView: UIViewRepresentable{
//    func makeUIView(context: Context) -> UIActivityIndicatorView {
//        let v = UIActivityIndicatorView(style: .large)
//        v.color = .green
//        v.startAnimating()
//        return v
//    }
//    typealias UIViewType = UIActivityIndicatorView
//
//    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
//        
//    }
//}
//extension UIImage {
//    
//    func resizeImageTo(size: CGSize) -> UIImage? {
//        
//        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
//        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
//        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//        return resizedImage
//    }
//    
//     func convertToBuffer() -> CVPixelBuffer? {
//        
//        let attributes = [
//            kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue,
//            kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue
//        ] as CFDictionary
//        
//        var pixelBuffer: CVPixelBuffer?
//        
//        let status = CVPixelBufferCreate(
//            kCFAllocatorDefault, Int(self.size.width),
//            Int(self.size.height),
//            kCVPixelFormatType_32ARGB,
//            attributes,
//            &pixelBuffer)
//        
//        guard (status == kCVReturnSuccess) else {
//            return nil
//        }
//        
//        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
//        
//        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
//        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
//        
//        let context = CGContext(
//            data: pixelData,
//            width: Int(self.size.width),
//            height: Int(self.size.height),
//            bitsPerComponent: 8,
//            bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!),
//            space: rgbColorSpace,
//            bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
//        
//        context?.translateBy(x: 0, y: self.size.height)
//        context?.scaleBy(x: 1.0, y: -1.0)
//        
//        UIGraphicsPushContext(context!)
//        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
//        UIGraphicsPopContext()
//        
//        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
//        
//        return pixelBuffer
//    }
//}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .preferredColorScheme(.dark)
//        
//    }
//}
