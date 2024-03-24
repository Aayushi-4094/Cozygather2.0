import SwiftUI

struct FilterScreen: View {
    @Binding var selectedCategories: Set<String>
    @Binding var lowerPrice: Double
    @Binding var upperPrice: Double
    @Binding var isFilterScreenPresented: Bool
    
    @State private var selectedDate = Date()
    @State private var location = ""
    
    var categories = ["Bakery", "Catering", "Music", "Decor"]
    
    var body: some View {
        NavigationView {
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
                            Text("\(Int(lowerPrice)) - \(Int(upperPrice))")
                                .foregroundColor(.gray)
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
