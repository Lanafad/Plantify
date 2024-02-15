import SwiftUI

struct EditPlantView: View {
    @State private var isShowingImagePicker = false
    @State private var image: UIImage?

    var body: some View {
        NavigationView {
            ScrollView{
                VStack {
                    VStack{
                        HStack{
                            Rectangle()
                                .fill(Color.tagsBackground)
                                .frame(width: 78, height: 22)
                                .cornerRadius(4)
                            
                            Rectangle()
                                .fill(Color.tagsBackground)
                                .frame(width: 78, height: 22)
                                .cornerRadius(4)
                            Rectangle()
                                .fill(Color.tagsBackground)
                                .frame(width: 78, height: 22)
                                .cornerRadius(4)
                            Rectangle()
                                .fill(Color.tagsBackground)
                                .frame(width: 78, height: 22)
                                .cornerRadius(4)
                        }
                        Rectangle()
                            .fill(Color.tagsBackground)
                            .frame(width: 78, height: 22)
                            .cornerRadius(4)
                            .padding(.trailing,255)
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
                        .padding()
                    Rectangle()
                        .fill(Color.tagsBackground)
                        .frame(width: 350, height: 52)
                        .cornerRadius(8)
                    
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
                .navigationBarTitle("Voo")
                .toolbarBackground(.visible)
                .navigationBarTitleDisplayMode(.inline)
                               .padding()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink(destination: ContentView()) {
                            HStack {
                                Image(systemName: "chevron.left")
                                Text("Back")
                            }
                            .foregroundColor(Color.buttonsBackground)
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: EditPlantView()) {
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

struct EditPlantView_Previews: PreviewProvider {
    static var previews: some View {
        EditPlantView()
    }
}

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
