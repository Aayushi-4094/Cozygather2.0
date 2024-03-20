import SwiftUI

struct VendorList: View {
    @State private var searchText: String = ""
    @State private var isFilterScreenPresented = false
    @State private var selectedCategories: Set<String> = []
    @State private var lowerPrice = 0.0
    @State private var upperPrice = 100.0
    

    
    var vendors: [Vendor] = [
        Vendor(id: UUID().uuidString, imageName: "vendor1", title: "Vendor 1", category: "Bakery", description: "Description for Vendor 1", numberOfStars: 4, price: 12.99, hyperlinkText: "Details"),
        Vendor(id: UUID().uuidString, imageName: "Vendor2", title: "Vendor 2", category: "Decor", description: "Description for Vendor 2", numberOfStars: 2, price: 19.99, hyperlinkText: "Details"),
        Vendor(id: UUID().uuidString, imageName: "Vendor3", title: "Vendor 3", category: "Music", description: "Description for Vendor 3", numberOfStars: 4, price: 12.99, hyperlinkText: "Details"),
        Vendor(id: UUID().uuidString, imageName: "Vendor3", title: "Vendor 4", category: "Food", description: "Description for Vendor 4", numberOfStars: 4, price: 12.99, hyperlinkText: "Details"),
    ]
    
    var filteredVendors: [Vendor] {
        var filteredVendors = vendors
        
        if !searchText.isEmpty {
            filteredVendors = filteredVendors.filter { vendor in
                return vendor.title.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        if !selectedCategories.isEmpty {
            filteredVendors = filteredVendors.filter { vendor in
                return selectedCategories.contains(vendor.category)
            }
        }
        
        filteredVendors = filteredVendors.filter { vendor in
            return vendor.price >= lowerPrice && vendor.price <= upperPrice
        }
        
        return filteredVendors
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                List {
                    // Search & Filter section
                    Section {
                        HStack(spacing: 16) {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(Color(red: 82/255, green: 72/255, blue: 159/255)) // Adjusted color
                                    .padding(.horizontal, 8)
                                
                                TextField("Search", text: $searchText)
                                    .padding(8)
                                    .frame(maxWidth: .infinity)
                                    .cornerRadius(8)
                            }
                            
                            Spacer()
                            
                            Button {
                                isFilterScreenPresented.toggle()
                            } label: {
                                Label("Filter", systemImage: "slider.horizontal.3")
                                    .foregroundColor(.white)
                                    .font(.system(size: 14, weight: .semibold))
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 16)
                                    .background(Color(red: 82/255, green: 72/255, blue: 159/255))
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                    
                    
                    ForEach(filteredVendors) { vendor in
                        VendorListCustomBox1(vendor: vendor)
                            .padding(.vertical, 8)
                            .background(Color(red: 250/255, green: 244/255, blue: 250/255))
                    }
                    

                }
                Toolbar()
                    .padding(.bottom,-30)

                .background(Color(red: 250/255, green: 244/255, blue: 250/255))
                .listStyle(GroupedListStyle())
                .navigationBarItems(
                    leading: Text("Vendors Listing").font(.title.bold())
                )
                                
                if isFilterScreenPresented {
                    FilterScreen(selectedCategories: $selectedCategories, lowerPrice: $lowerPrice, upperPrice: $upperPrice, isFilterScreenPresented: $isFilterScreenPresented)
                }
            }
        }
    }
}

struct VendorListCustomBox1: View {
    var vendor: Vendor
    
    var body: some View {
        NavigationLink(destination: Text("Destination View")) {
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
                                    .foregroundColor(Color(red: 82/255, green: 72/255, blue: 159/255))
                            }
                        }
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text(vendor.hyperlinkText)
                            .font(.footnote)
                            .foregroundColor(Color(red: 82/255, green: 72/255, blue:                        159/255))
                            .underline()
                        
                        Text("\(vendor.price)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                }
            }
            .padding(.horizontal, 10)
            .background(Color(red: 250/255, green: 244/255, blue: 250/255))
        }
    }
}

struct Vendor: Identifiable {
    let id: String // Unique identifier for each vendor
    let imageName: String
    let title: String
    let category: String
    let description: String
    let numberOfStars: Int
    let price: Double
    let hyperlinkText: String
}

struct FilterScreen: View {
    @Binding var selectedCategories: Set<String>
    @Binding var lowerPrice: Double
    @Binding var upperPrice: Double
    @Binding var isFilterScreenPresented: Bool
    
    var categories = ["Bakery", "Decor", "Music", "Food"]
    
    var body: some View {
        VStack {
            Text("Filter")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color(red: 82/255, green: 72/255, blue: 159/255))
                .padding()
            
            VFilterOptionsView(selectedCategories: $selectedCategories, lowerPrice: $lowerPrice, upperPrice: $upperPrice, categories: categories)
            
            Spacer()
            
            VFilterActionButtonsView(isFilterScreenPresented: $isFilterScreenPresented)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .cornerRadius(30)
        .padding()
    }
}

struct VFilterOptionsView: View {
    @Binding var selectedCategories: Set<String>
    @Binding var lowerPrice: Double
    @Binding var upperPrice: Double
    var categories: [String]
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Categories")
                    .font(.headline)
                    .foregroundColor(Color(red: 82/255, green: 72/255, blue: 159/255))
                    .padding(.top, 20)
                    
                
                CategoriesView(selectedCategories: $selectedCategories, categories: categories)
            }
            
            VFilterPriceRangeView(lowerPrice: $lowerPrice, upperPrice: $upperPrice)
        }
        .padding()
    }
}

struct CategoriesView: View {
    @Binding var selectedCategories: Set<String>
    var categories: [String]
    
    var body: some View {
        HStack {
            ForEach(categories, id: \.self) { category in
                CategoryButtonView(category: category, isSelected: selectedCategories.contains(category)) {
                    if selectedCategories.contains(category) {
                        selectedCategories.remove(category)
                    } else {
                        selectedCategories.insert(category)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

struct CategoryButtonView: View {
    let category: String
    let isSelected: Bool
    let action: () -> Void
    
    var categoriesLogos: [String: String] = [
        "Bakery": "birthday.cake",
        "Decor": "snowflake",
        "Music": "music.note",
        "Food": "fork.knife.circle"
    ]
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: categoriesLogos[category] ?? "circle") // Use category logo from dictionary
                    .foregroundColor(isSelected ? .blue : Color(red: 82/225, green: 72/255, blue: 159/255))
                    .font(.title)
                    
                
                Text(category)
                    .foregroundColor(Color(red: 82/225, green: 72/255, blue: 159/255))
                    .font(.system(size: 10))
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .cornerRadius(10)
    }
}

struct VFilterPriceRangeView: View {
    @Binding var lowerPrice: Double
    @Binding var upperPrice: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Select price range")
                .font(.caption)
            
            HStack {
                Text("₹\(Int(lowerPrice))")
                Slider(value: $lowerPrice, in: 0...upperPrice, step: 1.0)
                Text("₹\(Int(upperPrice))")
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

struct VFilterActionButtonsView: View {
    @Binding var isFilterScreenPresented: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                isFilterScreenPresented.toggle()
            }) {
                Text("CANCEL")
                    .fontWeight(.bold)
                    .foregroundColor(.red)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            
            Spacer()
            
            Button(action: {
                // Apply filter action
                isFilterScreenPresented.toggle()
            }) {
                Text("APPLY")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(red: 82/255, green: 72/255, blue: 159/255))
            .cornerRadius(10)
            
            Spacer()
        }
    }
}

struct VendorList_preview: PreviewProvider {
    static var previews: some View {
        VendorList()
    }
}
