import SwiftUI

struct Vendor: Identifiable {
    let id: String // Unique identifier for each vendor
    let imageName: String
    let title: String
    let category: String
    let description: String
    let price: Double
    let hyperlinkText: String
    var isBooked: Bool = false // State for booking status, initially false
}
struct FilterScreen: View {
    @Binding var selectedCategories: Set<String>
    @Binding var lowerPrice: Double
    @Binding var upperPrice: Double
    @Binding var isFilterScreenPresented: Bool
    
    @State private var selectedDate = Date()
    @State private var location = ""
    
    var categories = ["Bakery", "Decor", "Music", "Food"]
    
    var body: some View {
        VStack {
            Text("Filter")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            Divider()
            
            ScrollView {
                VStack {
                    VStack(alignment: .leading) {
                        Text("Categories")
                            .font(.headline)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(categories, id: \.self) { category in
                                    CategoryButton(category: category, isSelected: selectedCategories.contains(category)) {
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
                    .padding()
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("Price Range")
                            .font(.headline)
                        Slider(value: $lowerPrice, in: 0...100, step: 1)
                    }
                    .padding()
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("Date")
                            .font(.headline)
                        
                        DatePicker("", selection: $selectedDate, displayedComponents: .date)
                            .labelsHidden()
                    }
                    .padding()
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("Location")
                            .font(.headline)
                        
                        TextField("Enter location", text: $location)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                    }
                    .padding()
                }
            }
            
            Spacer()
            
            HStack {
                Button("Apply") {
                    // Apply filters
                    isFilterScreenPresented.toggle()
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
                
                Button("Reset") {
                    // Reset filters
                    selectedCategories = []
                    lowerPrice = 0
                    upperPrice = 100
                    selectedDate = Date()
                    location = ""
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(8)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(trailing: Button("Close") {
            isFilterScreenPresented.toggle()
        })
    }
}


struct CategoryButton: View {
    let category: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(category)
                .font(.headline)
                .foregroundColor(isSelected ? .white : .blue)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(isSelected ? Color.blue : Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue, lineWidth: isSelected ? 0 : 1)
                )
        }
    }
}

struct VendorList: View {
    @State private var searchText: String = ""
    @State private var isFilterScreenPresented = false
    @State private var selectedCategories: Set<String> = []
    @State private var lowerPrice = 0.0
    @State private var upperPrice = 100.0
    
    var vendors: [Vendor] = [
        Vendor(id: UUID().uuidString, imageName: "vendor1", title: "Vendor 1", category: "Bakery", description: "Description for Vendor 1", price: 12.99, hyperlinkText: "Details"),
        Vendor(id: UUID().uuidString, imageName: "Vendor2", title: "Vendor 2", category: "Decor", description: "Description for Vendor 2", price: 19.99, hyperlinkText: "Details"),
        Vendor(id: UUID().uuidString, imageName: "Vendor3", title: "Vendor 3", category: "Music", description: "Description for Vendor 3", price: 12.99, hyperlinkText: "Details"),
        Vendor(id: UUID().uuidString, imageName: "Vendor3", title: "Vendor 4", category: "Food", description: "Description for Vendor 4", price: 12.99, hyperlinkText: "Details"),
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
            VStack {
                List {
                    Section(header: SearchFilterHeader(), footer: Text("Total: \(filteredVendors.count)")) {
                        ForEach(filteredVendors) { vendor in
                            VendorListCustomBox1(vendor: vendor)
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                
                // Navigation Link to present FilterScreen
                NavigationLink(destination: FilterScreen(selectedCategories: $selectedCategories, lowerPrice: $lowerPrice, upperPrice: $upperPrice, isFilterScreenPresented: $isFilterScreenPresented), isActive: $isFilterScreenPresented) {
                    EmptyView()
                }
                .hidden() // Hide the link view
                
            }
            .navigationTitle("Vendor Listing")
            .navigationBarItems(trailing: filterButton)
        }
    }
    
    private var filterButton: some View {
        Button(action: {
            // Toggle isFilterScreenPresented to true to open the filter screen
            isFilterScreenPresented.toggle()
        }) {
            Image(systemName: "slider.horizontal.3")
                .foregroundColor(.blue)
        }
    }
    
    private func SearchFilterHeader() -> some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.purple)
            TextField("Search", text: $searchText)
                .padding(.vertical, 8)
        }
        .padding(.horizontal)
        .background(Color(.white))
        .cornerRadius(10)
        .padding()
        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.purple, lineWidth: 2))
    }
}

struct VendorListCustomBox1: View {
    @State var vendor: Vendor // Use @State for local modification
        var body: some View {
            NavigationLink(destination: VendorDetailView(vendor: $vendor)) {
            HStack(spacing: 12) {
                Image(vendor.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .cornerRadius(10)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(vendor.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text("₹\(String(format: "%.2f", vendor.price))")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                    Text(vendor.hyperlinkText)
                        .font(.subheadline)
                        .foregroundColor(.blue)
                        .underline()
                }
                
                if vendor.isBooked {
                    Text("Booked") // Display "Booked" label if vendor is booked
                        .foregroundColor(.green)
                        .fontWeight(.bold)
                }
            }
            .padding(.vertical, 8)
        }
    }
}

struct VendorDetailView: View {
    @Binding var vendor: Vendor // Use @Binding to make vendor mutable
    @State private var isVendorBooked = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Logo image
                Image(systemName: "camera")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                
                // Shop name and book now button
                HStack {
                    Text("Vendor Shop")
                        .font(.title)
                        .foregroundColor(Color.black) // Light golden text color
                    Spacer()
                    Button("Book Now") {
                        // Handle booking action
                        isVendorBooked = true // Update local state
                        vendor.isBooked = true // Update original vendor state
                    }
                    .padding()
                    .foregroundColor(.white) // Light golden text color
                    .background(Color.blue)
                    .cornerRadius(8)
                }
                .padding(.horizontal)
                
                // Price
                Text("Price: ₹\(String(format: "%.2f", vendor.price))")
                    .font(.title)
                    .foregroundColor(Color.black) // Light golden text color
                    .padding(.horizontal)
                
                // Address and working hours
                VStack(alignment: .leading, spacing: 8) {
                    Text("Address: 123 Main St")
                        .foregroundColor(.black) // White text color
                    Text("Working Hours: 9:00 AM - 6:00 PM")
                        .foregroundColor(.black) // White text color
                }
                .padding(.horizontal)
                
                // Menu images
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(0..<3) { _ in
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 120, height: 120)
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarTitle("Vendor Shop", displayMode: .inline)
        .onDisappear {
            // Reset local state when view disappears
            isVendorBooked = false
        }
    }
}


struct VendorList_preview: PreviewProvider {
    static var previews: some View {
        VendorList()
    }
}
