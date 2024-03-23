import SwiftUI
import UIKit // Import UIKit for UIImagePickerController

struct DetailView: View {
    @State private var categories = ["Catering", "Music", "Decor", "Bakery"]
    @State private var selectedCategory: String?
    @State private var shopName = ""
    @State private var address = ""
    @State private var hours = ""
    @State private var flexibleRate = false
    @State private var logoImage: Image? = nil
    @State private var menuImage: Image? = nil
    @State private var isShowingImagePicker = false // State variable to control the image picker
    @State private var selectedImage: Image? = nil // State variable to store the selected image
    @State private var isVendorSignInActive = false
    @State private var isDetailsSaved = false
    let firestoreManager = FirestoreManager.shared

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Choose a Category")
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
                    
                    TextField("Vendor Shop Name", text: $shopName)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.purple, lineWidth: 2))
                        .padding(.horizontal, 20)
                    
                    TextField("Address", text: $address)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.purple, lineWidth: 2))
                        .padding(.horizontal, 20)
                    
                    TextField("Working Hours", text: $hours)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.purple, lineWidth: 2))
                        .padding(.horizontal, 20)
                    
//                    Toggle("Flexible Rate", isOn: Binding(
//                                    get: { !categories.contains(selectedCategory ?? "") },
//                                    set: { if !$0 { selectedCategory = "" } })
//                                )
                    Toggle("Flexible Rate", isOn: $flexibleRate)
                    
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

                    Button(action: {
                        saveDetailsToFirestore()
                    }) {
                        Text("Save")
                    }
                    .padding(.horizontal, 20)
                    .alert(isPresented: $isDetailsSaved) {
                        Alert(title: Text("Details Saved"), message: Text("You can now sign in"), dismissButton: .default(Text("OK"), action: {
                            // Navigate to vendor sign-in view
                            isVendorSignInActive = true
                        }))
                    }

                    Spacer()
                }
                .padding()
            }
            .navigationBarTitle("Vendor Details", displayMode: .large)
        }
    }

    private func saveDetailsToFirestore() {
        // Generate a UUID for the vendor
        let vendorID = UUID().uuidString
        
        // Save all the details to Firestore here
        firestoreManager.saveVendorDetails(VendorDetails(id: vendorID, shopName: shopName, address: address, hours: hours, flexibleRate: flexibleRate), selectedCategory: selectedCategory, logoImage: logoImage?.toData(), menuImage: menuImage?.toData())
        
        // Set the flag to true to display the alert
        isDetailsSaved = true
    }


    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        // Set the selected image to either logoImage or menuImage based on the context
        // Here, you would differentiate between the logo and menu images based on your logic
        // For simplicity, let's assume the first image is for the logo and the second image is for the menu
        if logoImage == nil {
            logoImage = selectedImage
        } else {
            menuImage = selectedImage
        }
    }
}


extension Image {
    // Convert Image to Data
    func toData() -> Data? {
        guard let uiImage = self.uiImage else {
            return nil
        }
        return uiImage.jpegData(compressionQuality: 1.0)
    }
    
    // Convert SwiftUI Image to UIImage
    private var uiImage: UIImage? {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        let renderer = UIGraphicsImageRenderer(size: view?.bounds.size ?? CGSize.zero)
        let uiImage = renderer.image { _ in
            view?.drawHierarchy(in: view!.bounds, afterScreenUpdates: true)
        }
        
        return uiImage
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
            if let uiImage = info[.originalImage] as? UIImage {
                parent.selectedImage = Image(uiImage: uiImage)
            }
            parent.isShowingImagePicker = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isShowingImagePicker = false
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}

extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        if let cgImage = image?.cgImage {
            self.init(cgImage: cgImage)
        } else {
            self.init()
        }
    }
}
