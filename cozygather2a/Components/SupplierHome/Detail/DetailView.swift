import SwiftUI
import UIKit // Import UIKit for UIImagePickerController
import FirebaseStorage
import FirebaseFirestore

struct DetailView: View {
    @State private var categories = ["Catering", "Music", "Decor", "Bakery"]
    @State private var selectedCategory: String?
    @State private var shopName = ""
    @State private var price = ""
    @State private var address = ""
    @State private var fromTime = Date()
    @State private var toTime = Date()
    @State private var flexibleRate = false
    @State private var logoImage: Image? = nil
    @State private var menuImage: Image? = nil
    @State private var isShowingImagePicker = false // State variable to control the image picker
    @State private var selectedImage: Image? = nil // State variable to store the selected image
    @State private var isVendorSignInActive = false
    @State private var isDetailsSaved = false
    @State private var VendorHomePageActive = false
    let firestoreManager = FirestoreManager.shared

    var body: some View {
        NavigationView {
            ZStack{
                ScrollView {
                    VStack(spacing: 20) {
                        // Choose Category Section
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Choose a Category")
                                .font(.headline)
                            ForEach(categories, id: \.self) { category in
                                HStack {
                                    Text(category)
                                    Spacer()
                                    Button(action: {
                                        selectedCategory = (selectedCategory == category) ? nil : category
                                    }) {
                                        Image(systemName: selectedCategory == category ? "checkmark.circle.fill" : "circle")
                                            .foregroundColor(Color(red:198/255, green: 174/255, blue:128/255))
                                    }
                                    .padding()
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        // Vendor Shop Name
                        TextField("Vendor Shop Name", text: $shopName)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color(red:198/255, green: 174/255, blue: 128/255), lineWidth: 2))
                            .padding(.horizontal, 20)
                        
                        // Address
                        TextField("Address", text: $address)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color(red:198/255, green: 174/255, blue: 128/255), lineWidth: 2))
                            .padding(.horizontal, 20)
                        
                        TextField("Price", text: $price)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color(red:198/255, green: 174/255, blue: 128/255), lineWidth: 2))
                            .padding(.horizontal, 20)
                        
                        // Working Hours Section
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Working Hours")
                                .font(.headline)
                            HStack {
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("From")
                                        .font(.headline)
                                    DatePicker("", selection: $fromTime, displayedComponents: .hourAndMinute)
                                        .datePickerStyle(CompactDatePickerStyle())
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, 5)
                                
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("To")
                                        .font(.headline)
                                    DatePicker("", selection: $toTime, displayedComponents: .hourAndMinute)
                                        .datePickerStyle(CompactDatePickerStyle())
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, 5)
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color(red:198/255, green: 174/255, blue: 128/255), lineWidth: 2))
                            //.padding(.horizontal, 20)
                        }
                        .padding(.horizontal, 20)
                        
                        // Flexible Rate Toggle
                        Toggle("Flexible Rate", isOn: $flexibleRate)
                            .padding(.horizontal, 20)
                        
                        // Choose Logo Image Button
                        Button(action: {
                            isShowingImagePicker = true
                        }) {
                            Text("Choose Logo Image")
                                .foregroundColor(.white)
                                .padding()
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
                        
                        // Choose Menu Image Button
                        Button(action: {
                            isShowingImagePicker = true
                        }) {
                            Text("Choose Menu Image")
                                .foregroundColor(.white)
                                .padding()
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
                        
                        // Save Button
                        Button(action: {
                            saveDetailsToFirestore()
                        }) {
                            Text("Save")
                                .foregroundColor(Color(red:198/255, green: 174/255, blue: 128/255))
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(red:67/255, green: 13/255, blue: 75/255))
                                .cornerRadius(8)
                        }
                        .padding(.horizontal, 20)
                        .alert(isPresented: $isDetailsSaved) {
                            Alert(
                                title: Text("Details Saved"),
                                message: Text("You can now go to homepage by pressing OK"),
                                dismissButton: .default(Text("OK"), action: {
                                    // Set the flag to true to present the vendor home view
                                    VendorHomePageActive = true
                                })
                            )
                        }
                        .fullScreenCover(isPresented: $VendorHomePageActive, content: {
                            VendorHome(username: "YourUsernameHere")
                        })
                        
                        Spacer()
                    }
                    .padding()
                }
            }
            .background(Color(red: 247/225, green: 239/255, blue: 247/255))
            .navigationBarTitle("Vendor Details", displayMode: .large)
            .foregroundColor(Color(red:67/255, green:13/255, blue: 75/255))
            //.background(Color(red: 1.0, green: 1.0, blue: 0.8))
        }
    }

    private func saveDetailsToFirestore() {
        // Generate a UUID for the vendor
        let vendorID = UUID().uuidString
        
        // Format working hours string
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        let fromTimeString = dateFormatter.string(from: fromTime)
        let toTimeString = dateFormatter.string(from: toTime)
        let hours = "\(fromTimeString) - \(toTimeString)"
        
        // Save all the details to Firestore here
        firestoreManager.saveVendorDetails(VendorDetails(id: vendorID, shopName: shopName, price: price, address: address, hours: hours, flexibleRate: flexibleRate), selectedCategory: selectedCategory, logoImage: logoImage?.toData(), menuImage: menuImage?.toData()) { imageUrl, error in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                // Handle error
            } else if let imageUrl = imageUrl {
                print("Image uploaded successfully: \(imageUrl)")
                // Set the flag to true to display the alert
                isDetailsSaved = true
            }
        }
    }


    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        // Set the selected image to either logoImage or menuImage based on the context
        // Here, you would differentiate between the logo and menu images based on your logic
        // For simplicity, let's assume the first image is for the logo and the second image is for the menu
        if logoImage == nil {
            logoImage = selectedImage
            // Upload logo image to Firebase Storage
            uploadImageToFirebaseStorage(imageData: logoImage?.toData() ?? Data()) { result in
                switch result {
                case .success(let imageUrl):
                    // Store image URL in Firestore
                    saveImageURLToFirestore(imageURL: imageUrl) { error in
                        if let error = error {
                            print("Error storing logo image URL: \(error.localizedDescription)")
                            // Handle error
                        }
                    }
                case .failure(let error):
                    print("Error uploading logo image: \(error.localizedDescription)")
                    // Handle error
                }
            }
        } else {
            menuImage = selectedImage
            // Upload menu image to Firebase Storage
            uploadImageToFirebaseStorage(imageData: menuImage?.toData() ?? Data()) { result in
                switch result {
                case .success(let imageUrl):
                    // Store image URL in Firestore
                    saveImageURLToFirestore(imageURL: imageUrl) { error in
                        if let error = error {
                            print("Error storing menu image URL: \(error.localizedDescription)")
                            // Handle error
                        }
                    }
                case .failure(let error):
                    print("Error uploading menu image: \(error.localizedDescription)")
                    // Handle error
                }
            }
        }
    }

    // Function to upload image data to Firebase Storage
    private func uploadImageToFirebaseStorage(imageData: Data, completion: @escaping (Result<String, Error>) -> Void) {
        let storageRef = Storage.storage().reference().child(UUID().uuidString)
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                completion(.failure(error))
            } else {
                storageRef.downloadURL { url, error in
                    if let error = error {
                        completion(.failure(error))
                    } else if let downloadURL = url {
                        completion(.success(downloadURL.absoluteString))
                    }
                }
            }
        }
    }

    // Function to save image URL to Firestore
    private func saveImageURLToFirestore(imageURL: String, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        let data: [String: Any] = ["imageURL": imageURL]
        db.collection("images").addDocument(data: data) { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
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
