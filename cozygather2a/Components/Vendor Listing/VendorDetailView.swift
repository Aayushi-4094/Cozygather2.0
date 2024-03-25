import SwiftUI

struct VendorDetailView: View {
    let vendor: VendorDetails
    let onBookNow: () -> Void // Closure property to handle booking action

    var body: some View {
        ScrollView {
            ZStack{
                VStack {
                    Image(systemName: "photo")
                        .frame(width: 350, height: 200)
                              .background(Color(red: 230/255, green: 230/255, blue: 230/255))
                              .overlay(
                                  RoundedRectangle(cornerRadius: 12)
                                      .stroke(Color(red: 198/225, green: 174/255, blue: 128/255), lineWidth: 1)
                              )
                    if let logoImageData = vendor.logoImageData,
                       let logoImage = UIImage(data: logoImageData) {
                        Image(uiImage: logoImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 200)
                    }
                    HStack{
                        Text(vendor.shopName)
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                        // Book Now Button
                        VStack{
                            Button(action: {
                                // Call the closure when "Book Now" button is tapped
                                self.onBookNow()
                            }) {
                                Text("Book Now")
                                    .foregroundColor(Color(red: 198/225, green: 174/255, blue: 128/255))
                                    .padding()
                                    .background(Color(red:67/255, green:13/255, blue:75/255))
                                    .cornerRadius(15)
                            }
                            Spacer()
                            Text("Price: \(vendor.price)")
                        }
                        
                    }
                    Spacer()
                    VStack(alignment: .leading, spacing: 20){
                        Text("Address: \(vendor.address)")
                            .foregroundColor(Color(red:67/255, green:13/255, blue:75/255))
                        if let selectedCategory = vendor.selectedCategory {
                            Text("Selected Category: \(selectedCategory)")
                                .foregroundColor(Color(red:67/255, green:13/255, blue:75/255))
                        }
                        
                        
                        Text("Flexible Price: \(vendor.flexibleRate ? "Yes" : "No")")
                            .foregroundColor(Color(red:67/255, green:13/255, blue:75/255))
                        // Display menu image
                    }
                    Text("Menu Images")
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            // Existing image placeholders
                            EmptyView()
                                .frame(width: 150, height: 200)
                                .background(Color(red: 230/255, green: 230/255, blue: 230/255))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color(red: 198/225, green: 174/255, blue: 128/255), lineWidth: 1)
                                )
                            
                            // Additional system image
                            Image(systemName: "photo")
                                .frame(width: 150, height: 200)
                                .background(Color(red: 230/255, green: 230/255, blue: 230/255))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color(red: 198/225, green: 174/255, blue: 128/255), lineWidth: 1)
                                )
                            Image(systemName: "photo")
                                .frame(width: 150, height: 200)
                                .background(Color(red: 230/255, green: 230/255, blue: 230/255))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color(red: 198/225, green: 174/255, blue: 128/255), lineWidth: 1)
                                )
                            Image(systemName: "photo")
                                .frame(width: 100, height: 200)
                                .background(Color(red: 230/255, green: 230/255, blue: 230/255))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color(red: 198/225, green: 174/255, blue: 128/255), lineWidth: 1)
                                )
                        }
                    }
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
            
        }
        .navigationTitle("Vendor Detail")
        .background(Color(red:247/255, green: 239/255, blue:247/255))
    }
}

struct VendorDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Provide a closure for onBookNow parameter
        VendorDetailView(vendor: VendorDetails(id: "id", shopName: "SampleShop", price: "price", address: "address", hours: "time", flexibleRate: true, selectedCategory: "Category1", logoImageData: nil, menuImageData: nil), onBookNow: {})
    }
}
