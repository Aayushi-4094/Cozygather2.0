import SwiftUI

struct Toolbar: View {
    @State private var selectedTab: Tab = .home
    @State private var isHomeUserViewActive = false
    @State private var isCreateEventViewActive = false
    @State private var isCreateVendorList = false
    @State private var isBudgetApp = false
    @State private var isGuestManagement = false


    
    var body: some View {
        HStack(spacing: 0) {
            
            VStack {
                            Image(systemName: selectedTab == .home ? "house.fill" : "house")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(Color(red: 198/225, green: 174/255, blue: 128/255))
                            Text("Home")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .foregroundColor(Color(red: 198/225, green: 174/255, blue: 128/255))
                        }
                        .frame(width: 393 / 4, height: 83)
                        .onTapGesture {
                            selectedTab = .home
                            isHomeUserViewActive.toggle()
                        }
                        .fullScreenCover(isPresented: $isHomeUserViewActive) {
                            UserHomeView(username: "YourUsernameHere")
                        }
            
    VStack {
                Image(systemName: selectedTab == .vendorListing ? "list.bullet.fill" : "list.bullet")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(Color(red: 198/225, green: 174/255, blue: 128/255))
                Text("Vendor Listing")
                    .font(.system(size: 10, weight: .regular, design: .default))
                    .frame(maxWidth: .infinity, alignment: .center)
                    //.foregroundColor(Color(red: 82/225, green: 72/255, blue: 159/255))
                    .foregroundColor(Color(red: 198/225, green: 174/255, blue: 128/255))
    }
            .frame(width: 393 / 4, height: 83)
            .onTapGesture {
                selectedTab = .events
                isCreateVendorList.toggle()
            }
            .fullScreenCover(isPresented: $isCreateVendorList) {
                VendorList()
            }
            
            VStack {
                Image(systemName: selectedTab == .guests ? "person.2.fill" : "person.2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(Color(red: 198/225, green: 174/255, blue: 128/255))
                Text("Guests")
                    .font(.system(size: 10, weight: .regular, design: .default))
                    .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(Color(red: 198/225, green: 174/255, blue: 128/255))            }
            .frame(width: 393 / 4, height: 83)
            
                .onTapGesture {
                    selectedTab = .budget
                    isGuestManagement.toggle()
                }
                .fullScreenCover(isPresented: $isGuestManagement) {
                    GuestMain()
                }            
            VStack {
                Image(systemName: selectedTab == .budget ? "dollarsign.circle.fill" : "dollarsign.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(Color(red: 198/225, green: 174/255, blue: 128/255))
                Text("Budget")
                    .font(.system(size: 10, weight: .regular, design: .default))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(Color(red: 198/225, green: 174/255, blue: 128/255))
            }
            .frame(width: 393 / 4, height: 83)
            .onTapGesture {
                selectedTab = .budget
                isBudgetApp.toggle()
            }
            .fullScreenCover(isPresented: $isBudgetApp) {
                BudgetApp()
            }
        }
        .background(Color(red: 67/225, green: 13/225, blue: 75/225))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

enum Tab {
    case home, events, vendorListing, guests, budget
}

struct Toolbar_Previews: PreviewProvider {
    static var previews: some View {
        Toolbar()
    }
}
