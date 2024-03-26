import FirebaseFirestore
import SwiftUI

struct VendorDetails: Identifiable, Hashable { // Conform to Hashable
    var id: String
    var shopName: String
    var price: String
    var address: String
    var hours: String
    var flexibleRate: Bool
    var selectedCategory: String? // Add selectedCategory property
    var logoImageData: Data? // Variable to store the logo image data
    var menuImageData: Data? // Variable to store the menu image data
    // Add other vendor properties as needed

    // Implement Hashable protocol
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: VendorDetails, rhs: VendorDetails) -> Bool {
        return lhs.id == rhs.id
    }
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
    var initialPrice: String // Initial price added here
    var selectedDate: Date
    var selectedCoHosts: [String]

    // Add other properties as needed, e.g., eventDescription, maxParticipants, etc.

    init(eventName: String, venueAddress: String, initialPrice: String, selectedDate: Date, selectedCoHosts: [String]) {
        self.eventName = eventName
        self.venueAddress = venueAddress
        self.initialPrice = initialPrice
        self.selectedDate = selectedDate
        self.selectedCoHosts = selectedCoHosts
        // Initialize other properties as needed
    }
}

class FirestoreManager: ObservableObject {
    static let shared = FirestoreManager()
    let db = Firestore.firestore()
    
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
            "initialPrice": event.initialPrice,
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
    
    func fetchEventNames(completion: @escaping ([String]) -> Void) {
        db.collection("events").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching event names: \(error.localizedDescription)")
                completion([])
            } else if let documents = snapshot?.documents {
                let eventNames = documents.compactMap { $0.data()["eventName"] as? String }
                completion(eventNames)
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

    func saveVendorDetails(_ v: VendorDetails, selectedCategory: String?, logoImage: Data?, menuImage: Data?, completion: @escaping (String?, Error?) -> Void) {
        var vendorData: [String: Any] = [
            "shopName": v.shopName,
            "address": v.address,
            "price": v.price,
            "hours": v.hours,
            "flexibleRate": v.flexibleRate,
            // Add other vendor details as needed
        ]
        
        if let selectedCategory = selectedCategory {
            vendorData["selectedCategory"] = selectedCategory
        }
        
        if let logoImage = logoImage {
            vendorData["logoImageData"] = logoImage
        }
        if let menuImage = menuImage {
            vendorData["menuImageData"] = menuImage
        }
        
        db.collection("vendorDetails").document(v.id).setData(vendorData) { error in
            if let error = error {
                print("Error adding vendor details document: \(error)")
                completion(nil, error)
            } else {
                print("Vendor details document added with ID: \(v.id)")
                completion("URL_of_uploaded_image", nil) // Replace "URL_of_uploaded_image" with the actual image URL
            }
        }
    }


    func fetchVendorDetails(forVendorID vendorID: String, completion: @escaping (VendorDetails?) -> Void) {
        // Fetch vendor details document from Firestore using the vendor's ID
        db.collection("vendorDetails").document(vendorID).getDocument { document, error in
            if let error = error {
                print("Error fetching vendor details: \(error.localizedDescription)")
                completion(nil) // Pass nil to the completion handler indicating an error
            } else if let document = document, document.exists {
                // Parse document data to VendorDetails object
                if let data = document.data(),
                   let shopName = data["shopName"] as? String,
                   let address = data["address"] as? String,
                   let price = data["price"] as? String,
                   let hours = data["hours"] as? String,
                   let flexibleRate = data["flexibleRate"] as? Bool {
                    let vendorDetails = VendorDetails(id: document.documentID, shopName: shopName, price: price, address: address, hours: hours, flexibleRate: flexibleRate)
                    completion(vendorDetails) // Pass fetched vendor details to the completion handler
                } else {
                    completion(nil) // Pass nil to the completion handler if data parsing fails
                }
            } else {
                completion(nil) // Pass nil to the completion handler if document doesn't exist
            }
        }
    }

    func fetchAllVendorDetails(completion: @escaping ([VendorDetails]?) -> Void) {
        db.collection("vendorDetails").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching vendor details: \(error.localizedDescription)")
                completion(nil) // Pass nil to the completion handler indicating an error
            } else if let documents = snapshot?.documents {
                let vendors = documents.compactMap { document in
                    // Parse each document to a VendorDetails object
                    let data = document.data()
                    let shopName = data["shopName"] as? String ?? ""
                    let price = data["price"] as? String ?? ""
                    let address = data["address"] as? String ?? ""
                    let hours = data["hours"] as? String ?? ""
                    let flexibleRate = data["flexibleRate"] as? Bool ?? false
                    let logoImageData = data["logoImageData"] as? Data
                    let menuImageData = data["menuImageData"] as? Data

                    return VendorDetails(id: document.documentID, shopName: shopName, price: price, address: address, hours: hours, flexibleRate: flexibleRate, logoImageData: logoImageData, menuImageData: menuImageData)
                }
                completion(vendors) // Pass fetched vendors to the completion handler
            }
        }
    }
    
    func saveBookedVendors(event: String, totalBookedVendors: Int, bookedVendorsData: [[String: Any]]) {
        // Initialize a dictionary to store booked vendor statistics
        var bookedVendorStats: [String: Any] = [
            "totalBookedVendors": totalBookedVendors
        ]

        // Initialize an array to store details of booked vendors
        var bookedVendors: [[String: Any]] = []

        // Iterate through booked vendors data to extract category and price
        for vendorData in bookedVendorsData {
            if let category = vendorData["category"] as? String,
               let price = vendorData["price"] as? String {
                // Append category and price to the booked vendors array
                bookedVendors.append(["category": category, "price": price])
            }
        }

        // Add booked vendors data to the bookedVendorStats dictionary
        bookedVendorStats["bookedVendors"] = bookedVendors

        // Save the total number of booked vendors for the event along with category and price statistics
        db.collection("eventStatistics").document(event).setData(bookedVendorStats, merge: true) { error in
            if let error = error {
                print("Error updating event statistics: \(error)")
            } else {
                print("Event statistics updated successfully")
            }
        }
    }
    
    // Function to fetch all events along with their initial prices
    func fetchEventNamesWithPrices(completion: @escaping ([(String, String)]) -> Void) {
        db.collection("events").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching event names: \(error.localizedDescription)")
                completion([])
            } else if let documents = snapshot?.documents {
                let eventNamesWithPrices = documents.compactMap { document -> (String, String)? in
                    if let eventName = document.data()["eventName"] as? String,
                       let price = document.data()["price"] as? String {
                        return (eventName, price)
                    }
                    return nil
                }
                completion(eventNamesWithPrices)
            }
        }
    }
