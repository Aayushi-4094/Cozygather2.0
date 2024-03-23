import FirebaseFirestore

struct VendorDetails {
    var id: String
    var shopName: String
    var address: String
    var hours: String
    var flexibleRate: Bool
    var logoImageData: Data? // Variable to store the logo image data
    var menuImageData: Data? // Variable to store the menu image data
    // Add other vendor properties as needed
}

struct Supplier: Identifiable {
    var id: String
    var fullName: String
    var userName: String
    var phoneNumber: String
    // Add other supplier properties as needed
}

struct Event: Identifiable, Codable {
    var id: String?
    var eventName: String
    var venueAddress: String
    var price: String
    var selectedDate: Date
    var selectedCoHosts: [String]

    // Add other properties as needed, e.g., eventDescription, maxParticipants, etc.

    init(eventName: String, venueAddress: String, price: String, selectedDate: Date, selectedCoHosts: [String]) {
        self.eventName = eventName
        self.venueAddress = venueAddress
        self.price = price
        self.selectedDate = selectedDate
        self.selectedCoHosts = selectedCoHosts
        // Initialize other properties as needed
    }
}

class FirestoreManager {
    static let shared = FirestoreManager()
    private let db = Firestore.firestore()
    
    // Function to create a new user
    func createUser(_ user: User) {
        // Replace "users" with your actual Firestore collection name
        db.collection("users").document(user.id).setData([
            "fullName": user.fullName,
            "userName": user.userName,
            // Add other user properties as needed
        ]) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added with ID: \(user.id)")
            }
        }
    }
    
    // Function to create a new event
    func createEvent(_ event: Event, completion: @escaping (Bool) -> Void) {
        
        var eventData = [
            "eventName": event.eventName,
            "venueAddress": event.venueAddress,
            "price": event.price,
            "selectedDate": Timestamp(date: event.selectedDate), // Convert Date to Timestamp
            "selectedCoHosts": event.selectedCoHosts
            // Add other event properties as needed, e.g., "eventDescription": event.eventDescription,
        ] as [String : Any]
        
        // Add document to Firestore and get the document ID
        let docRef = db.collection("events").addDocument(data: eventData) { error in
            if let error = error {
                print("Error adding document: \(error)")
                completion(false)
            } else {
                print("Event added to Firestore successfully")
                completion(true)
            }
        }
        
        // Update the event with the document ID
        db.collection("events").document(docRef.documentID).updateData(["id": docRef.documentID])
    }
    
    // Function to fetch all events
    func fetchEvents(completion: @escaping ([Event]) -> Void) {
        db.collection("events").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching events: \(error.localizedDescription)")
                completion([])
            } else if let documents = snapshot?.documents {
                let events = documents.compactMap { document in
                    var event = try? document.data(as: Event.self)
                    event?.id = document.documentID
                    return event
                }
                completion(events)
            }
        }
    }
    
    // Function to create a new vendor
    func createSupplier(_ newSupplier: Supplier) {
        // Replace "suppliers" with your actual Firestore collection name
        db.collection("suppliers").document(newSupplier.id).setData([
            "fullName": newSupplier.fullName,
            "userName": newSupplier.userName,
            "phoneNumber": newSupplier.phoneNumber
            // Add other supplier properties as needed
        ]) { error in
            if let error = error {
                print("Error adding supplier document: \(error)")
            } else {
                print("Supplier document added with ID: \(newSupplier.id)")
            }
        }
    }
    
    // Function to check if a user with the provided email exists in Firestore
//    func userExistsWithEmail(_ email: String, completion: @escaping (Bool) -> Void) {
//        db.collection("suppliers").whereField("email", isEqualTo: email).getDocuments { (snapshot, error) in
//            if let error = error {
//                print("Error checking user existence: \(error.localizedDescription)")
//                completion(false)
//            } else {
//                completion(!(snapshot?.documents.isEmpty)! ?? false)
//            }
//        }
//    }

//    func currentUserDoc() -> DocumentReference? {
//        if AuthService.shared.Auth.auth().currentUser != nil {
//            return firestore.collection("suppliers").document(auth.currentUser?.uid ?? "")
//        }
//        return nil
//    }
//
//    func doesUserExist(completion: @escaping (Bool) -> Void) {
//        guard AuthService.shared.Auth.auth().currentUser != nil else { return }
//        currentUserDoc()?.getDocument { snapshot, error in
//            if snapshot != nil && error == nil {
//                completion(snapshot!.exists)
//            } else { completion(false) }
//        }
//    }
    func saveVendorDetails(_ v: VendorDetails, selectedCategory: String?, logoImage: Data?, menuImage: Data?) {
         var vendorData: [String: Any] = [
             "shopName": v.shopName,
             "address": v.address,
             "hours": v.hours,
             "flexibleRate": v.flexibleRate,
             // Add other vendor details as needed
         ]
         
         if let selectedCategory = selectedCategory {
             vendorData["selectedCategory"] = selectedCategory
         }
         
         // Convert images to data before saving
         if let logoImageData = logoImage {
             vendorData["logoImage"] = logoImageData
         }
         if let menuImageData = menuImage {
             vendorData["menuImage"] = menuImageData
         }
         
         db.collection("vendorDetails").document(v.id).setData(vendorData) { error in
             if let error = error {
                 print("Error adding vendor details document: \(error)")
             } else {
                 print("Vendor details document added with ID: \(v.id)")
             }
         }
     }
 }
