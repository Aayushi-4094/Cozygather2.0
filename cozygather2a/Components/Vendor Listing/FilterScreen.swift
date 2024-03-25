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
                    //.background(Color(red: 67/225, green: 13/225, blue: 75/225))
                
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
                                .foregroundColor(Color(red:67/255, green:13/255, blue:75/255))
                            Text("\(Int(lowerPrice)) - \(Int(upperPrice))")
                                .foregroundColor(Color(red: 198/225, green: 174/255, blue: 128/255))
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
                    .background(Color(red: 247/225, green: 239/255, blue: 247/255))
                }
                
                Spacer()
                
                HStack {
                    Button("Apply") {
                        // Apply filters
                        isFilterScreenPresented.toggle()
                    }
                    .padding()
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 198/225, green: 174/255, blue: 128/255))
                    .background(Color(red: 67/225, green: 13/225, blue: 75/225))
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
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 198/225, green: 174/255, blue: 128/255))
                    .background(Color(red: 67/225, green: 13/225, blue: 75/225))
                    .cornerRadius(8)
                }
                .background(Color(red: 247/225, green: 239/255, blue: 247/255))
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 247/225, green: 239/255, blue: 247/255))
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(trailing: Button("Close") {
                isFilterScreenPresented.toggle()
            })
        }
        //.background(Color(red: 67/225, green: 13/225, blue: 75/225))
        //.navigationTitle("Filter")
        .foregroundColor(Color(red: 198/225, green: 174/255, blue: 128/255))
        .font(.subheadline)
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
                .foregroundColor(isSelected ? Color(red: 198/225, green: 174/255, blue: 128/255) : Color(red: 67/225, green: 13/225, blue: 75/225))
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(isSelected ? Color(red: 67/225, green: 13/225, blue: 75/225) : Color(red: 247/225, green: 239/255, blue: 247/255))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(red: 67/225, green: 13/225, blue: 75/225), lineWidth: isSelected ? 0 : 1)
                )
        }
    }
}
