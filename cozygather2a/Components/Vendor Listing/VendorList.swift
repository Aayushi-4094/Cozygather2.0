import SwiftUI

struct VendorList: View {
    @State private var searchText: String = ""
    @State private var isFilterScreenPresented = false
    
    var vendors: [Vendor] = [
        // Replace with your actual vendor data
        Vendor(id: UUID().uuidString, imageName: "Vendor1", title: "Vendor 1", description: "Description for Vendor 1", numberOfStars: 4, price: "$12.99", hyperlinkText: "Details"),
        Vendor(id: UUID().uuidString, imageName: "Vendor2", title: "Vendor 2", description: "Description for Vendor 2", numberOfStars: 2, price: "$19.99", hyperlinkText: "Details"),
        Vendor(id: UUID().uuidString, imageName: "Vendor3", title: "Vendor 3", description: "Description for Vendor 3", numberOfStars: 4, price: "$12.99", hyperlinkText: "Details"),
//        Vendor(id: UUID().uuidString, imageName: "Vendor4", title: "Vendor 4", description: "Description for Vendor 4", numberOfStars: 1, price: "$19.99", hyperlinkText: "Details"),
        // ... Add more vendors
    ]
    
    var body: some View {
        NavigationView {
            List {
                // Search & Filter section
                Section {
                    HStack(spacing: 16) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.secondary)
                                .padding(.horizontal, 8)
                            
                            TextField("Search", text: $searchText)
                                .padding(8)
                                .frame(maxWidth: .infinity)
                                .background(Color(.systemGray3))
                                .cornerRadius(8)
                        }
                        Spacer()
                        Button {
                            isFilterScreenPresented.toggle()
                        } label: {
                            Label("Filter", systemImage: "slider.horizontal.3")
                                .foregroundColor(.white)
                                .font(.system(.headline, weight: .semibold))
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .background(Color(red: 82/225, green: 72/255, blue: 159/255))
                                .cornerRadius(10)
                        }
                        .sheet(isPresented: $isFilterScreenPresented) {
                            FilterScreen() // Placeholder for your FilterScreen view
                        }
                    }
                    .padding(.vertical, 8)
                }
                // Vendor List section
                ForEach(vendors) { vendor in
                    VendorListCustomBox1(vendor: vendor)
                        .padding(.vertical, 8)
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 16)) // Adjust trailing inset for better spacing
                }
                Toolbar()
                    .position(x:178,y: 36)
            }
            .listStyle(GroupedListStyle())
            .navigationBarItems(
                leading: Text("Vendors Listing").font(.title.bold())
            )
            
        }
        
    }
    
}

struct VendorListCustomBox1: View {
  var vendor: Vendor

  var body: some View {
    NavigationLink(destination: View1()) { // Replace View1() with your actual destination view
      VStack(alignment: .leading, spacing: 8) {
        HStack(alignment: .top) {
          Image(vendor.imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 160)

          VStack(alignment: .leading) {
            Text(vendor.title)
              .font(.headline)
              .foregroundColor(.primary)

            Text(vendor.description)
              .font(.subheadline)
              .foregroundColor(.secondary)

            HStack {
              ForEach(0..<vendor.numberOfStars) { _ in
                Image(systemName: "star.fill")
                  .foregroundColor(Color(red: 82/225, green: 72/255, blue: 159/255))
              }
            }
          }
          .padding(.top, 25) // Adjust top padding for better spacing
        HStack(alignment: .bottom) {
              Spacer()
              VStack(alignment: .trailing) {
                Text(vendor.hyperlinkText)
                  .font(.footnote)
                  .foregroundColor(Color(red: 82/225, green: 72/255, blue: 159/255))
                  .underline()
                Text(vendor.price)
                  .font(.title2)
                  .fontWeight(.bold)
                  .foregroundColor(.black)
              }.padding(.top, 25)
            }
        }
      }
      .padding(.horizontal, 10) // Add horizontal padding for better spacing
    }
  }
}

struct Vendor: Identifiable {
  let id: String // Unique identifier for each vendor
  let imageName: String
  let title: String
  let description: String
  let numberOfStars: Int
  let price: String
  let hyperlinkText: String
}

struct VendorList_Previews: PreviewProvider {
    static var previews: some View {
        VendorList()
            .environment(\.colorScheme, .light) // Ensure light mode for preview
    }
}
