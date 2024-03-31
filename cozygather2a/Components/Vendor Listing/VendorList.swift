import FirebaseFirestore
import SwiftUI

struct VendorList: View {
    @State private var vendors: [VendorDetails] = []
    @State private var bookedVendors: Set<String> = [] // Track booked vendors
    @State private var isFilterSheetPresented = false // Control filter sheet presentation
    @State private var selectedCategories: Set<String> = []
    @State private var lowerPrice: Double = 500
    @State private var upperPrice: Double = 10000
    @State private var selectedEvent: String? // Selected event name
    @State private var eventNames: [String]? // Event names fetched from Firestore
    @State private var isExpanded = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    let firestoreManager = FirestoreManager.shared
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack {
                    HStack {
                        DisclosureGroup(isExpanded: $isExpanded) {
                            VStack(alignment: .leading) {
                                if let eventNames = eventNames {
                                    ForEach(eventNames, id: \.self) { eventName in
                                        Button(action: {
                                            // Select the event name
                                            selectedEvent = eventName
                                            isExpanded.toggle() // Close the dropdown after selection
                                        }) {
                                            Text(eventName)
                                        }
                                    }
                                } else {
                                    ProgressView("Loading events...") // Show loading indicator while events are being fetched
                                }
                            }
                        } label: {
                            HStack {
                                Text(selectedEvent ?? "Select Event") // Display selected event name or default text
                                    .foregroundColor(selectedEvent != nil ? .black : Color(red:198/255, green:174/255, blue:128/255)) // Change text color based on selection
                                Image(systemName: "chevron.down") // Dropdown arrow icon
                                    .rotationEffect(isExpanded ? .degrees(180) : .zero)
                                    // Rotate arrow based on dropdown state
                            }
                            .foregroundColor(Color(red:67/255, green:13/255, blue:75/255))
                        }
                        .padding()
                        
                        Text("Total Booked Vendors: \(bookedVendors.count)")
                            .font(.system(size: 12))
                            .foregroundColor(Color(red: 198/225, green: 174/255, blue: 128/255))
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                        Spacer()
                    }
                    
                    List(vendors) { vendor in
                        NavigationLink(destination: VendorDetailView(vendor: vendor, onBookNow: {
                            // Update bookedVendors set when "Book Now" button is tapped
                            self.bookedVendors.insert(vendor.id)
                        })) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(vendor.shopName)
                                    .font(.headline)
                                Text("Price: \(vendor.price)")
                                    .font(.subheadline)
                                if let selectedCategory = vendor.selectedCategory {
                                    Text("Category: \(selectedCategory)") // Display selected category if available
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                if let logoImageData = vendor.logoImageData,
                                   let logoImage = UIImage(data: logoImageData) {
                                    Image(uiImage: logoImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 100, height: 100)
                                }
                                if bookedVendors.contains(vendor.id) { // Check if vendor is booked
                                    Text("Booked") // Display "Booked" if booked
                                        .foregroundColor(Color(red: 198/225, green: 174/255, blue: 128/255))
                                        .font(.caption)
                                }
                            }
                            .padding()
                        }
                    }
                    .navigationTitle("Vendor List")
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            saveDetailsToFirestore() // Call saveDetailsToFirestore() when Save button is clicked
                        }) {
                            Text("Save")
                                .foregroundColor(Color(red: 198/225, green: 174/255, blue: 128/255))
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .padding()
                                .cornerRadius(10)
                        }
                    }
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        Button(action: {
//                            // Show filter sheet
//                            isFilterSheetPresented.toggle()
//                        }) {
//                            Image(systemName: "line.3.horizontal.decrease.circle.fill")
//                                .foregroundColor(Color(red: 67/225, green: 13/225, blue: 75/225))
//                                .font(.system(size: 28))
//                        }
//                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Details Saved"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
//                .sheet(isPresented: $isFilterSheetPresented) {
//                    FilterScreen(selectedCategories: $selectedCategories,
//                                 lowerPrice: $lowerPrice,
//                                 upperPrice: $upperPrice,
//                                 isFilterScreenPresented: $isFilterSheetPresented)
//                }
              //  .padding(.bottom, 40)
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        HStack {
                            Toolbar()
                        }
                        .offset(y:20)
                    }
                }
                .onAppear {
                    fetchVendors()
                    fetchEvents()
                }
            }
            .background(Color(red:247/255, green: 239/255, blue:247/255))
        }
    }
    
    private func fetchVendors() {
        firestoreManager.fetchAllVendorDetails { fetchedVendors in
            if let fetchedVendors = fetchedVendors {
                // Apply filtering based on selected categories and price range
                let filteredVendors = fetchedVendors.filter { vendor in
                    // Check if vendor's category is selected and price is within the range
                    return selectedCategories.isEmpty || selectedCategories.contains(vendor.selectedCategory ?? "") &&
                        (lowerPrice...upperPrice).contains(Double(vendor.price) ?? 0)
                }
                self.vendors = filteredVendors
            }
        }
    }

    
    private func fetchEvents() {
        firestoreManager.fetchEventNames { eventNames in
            // Assuming you have fetched event names successfully
            // Update the UI with the event names
            self.eventNames = eventNames

            // If there are events and no event is selected yet, set the selected event to the first event
            if !eventNames.isEmpty && selectedEvent == nil {
                selectedEvent = eventNames[0]
            }
        }
    }
    // Function to save details to Firestore
    private func saveDetailsToFirestore() {
        // Check if selectedEvent is nil
        guard let selectedEvent = selectedEvent else {
            showAlert = true
            alertMessage = "Please select an event before saving."
            return
        }
        // Prepare the data to be saved
        var bookedVendorsData: [[String: Any]] = []
        for vendor in vendors {
            // Convert each vendor object to dictionary format for Firestore
            let vendorData: [String: Any] = [
                "id": vendor.id,
                "shopName": vendor.shopName,
                "category": vendor.selectedCategory ?? "", // Add category, use empty string if not available
                "price": vendor.price, // Add price
                // Add other vendor details as needed
            ]
            bookedVendorsData.append(vendorData)
        }
        // Call FirestoreManager's method to save booked vendors
        firestoreManager.saveBookedVendors(event: selectedEvent, totalBookedVendors: bookedVendors.count, bookedVendorsData: bookedVendorsData)

        // Reset state variables
        self.selectedEvent = nil
        eventNames = nil
        bookedVendors.removeAll()
        showAlert = true
        alertMessage = "Details saved successfully"
    }

}



struct VendorList_Previews: PreviewProvider {
    static var previews: some View {
        VendorList()
    }
}

