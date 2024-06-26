import SwiftUI

struct MainOrders: View {
    @State private var searchText: String = ""
    @State private var isFilterScreen1Presented = false
    @State private var isViewOrderDetailsActive = false

    var body: some View {
        NavigationView {
            ZStack {
                // Content
                VStack {
                    // Header
                        Spacer()
                        Text("Orders")
                            .font(.largeTitle)
                        Spacer()
                    // Search and Filter
                    HStack {
                        // Search TextField
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color(red:67/255, green: 13/255, blue:75/255))
                                .padding(.leading, 10)

                            TextField("Search", text: $searchText)
                                .padding()

                        }
                        .padding(.leading, 16)
                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color(red:67/255, green: 13/255, blue:75/255), lineWidth: 1))
                        .frame(width: 250)

                        // Spacer to push Filter button to the right
                        Spacer()

                        // Filter Button
                        Button(action: {
                            isFilterScreen1Presented.toggle()
                        }) {
                            HStack {
                                Image(systemName: "slider.horizontal.3")
                                    .foregroundColor(Color(red:198/255, green: 174/255, blue:128/255))
                                Text("Filter")
                                    .foregroundColor(Color(red:198/255, green: 174/255, blue:128/255))
                                    .font(.headline)
                            }
                            .frame(width: 100, height: 40)
                            .background(Color(red:67/255, green: 13/255, blue:75/255))
                            .cornerRadius(20)
                            .padding(.trailing, 16)
                        }
                        .sheet(isPresented: $isFilterScreen1Presented) {
                            FilterScreen1()
                        }
                    }
                    .padding()
                    .frame(height: 80)

                    // Order List
                    ScrollView {
                        VStack(spacing: 8) {
                            CustomCard1(imageName: "order1", date: "January 25, 2024", description: "Description 1", hyperlinkText: "View Details")
                                .onTapGesture {
                                    // Set the state variable to trigger the navigation
                                    isViewOrderDetailsActive = true
                                }
                            CustomCard1(imageName: "order1", date: "January 25, 2024", description: "Description 1", hyperlinkText: "View Details")
                                .onTapGesture {
                                    // Set the state variable to trigger the navigation
                                    isViewOrderDetailsActive = true
                                }
                            CustomCard1(imageName: "order1", date: "January 25, 2024", description: "Description 1", hyperlinkText: "View Details")
                                .onTapGesture {
                                    // Set the state variable to trigger the navigation
                                    isViewOrderDetailsActive = true
                                }
                        }
                        .padding(.horizontal, 16)
                    }
                    .background(Color(red: 247/225, green: 239/255, blue: 247/255)) // Set a background color to demonstrate separation
                }

                .toolbar {
                  ToolbarItem(placement: .bottomBar) {
                    HStack {  // Wrap the content in HStack
                      Spacer()  // Add Spacer to push content to the right
                      VendorToolbar()
                    }
                    .offset(y:20)
                  }
                }

                // Button to navigate to ViewOrderDetails
                if isViewOrderDetailsActive {
                    NavigationLink(
                        destination: ViewOrderDetails(), // You may pass necessary data here
                        isActive: $isViewOrderDetailsActive
                    ) {
                        EmptyView()
                    }
                    .hidden()
                }
            }
            .background(Color(red:248/255,green: 239/255, blue:247/255))
            //.navigationBarHidden(true)
        }
        .navigationTitle("Orders")
    }
}

struct CustomCard1: View {
    var imageName: String
    var date: String
    var description: String
    var hyperlinkText: String

    var body: some View {
        VStack {
            HStack {
                Image(imageName) // Use the custom image name
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)

                VStack(alignment: .leading, spacing: 4) {
                    Text(date)
                        .font(.headline)
                        .foregroundColor(Color(red:67/255, green: 13/255, blue:75/255))

                    Text(description)
                        .foregroundColor(.gray)
                        .font(.system(size: 15))
                }
                .padding()

                Spacer()
            }

            HStack {
                Spacer()
                Text(hyperlinkText)
                    .foregroundColor(Color(red:67/255, green: 13/255, blue:75/255))
                    .underline()
                    .font(.system(size: 12))
                    .position(CGPoint(x: 310.0, y: -30.0))
            }
        }
    }
}

struct MainOrders_Previews: PreviewProvider {
    static var previews: some View {
        MainOrders()
    }
}
