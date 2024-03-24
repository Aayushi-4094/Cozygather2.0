//import SwiftUI
//
//struct FilterScreen: View {
//    var body: some View {
//        VStack {
//            Text("Filter")
//                .font(.title)
//                .fontWeight(.bold)
//                .padding()
//            
//            VFilterOptionsView()
//            
//            Spacer()
//            
//            VFilterActionButtonsView()
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color.white)
//        .cornerRadius(30)
//        .padding()
//    }
//}
//
//struct VFilterOptionsView: View {
//    var body: some View {
//        VStack {
//            HStack {
//                VFilterOptionButtonView(label: "Completed orders", icon: "checkmark.circle.fill")
//                   
//                VFilterOptionButtonView(label: "Pending orders", icon: "clock.fill")
//                    
//            }
//            .padding(.bottom)
//            
//            VStack(alignment: .leading) {
//                Text("Categories")
//                    .font(.headline)
//                    .padding(.top, 20)
//                    .padding(.horizontal)
//                CategoriesView()
//            }
//            
//            VFilterDateSelectionView()
//            
//            VFilterLocationSelectionView()
//            
//            VFilterPriceRangeView()
//        }
//        .padding()
//    }
//}
//
//struct VFilterOptionButtonView: View {
//    var label: String
//    var icon: String
//    
//    var body: some View {
//        Button(action: {}) {
//            VStack {
//                Image(systemName: icon)
//                    .font(.title)
//                    .foregroundColor(.blue)
//                Text(label)
//                    .font(.caption)
//            }
//            .frame(maxWidth: .infinity)
//        }
//        .padding()
//        .cornerRadius(10)
//    }
//}
//
//struct VFilterDateSelectionView: View {
//    var body: some View {
//        HStack {
//            Text("Date")
//                .font(.caption)
//            Spacer()
//            VDateSelectionButtonView(label: "Select from Calendar")
//        }
//        .padding()
//        .background(Color.gray.opacity(0.2))
//        .cornerRadius(10)
//    }
//}
//
//struct VDateSelectionButtonView: View {
//    var label: String
//    
//    var body: some View {
//        Button(action: {}) {
//            Text(label)
//                .font(.caption)
//                .foregroundColor(.blue)
//        }
//    }
//}
//
//struct VFilterLocationSelectionView: View {
//    var body: some View {
//        HStack {
//            Text("Location")
//                .font(.caption)
//            Spacer()
//            Text("Choose")
//                .font(.caption)
//                .foregroundColor(.blue)
//            Image(systemName: "chevron.right")
//                .foregroundColor(.blue)
//        }
//        .padding()
//        .background(Color.gray.opacity(0.2))
//        .cornerRadius(10)
//    }
//}
//
//struct VFilterPriceRangeView: View {
//    @State private var lowerPrice = 20.0
//    @State private var upperPrice = 100.0
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text("Select price range")
//                .font(.caption)
//            HStack {
//                Text("₹\(Int(lowerPrice))")
//                Slider(value: $lowerPrice, in: 0...upperPrice, step: 1.0)
//                Text("₹\(Int(upperPrice))")
//            }
//        }
//        .padding()
//        .background(Color.gray.opacity(0.2))
//        .cornerRadius(10)
//    }
//}
//
//struct CategoriesView: View {
//    var body: some View {
//        HStack {
//            Spacer()
//            Bakery()
//            Spacer()
//            Decor()
//            Spacer()
//            Music()
//            Spacer()
//            Food()
//            Spacer()
//        }
//        .padding(.horizontal)
//    }
//}
//
//struct VFilterActionButtonsView: View {
//    var body: some View {
//        HStack {
//            Spacer()
//            Button(action: {}) {
//                Text("RESET")
//                    .fontWeight(.bold)
//                    .foregroundColor(.red)
//            }
//            .frame(maxWidth: .infinity)
//            .padding()
//            .background(Color.gray.opacity(0.2))
//            .cornerRadius(10)
//            Spacer()
//            Button(action: {}) {
//                Text("APPLY")
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)
//            }
//            .frame(maxWidth: .infinity)
//            .padding()
//            .background(Color.blue)
//            .cornerRadius(10)
//            Spacer()
//        }
//    }
//}
//
//struct Bakery: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "birthday.cake")
//                .resizable()
//                .frame(width: 50, height: 50)
//                .foregroundColor(.blue)
//                .clipShape(Circle())
//            
//            Text("Bakery")
//                .font(.caption)
//        }
//    }
//}
//
//struct Decor: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "snowflake")
//                .resizable()
//                .frame(width: 50, height: 50)
//                .foregroundColor(.blue)
//                .clipShape(Circle())
//            
//            Text("Decor")
//                .font(.caption)
//        }
//    }
//}
//
//struct Music: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "music.note")
//                .resizable()
//                .frame(width: 50, height: 50)
//                .foregroundColor(.blue)
//                .clipShape(Circle())
//            
//            Text("Music")
//                .font(.caption)
//        }
//    }
//}
//
//struct Food: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "fork.knife.circle")
//                .resizable()
//                .frame(width: 50, height: 50)
//                .foregroundColor(.blue)
//                .clipShape(Circle())
//            
//            Text("Food")
//                .font(.caption)
//        }
//    }
//}
//
//struct FilterScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        FilterScreen()
//    }
//}
//import SwiftUI
//
//struct VendorDetails: Identifiable {
//
//    let hyperlinkText: String
//    var isBooked: Bool = false // State for booking status, initially false
//    var id: String
//        var shopName: String
//        var price: String
//        var address: String
//        var hours: String
//        var flexibleRate: Bool
//        var selectedCategory: String? // Add selectedCategory property
//        var logoImageData: Data? // Variable to store the logo image data
//        var menuImageData: Data?
//}
//struct FilterScreen: View {
//    @Binding var selectedCategories: Set<String>
//    @Binding var lowerPrice: Double
//    @Binding var upperPrice: Double
//    @Binding var isFilterScreenPresented: Bool
//    
//    @State private var selectedDate = Date()
//    @State private var location = ""
//    
//    var categories = ["Bakery", "Decor", "Music", "Food"]
//    
//    var body: some View {
//        VStack {
//            Text("Filter")
//                .font(.title)
//                .fontWeight(.bold)
//                .padding()
//            
//            Divider()
//            
//            ScrollView {
//                VStack {
//                    VStack(alignment: .leading) {
//                        Text("Categories")
//                            .font(.headline)
//                        
//                        ScrollView(.horizontal, showsIndicators: false) {
//                            HStack {
//                                ForEach(categories, id: \.self) { category in
//                                    CategoryButton(category: category, isSelected: selectedCategories.contains(category)) {
//                                        if selectedCategories.contains(category) {
//                                            selectedCategories.remove(category)
//                                        } else {
//                                            selectedCategories.insert(category)
//                                        }
//                                    }
//                                }
//                            }
//                            .padding(.horizontal)
//                        }
//                    }
//                    .padding()
//                    
//                    Divider()
//                    
//                    VStack(alignment: .leading) {
//                        Text("Price Range")
//                            .font(.headline)
//                        Slider(value: $lowerPrice, in: 0...100, step: 1)
//                    }
//                    .padding()
//                    
//                    Divider()
//                    
//                    VStack(alignment: .leading) {
//                        Text("Date")
//                            .font(.headline)
//                        
//                        DatePicker("", selection: $selectedDate, displayedComponents: .date)
//                            .labelsHidden()
//                    }
//                    .padding()
//                    
//                    Divider()
//                    
//                    VStack(alignment: .leading) {
//                        Text("Location")
//                            .font(.headline)
//                        
//                        TextField("Enter location", text: $location)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                            .padding()
//                    }
//                    .padding()
//                }
//            }
//            
//            Spacer()
//            
//            HStack {
//                Button("Apply") {
//                    // Apply filters
//                    isFilterScreenPresented.toggle()
//                }
//                .padding()
//                .foregroundColor(.white)
//                .background(Color.blue)
//                .cornerRadius(8)
//                
//                Button("Reset") {
//                    // Reset filters
//                    selectedCategories = []
//                    lowerPrice = 0
//                    upperPrice = 100
//                    selectedDate = Date()
//                    location = ""
//                }
//                .padding()
//                .foregroundColor(.white)
//                .background(Color.red)
//                .cornerRadius(8)
//            }
//            .padding()
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color(.systemBackground))
//        .navigationBarTitle("", displayMode: .inline)
//        .navigationBarItems(trailing: Button("Close") {
//            isFilterScreenPresented.toggle()
//        })
//    }
//}
//
//
//struct CategoryButton: View {
//    let category: String
//    let isSelected: Bool
//    let action: () -> Void
//    
//    var body: some View {
//        Button(action: action) {
//            Text(category)
//                .font(.headline)
//                .foregroundColor(isSelected ? .white : .blue)
//                .padding(.vertical, 8)
//                .padding(.horizontal, 16)
//                .background(isSelected ? Color.blue : Color.white)
//                .cornerRadius(10)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(Color.blue, lineWidth: isSelected ? 0 : 1)
//                )
//        }
//    }
//}
//
//struct VendorList: View {
//    @State private var searchText: String = ""
//    @State private var isFilterScreenPresented = false
//    @State private var selectedCategories: Set<String> = []
//    @State private var lowerPrice = 0.0
//    @State private var upperPrice = 100.0
//    
//    var vendors: [Vendor] = [
//        Vendor(id: UUID().uuidString, imageName: "vendor1", title: "Vendor 1", category: "Bakery", description: "Description for Vendor 1", price: 12.99, hyperlinkText: "Details"),
//        Vendor(id: UUID().uuidString, imageName: "Vendor2", title: "Vendor 2", category: "Decor", description: "Description for Vendor 2", price: 19.99, hyperlinkText: "Details"),
//        Vendor(id: UUID().uuidString, imageName: "Vendor3", title: "Vendor 3", category: "Music", description: "Description for Vendor 3", price: 12.99, hyperlinkText: "Details"),
//        Vendor(id: UUID().uuidString, imageName: "Vendor3", title: "Vendor 4", category: "Food", description: "Description for Vendor 4", price: 12.99, hyperlinkText: "Details"),
//    ]
//    
//    var filteredVendors: [Vendor] {
//        var filteredVendors = vendors
//        
//        if !searchText.isEmpty {
//            filteredVendors = filteredVendors.filter { vendor in
//                return vendor.title.localizedCaseInsensitiveContains(searchText)
//            }
//        }
//        
//        if !selectedCategories.isEmpty {
//            filteredVendors = filteredVendors.filter { vendor in
//                return selectedCategories.contains(vendor.category)
//            }
//        }
//        
//        filteredVendors = filteredVendors.filter { vendor in
//            return vendor.price >= lowerPrice && vendor.price <= upperPrice
//        }
//        
//        return filteredVendors
//    }
//    
//    @State private var vendors: [VendorDetails] = [] // Array to store vendor details
//        private let firestoreManager = FirestoreManager.shared
//
//        var body: some View {
//            NavigationView {
//                List(vendors) { vendor in
//                    NavigationLink(destination: VendorDetailView(vendorID: vendor.id)) {
//                        // Display vendor name, price, etc. from vendor details
//                        Text(vendor.shopName)
//                        Text(vendor.price)
//                        // Add other details as needed
//                    }
//                }
//                .onAppear {
//                    fetchVendors()
//                }
//            }
//        }
//
//        private func fetchVendors() {
//            firestoreManager.fetchVendorDetails { details in
//                self.vendors = details
//            }
//        }
//    }
//    private var filterButton: some View {
//        Button(action: {
//            // Toggle isFilterScreenPresented to true to open the filter screen
//            isFilterScreenPresented.toggle()
//        }) {
//            Image(systemName: "slider.horizontal.3")
//                .foregroundColor(.blue)
//        }
//    }
//    
//    private func SearchFilterHeader() -> some View {
//        HStack {
//            Image(systemName: "magnifyingglass")
//                .foregroundColor(.purple)
//            TextField("Search", text: $searchText)
//                .padding(.vertical, 8)
//        }
//        .padding(.horizontal)
//        .background(Color(.white))
//        .cornerRadius(10)
//        .padding()
//        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.purple, lineWidth: 2))
//    }
//}
//
//struct VendorListCustomBox1: View {
//    @State var vendor: Vendor // Use @State for local modification
//        var body: some View {
//            NavigationLink(destination: VendorDetailView(vendor: $vendor)) {
//            HStack(spacing: 12) {
//                Image(vendor.imageName)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 80, height: 80)
//                    .cornerRadius(10)
//                
//                VStack(alignment: .leading, spacing: 4) {
//                    Text(vendor.title)
//                        .font(.headline)
//                        .foregroundColor(.primary)
//                    Text("₹\(String(format: "%.2f", vendor.price))")
//                        .font(.subheadline)
//                        .fontWeight(.bold)
//                        .foregroundColor(.blue)
//                    Text(vendor.hyperlinkText)
//                        .font(.subheadline)
//                        .foregroundColor(.blue)
//                        .underline()
//                }
//                
//                if vendor.isBooked {
//                    Text("Booked") // Display "Booked" label if vendor is booked
//                        .foregroundColor(.green)
//                        .fontWeight(.bold)
//                }
//            }
//            .padding(.vertical, 8)
//        }
//    }
//}
//
//struct VendorDetailView: View {
//    var vendorID: String
//    @State private var vendorDetails: VendorDetails?
//    private let firestoreManager = FirestoreManager.shared
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 16) {
//                // Logo image
//                if let logoImageData = vendorDetails?.logoImageData,
//                   let uiImage = UIImage(data: logoImageData) {
//                    Image(uiImage: uiImage)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(maxWidth: .infinity)
//                }
//                
//                // Shop name and book now button
//                HStack {
//                    Text(vendorDetails?.shopName ?? "Loading...")
//                        .font(.title)
//                        .foregroundColor(Color.black) // Light golden text color
//                    Spacer()
//                    Button("Book Now") {
//                        // Handle booking action
//                    }
//                    .padding()
//                    .foregroundColor(.white) // Light golden text color
//                    .background(Color.blue)
//                    .cornerRadius(8)
//                }
//                .padding(.horizontal)
//                
//                // Price
//                Text("Price: \(vendorDetails?.price ?? "Loading...")")
//                    .font(.title)
//                    .foregroundColor(Color.black) // Light golden text color
//                    .padding(.horizontal)
//                
//                // Address and working hours
//                VStack(alignment: .leading, spacing: 8) {
//                    Text("Address: \(vendorDetails?.address ?? "Loading...")")
//                        .foregroundColor(.black) // White text color
//                    Text("Working Hours: \(vendorDetails?.hours ?? "Loading...")")
//                        .foregroundColor(.black) // White text color
//                }
//                .padding(.horizontal)
//                
//                // Menu images
//                // Add code to display menu images using vendorDetails.menuImageData
//            }
//            .onAppear {
//                fetchVendorDetails()
//            }
//        }
//        .navigationBarTitle("Vendor Shop", displayMode: .inline)
//    }
//    
//    private func fetchVendorDetails() {
//        firestoreManager.fetchVendorDetails(forVendorID: vendorID) { details in
//            if let details = details {
//                self.vendorDetails = details
//            } else {
//                // Handle error or display message if details are not available
//            }
//        }
//    }
//}
//
//
//
//struct VendorList_preview: PreviewProvider {
//    static var previews: some View {
//        VendorList()
//    }
//}
