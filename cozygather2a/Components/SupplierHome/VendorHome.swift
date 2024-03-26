import SwiftUI

extension UIColor {
    static let customNavigationBarColor = UIColor(red: 67/255, green: 13/255, blue: 75/255, alpha: 1.0)
}


struct OrderData: Identifiable, Hashable {
    let id = UUID()
    let name: String // Replace with appropriate order details (e.g., product name, customer name, total amount)
    let status: String // "Completed" or "Uncompleted"
    let imageName: String // Optional: Image name for the order

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: OrderData, rhs: OrderData) -> Bool {
        return lhs.id == rhs.id
    }
}

struct OrderCard: View {
    @State private var isDetailViewPresented = false
    var order: OrderData

    var randomBackgroundColor: Color {
        let colors: [Color] = [Color.white]
        return colors.randomElement() ?? .gray
    }

    var body: some View {
        ZStack {
            randomBackgroundColor
                //.cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(red: 198/225, green: 174/255, blue: 128/255), lineWidth: 1)
                )
            HStack {
                VStack {
                    Image(order.imageName) // Replace with appropriate image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width - 250, height: 130)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                    Text(order.name)
                        .foregroundColor(.black)
                        .font(.system(size: 10))
                        .padding(.bottom, 2)
                        .padding(.top, 1)

                    Text(order.status)
                        .foregroundColor(order.status == "Completed" ? .green : .red)
                        .font(.system(size: 12))
                        .fontWeight(.bold)
                        .padding(.bottom, 2)

                    Button(action: {
                        isDetailViewPresented.toggle()
                    }) {
                        Text("View Details")
                            .foregroundColor(.black)
                            .padding(.top, 0)
                            .padding(.bottom, 2)
                            .cornerRadius(8)
                            .font(.system(size: 12))
                    }
                    .sheet(isPresented: $isDetailViewPresented) {
                        // Replace with OrderDetailView implementation
                        ViewOrderDetails()
                        //Text("Order Detail View")
                    }
                }
                .padding(.horizontal, 30)
                .frame(width: 150, height: 100)
            }
            .padding(10)
        }
    }
}

struct VendorHome: View {
    @State private var isSeeAllPresented = false
    @State private var isMenuExpanded = false
    @State private var isNotificationViewPresented = false

    let completedOrdersData = [ // Replace with actual order data
        OrderData(name: "Order 1", status: "Completed", imageName: "order1"),
        OrderData(name: "Order 2", status: "Completed", imageName: "order2"),
        OrderData(name: "Order 3", status: "Completed", imageName: "order3")
    ]

    let uncompletedOrdersData = [ // Replace with actual order data
        OrderData(name: "Order 4", status: "Uncompleted", imageName: "order4"),
        OrderData(name: "Order 5", status: "Uncompleted", imageName: "order5"),
    ]

    var username: String // Username passed from sign-up process

    var body: some View {
        NavigationView {
            ZStack{
                VStack {
                    Text("Uncompleted Orders")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(uncompletedOrdersData) { order in
                                OrderCard(order: order)
                            }
                        }
                    }
                    //.padding(.bottom, 20)
                    Text("Completed Orders")
                        .font(.title2)
                    
                        .fontWeight(.bold)
                        .padding()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(completedOrdersData) { order in
                                OrderCard(order: order)
                            }
                        }
                    }
                    Spacer()
                    
                }
                
                .padding()
                .navigationTitle("Vendor Homepage")
                .navigationBarItems(leading: menuButton, trailing: notificationButton)
                .sheet(isPresented: $isNotificationViewPresented) {
                    // Replace with NotificationView implementation
                    Notification1()
                }
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        HStack {  // Wrap the content in HStack
                            Spacer()  // Add Spacer to push content to the right
                            VendorToolbar()
                        }
                    }
                }
            }
            .background(Color(red: 247/225, green: 239/255, blue: 247/255))
        }
    }
    private var menuButton: some View {
        Button(action: {
            withAnimation {
                isMenuExpanded.toggle()
            }
        }) {
            Image(systemName: "ellipsis.circle")
                .foregroundColor(.primary)
                .imageScale(.large)
        }
    }

    private var notificationButton: some View {
        Button(action: {
            isNotificationViewPresented.toggle()
        }) {
            Image(systemName: "bell")
                .foregroundColor(.primary)
                .imageScale(.large)
        }
    }
}

struct VendorHome_Previews: PreviewProvider {
    static var previews: some View {
        VendorHome(username: "YourUsernameHere")
    }
}
