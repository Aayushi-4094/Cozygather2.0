import SwiftUI

struct VendorDetailView: View {
    let vendor: VendorDetails
    let onBookNow: () -> Void // Closure property to handle booking action

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let logoImageData = vendor.logoImageData,
                   let logoImage = UIImage(data: logoImageData) {
                    Image(uiImage: logoImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
                }
                
                Text(vendor.shopName)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Address: \(vendor.address)")
                
                Text("Price: \(vendor.price)")
                
                if let selectedCategory = vendor.selectedCategory {
                    Text("Selected Category: \(selectedCategory)")
                }
                
                Text("Flexible Price: \(vendor.flexibleRate ? "Yes" : "No")")
                
                // Book Now Button
                Button(action: {
                    // Call the closure when "Book Now" button is tapped
                    self.onBookNow()
                }) {
                    Text("Book Now")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                
                // Display menu image
                if let menuImageData = vendor.menuImageData,
                   let menuImage = UIImage(data: menuImageData) {
                    Image(uiImage: menuImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Vendor Detail")
    }
}

struct VendorDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Provide a closure for onBookNow parameter
        VendorDetailView(vendor: VendorDetails(id: "id", shopName: "SampleShop", price: "price", address: "address", hours: "time", flexibleRate: true, selectedCategory: "Category1", logoImageData: nil, menuImageData: nil), onBookNow: {})
    }
}
