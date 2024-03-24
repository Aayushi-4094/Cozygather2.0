import SwiftUI

struct VendorToolbar: View {
    @State private var selectedTab: Tab1 = .homevendr
    @State private var isHomeUserViewActive = false
    @State private var isOrderViewActive = false
    @State private var isMessageViewActive = false
    @State private var isProfileViewActive = false
    
    var body: some View {
        HStack{
            
                VStack {
                    Image(systemName: selectedTab == .homevendr ? "house.fill" : "house")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color(red: 198/225, green: 174/255, blue: 128/255))
                    Text("Home")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(Color(red: 198/225, green: 174/255, blue: 128/255))
                }
                .frame(width: 393 / 4, height: 110)
                .onTapGesture {
                    selectedTab = .homevendr
                    isHomeUserViewActive.toggle()
                }
                .fullScreenCover(isPresented: $isHomeUserViewActive) {
                    // Use the appropriate view for homevendr
                    VendorHome(username: "YourUsernameHere")
                }
                VStack {
                    Image(systemName: selectedTab == .order ? "list.bullet.fill" : "list.bullet")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color(red: 198/225, green: 174/255, blue: 128/255))
                    Text("Order")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(Color(red: 198/225, green: 174/255, blue: 128/255))
                }
                .frame(width: 393 / 4, height: 83)
                .onTapGesture {
                    selectedTab = .order
                    isOrderViewActive.toggle()
                }
                .fullScreenCover(isPresented: $isOrderViewActive) {
                    // Use the appropriate view for homevendr
                    MainOrders()
                }
            VStack {
                Image(systemName: selectedTab == .message ? "message.fill" : "message")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(Color(red: 198/225, green: 174/255, blue: 128/255))
                Text("Order")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(Color(red: 198/225, green: 174/255, blue: 128/255))
            }
            .frame(width: 393 / 4, height: 83)
            .onTapGesture {
                selectedTab = .message
                isMessageViewActive.toggle()
            }
            .fullScreenCover(isPresented: $isMessageViewActive) {
                // Use the appropriate view for homevendr
                messagelist()
            }
            VStack {
                Image(systemName: selectedTab == .message ? "person.crop.circle" : "person.crop.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(Color(red: 198/225, green: 174/255, blue: 128/255))
                Text("Profile")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(Color(red: 198/225, green: 174/255, blue: 128/255))
            }
            .frame(width: 393 / 4, height: 83)
            .onTapGesture {
                selectedTab = .message
                isProfileViewActive.toggle()
            }
            .fullScreenCover(isPresented: $isProfileViewActive) {
                // Use the appropriate view for homevendr
                SupplierProfile()
            }
        }
        .background(Color(red: 67/225, green: 13/225, blue: 75/225))
        .cornerRadius(10)
        .shadow(radius: 5)
        }
        
    }

enum Tab1 {
    case homevendr, order, message, profile
}

struct VendorToolbar_Previews: PreviewProvider {
    static var previews: some View {
        VendorToolbar()
    }
}
