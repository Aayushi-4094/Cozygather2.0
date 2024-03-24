import FirebaseFirestore
import SwiftUI

struct VendorList: View {
    @State private var vendors: [VendorDetails] = [] // Update vendors array to hold VendorDetails objects
    let firestoreManager = FirestoreManager.shared

    var body: some View {
        NavigationView {
            VStack {
                List(vendors) { vendor in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(vendor.shopName)
                            .font(.headline)
                        Text(vendor.address)
                            .font(.subheadline)
                        if let logoImageData = vendor.logoImageData,
                           let logoImage = UIImage(data: logoImageData) {
                            Image(uiImage: logoImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                        }
                        if let menuImageData = vendor.menuImageData,
                           let menuImage = UIImage(data: menuImageData) {
                            Image(uiImage: menuImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                        }
                    }
                    .padding()
                }
                .navigationTitle("Vendor List")
            }
        }
        .onAppear {
            fetchVendors() // Fetch vendors when the view appears
        }
    }

    private func fetchVendors() {
        firestoreManager.fetchAllVendorDetails { fetchedVendors in
            if let fetchedVendors = fetchedVendors {
                self.vendors = fetchedVendors // Update vendors array with fetched vendor details
            }
        }
    }
}

struct VendorList_Previews: PreviewProvider {
    static var previews: some View {
        VendorList()
    }
}

// MARK: - FirestoreManager extension with fetchAllVendorDetails function

extension FirestoreManager {
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
}
