import SwiftUI
import UIKit // Import UIKit for UIImagePickerController

struct DetailView: View {
    @State private var categories = ["Catering", "Music", "Decor", "Bakery"]
    @State private var newCategory = ""
    @State private var selectedCategory: String?
    @State private var Vshopname = ""
    @State private var VAddress = ""
    @State private var hours = ""
    @State private var flexibleRate = ""
    @State private var logoImage: Image? = nil
    @State private var menuImage: Image? = nil
    @State private var isShowingImagePicker = false // State variable to control the image picker
    @State private var selectedImage: Image? = nil // State variable to store the selected image
    @State private var isVendrSignInActive = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
//                    Text("Vendor Details")
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .padding(.top, 35)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Choose one from the Categories")
                            .font(.headline)
                            .padding(.leading, 20)
                        
                        ForEach(categories, id: \.self) { category in
                            HStack {
                                Text(category)
                                Spacer()
                                Button(action: {
                                    if selectedCategory == category {
                                        selectedCategory = nil
                                    } else {
                                        selectedCategory = category
                                    }
                                }) {
                                    Image(systemName: selectedCategory == category ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(.blue)
                                }
                                .padding()
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    TextField("Vendor shop name", text: $Vshopname)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.purple, lineWidth: 2))
                        .padding(.horizontal, 20)
                    
                    TextField("Add address", text: $VAddress)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.purple, lineWidth: 2))
                        .padding(.horizontal, 20)
                    
                    TextField("Add working hours", text: $hours)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.purple, lineWidth: 2))
                        .padding(.horizontal, 20)
                    
                    Toggle("Flexible rate", isOn: Binding(
                                    get: { !categories.contains(newCategory) },
                                    set: { if !$0 { newCategory = "" } })
                                )
                    
                    Button(action: {
                        // Show image picker for choosing logo image
                        isShowingImagePicker = true
                    }) {
                        Text("Choose Logo Image")
                            .foregroundColor(.white)
                            .padding(.vertical, 15)
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 67/255, green: 13/255, blue: 75/255))
                            .cornerRadius(8)
                    }
                    .padding(.horizontal, 20)
                    .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                        ImagePicker(selectedImage: $selectedImage, isShowingImagePicker: $isShowingImagePicker)
                    }

                    // Display selected logo image
                    if let logoImage = logoImage {
                        logoImage
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                    }

                    // Button for choosing menu image
                    Button(action: {
                        // Show image picker for choosing menu image
                        isShowingImagePicker = true
                    }) {
                        Text("Choose Menu Image")
                            .foregroundColor(.white)
                            .padding(.vertical, 15)
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 67/255, green: 13/255, blue: 75/255))
                            .cornerRadius(8)
                    }
                    .padding(.horizontal, 20)
                    .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                        ImagePicker(selectedImage: $selectedImage, isShowingImagePicker: $isShowingImagePicker)
                    }

                    // Display selected menu image
                    if let menuImage = menuImage {
                        menuImage
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                    }

                    // Button for Vendor Sign_in
                    Button(action: {
                        withAnimation {
                            isVendrSignInActive.toggle()
                        }
                    }) {
                        Text("Sign In")
                            .foregroundColor(Color(red:67/255, green:13/255, blue:75/255))
                            .font(.subheadline)
                        
                    }
                    .fullScreenCover(isPresented: $isVendrSignInActive) {
                        VendrSignIn()
                    }
                    .padding(.horizontal, 20)

                    Spacer()
                }
                .padding()
            }
            .navigationBarTitle("Vendor Details", displayMode: .large)
        }
    }

    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        // Set the selected image to either logoImage or menuImage based on the context
        // Here, you would differentiate between logo and menu based on your logic
        // For simplicity, let's assume the first image is for the logo and the second image is for the menu
        if logoImage == nil {
            logoImage = selectedImage
        } else {
            menuImage = selectedImage
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: Image?
    @Binding var isShowingImagePicker: Bool

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // No update needed
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = Image(uiImage: image)
            }
            parent.isShowingImagePicker = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isShowingImagePicker = false
        }
    }
}