//    func fetchEventStatistics(completion: @escaping ([EventStatistics]?) -> Void) {
//        var fetchedEventStatistics: [EventStatistics] = []
//
//        // Fetch events from the Firestore "events" collection
//        fetchEvents { events in
//            guard let events = events else {
//                completion(nil)
//                return
//            }
//
//            // Iterate through each event to fetch additional statistics
//            for event in events {
//                // Fetch event statistics from the Firestore "eventStatistics" collection
//                self.db.collection("eventStatistics").document(event.eventName).getDocument { document, error in
//                    if let error = error {
//                        print("Error fetching event statistics: \(error.localizedDescription)")
//                        completion(nil)
//                        return
//                    }
//
//                    guard let document = document, document.exists else {
//                        print("No statistics found for event: \(event.eventName)")
//                        completion(nil)
//                        return
//                    }
//
//                    // Extract statistics data from the document
//                    if let data = document.data(),
//                       let totalBookedVendors = data["totalBookedVendors"] as? Int,
//                       let bookedVendorsData = data["bookedVendors"] as? [[String: Any]] {
//                        let bookedVendors = bookedVendorsData.compactMap { vendorData -> BookedVendor? in
//                            guard let category = vendorData["category"] as? String,
//                                  let price = vendorData["price"] as? String else {
//                                return nil
//                            }
//                            return BookedVendor(category: category, price: price)
//                        }
//
//                        // Create EventStatistics instance with fetched data
//                        let eventStatistics = EventStatistics(eventName: event.eventName, initialPrice: event.initialPrice, totalBookedVendors: totalBookedVendors, bookedVendors: bookedVendors)
//                        fetchedEventStatistics.append(eventStatistics)
//                    } else {
//                        print("Invalid data format for event statistics: \(document.documentID)")
//                    }
//
//                    // Check if all events have been processed
//                    if fetchedEventStatistics.count == events.count {
//                        completion(fetchedEventStatistics)
//                    }
//                }
//            }
//        }
//    }


}
