import FirebaseFirestore
import SwiftUI

struct VendorList: View {
    @State private var vendors: [VendorDetails] = []
    @State private var bookedVendors: Set<String> = [] // Track booked vendors
    @State private var isFilterSheetPresented = false // Control filter sheet presentation
    @State private var selectedCategories: Set<String> = []
    @State private var lowerPrice: Double = 500
    @State private var upperPrice: Double = 10000
    let firestoreManager = FirestoreManager.shared

    var body: some View {
        NavigationView {
            VStack {
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
                // Display total number of vendors booked
                Text("Total Booked Vendors: \(bookedVendors.count)")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .padding(.top, 4)
                    .padding(.bottom, 8) // Add some bottom padding for spacing
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

        }
        .onAppear {
            fetchVendors()
        }
    }

    private func fetchVendors() {
        firestoreManager.fetchAllVendorDetails { fetchedVendors in
            if let fetchedVendors = fetchedVendors {
                self.vendors = fetchedVendors
            }
        }
    }
}

struct VendorList_Previews: PreviewProvider {
    static var previews: some View {
        VendorList()
    }
}
