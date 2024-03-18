import FirebaseFirestore

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

    // Add additional functions as needed for fetching user or event information
}
