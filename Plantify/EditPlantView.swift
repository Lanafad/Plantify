//
//  EditPlantView.swift
//  Plantify
//
//  Created by lana alfaadhel on 17/02/2024.
//
import SwiftUI

struct EditPlantView: View {
    @State private var isShowingImagePicker = false
    @State private var image: UIImage?
    var plantCard : PlantCard
    @StateObject var plantCardViewModel : PlantCardViewModel



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
                            Text("\(plantCardViewModel.getLightAdvice(plantType: plantCard.PlantType.rawValue, plantLight: plantCard.Light.rawValue) ?? "Advice Not Found")")
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
                            Text("\(plantCardViewModel.getPottAdvice(plantType: plantCard.PlantType.rawValue, plantPot: plantCard.PotSize.rawValue) ?? "Advice Not Found")")
                                .font(.caption)
                                .foregroundColor(.bodyText)
                                .frame(width: 330, height: 52, alignment: .leading)
                                .padding()                        )
                    
                    
                    HStack{
                        Text("Photo Gallery")
                            .font(.system(size: 20))
                            .bold()
                            .lineLimit(1)
                            .padding()
                            .padding(.trailing,164)
                        Button(action: {
                            self.isShowingImagePicker = true
                        }) {
                            Image(systemName: "plus")
                                .foregroundColor(Color.buttonsBackground)
                        }
                    }
                    
                    Spacer()
                }
                .navigationBarTitle(plantCard.PlantName)
                .toolbarBackground(.visible)
                .navigationBarTitleDisplayMode(.inline)
                .padding()
                .toolbar {
//                    ToolbarItem(placement: .navigationBarLeading) {
//                        NavigationLink(destination: MainView()                            /*.navigationBarBackButtonHidden(true)*/
//                        ) {
////                            HStack {
////                                Image(systemName: "chevron.left")
////                                Text("Back")
////                            }
////                            .foregroundColor(Color.buttonsBackground)
//                        }
//                    }
                    
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: EditPlantView(plantCard: plantCard, plantCardViewModel: plantCardViewModel)) {
                            Text("Edit")
                                .foregroundColor(Color.buttonsBackground)
                        }
                    }
                }
                .toolbarBackground(Color(.screenBackground), for: .navigationBar)
            }
        }
        .fullScreenCover(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
            CameraView(image: $image)
        }
    }

    func loadImage() {
        // Handle image selection
    }
}
//
//struct EditPlantView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditPlantView()
//    }
//}

struct CameraView: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: CameraView

        init(parent: CameraView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        picker.allowsEditing = true
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Update UI
    }
}
