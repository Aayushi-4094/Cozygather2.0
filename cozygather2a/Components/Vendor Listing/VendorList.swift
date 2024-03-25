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
    let firestoreManager = FirestoreManager.shared

    var body: some View {
        NavigationView {
            VStack {
                HStack{
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
                                .foregroundColor(selectedEvent != nil ? .black : .gray) // Change text color based on selection
                           Image(systemName: "chevron.down") // Dropdown arrow icon
                                .rotationEffect(isExpanded ? .degrees(180) : .zero) // Rotate arrow based on dropdown state
                        }
                    }
                    .padding()
                    
                    Text("Total Booked Vendors: \(bookedVendors.count)")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                        .padding(.top, 4)
                        .padding(.bottom, 8)
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
                            if let logoImageData = vendor.logoImageData,
                               let logoImage = UIImage(data: logoImageData) {
                                Image(uiImage: logoImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)
                            }
                            if bookedVendors.contains(vendor.id) { // Check if vendor is booked
                                Text("Booked") // Display "Booked" if booked
                                    .foregroundColor(.red)
                                    .font(.caption)
                            }
                        }
                        .padding()
                    }
                }
                .navigationTitle("Vendor List")
                
                 // Add some bottom padding for spacing
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        // Show filter sheet
                        // Save action here
                    }) {
                        Text("Save")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Show filter sheet
                        isFilterSheetPresented.toggle()
                    }) {
                        Image(systemName: "line.horizontal.3")
                    }
                }
            }
            .sheet(isPresented: $isFilterSheetPresented) {
                FilterScreen(selectedCategories: $selectedCategories,
                             lowerPrice: $lowerPrice,
                             upperPrice: $upperPrice,
                             isFilterScreenPresented: $isFilterSheetPresented)
            }
            .padding(.bottom, 40)
            .onAppear {
                fetchVendors()
                fetchEvents()
            }
        }
    }

    private func fetchVendors() {
        firestoreManager.fetchAllVendorDetails { fetchedVendors in
            if let fetchedVendors = fetchedVendors {
                self.vendors = fetchedVendors
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
}

struct VendorList_Previews: PreviewProvider {
    static var previews: some View {
        VendorList()
    }
}
