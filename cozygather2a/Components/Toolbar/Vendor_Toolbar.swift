import SwiftUI

struct VendorToolbar: View {
    @State private var selectedTab: Tab1 = .homevendr
    @State private var isHomeUserViewActive = false
    @State private var isCreateEventViewActive = false
    @State private var isCreateVendorList = false
    @State private var isBudgetApp = false
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            Spacer()
            
            VStack {
                
                Image(systemName: selectedTab == .homevendr ? "house.fill" : "house")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(selectedTab == .homevendr ? Color.blue : Color.gray)
                Text("Home")
                    .font(.system(size: 10, weight: .regular, design: .default))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(selectedTab == .homevendr ? Color.blue : Color.gray)
            }
            .frame(width: 393 / 5, height: 83)
            .onTapGesture {
                selectedTab = .homevendr
                isHomeUserViewActive.toggle()
            }
            .fullScreenCover(isPresented: $isHomeUserViewActive) {
                // Use the appropriate view for homevendr
                VendorHomePage()
            }
            
            Spacer()
            Spacer()
            Spacer()
            
            VStack {
                Image(systemName: selectedTab == .order ? "list.bullet.fill" : "list.bullet")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(selectedTab == .order ? Color.blue : Color.gray)
                Text("Order")
                    .font(.system(size: 10, weight: .regular, design: .default))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(selectedTab == .order ? Color.blue : Color.gray)
            }
            .frame(width: 393 / 5, height: 83)
            .onTapGesture {
                selectedTab = .order
                isCreateEventViewActive.toggle()
            }
            .fullScreenCover(isPresented: $isCreateEventViewActive) {
                MainOrders()
            }
            Spacer()
            Spacer()
            Spacer()
        
            
            VStack {
                Image(systemName: selectedTab == .message ? "message" : "message.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(selectedTab == .message ? Color.blue : Color.gray)
                Text("Message")
                    .font(.system(size: 10, weight: .regular, design: .default))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(selectedTab == .message ? Color.blue : Color.gray)
            }
            .frame(width: 393 / 5, height: 83)
            .onTapGesture {
                selectedTab = .message
                isCreateVendorList.toggle()
            }
            .fullScreenCover(isPresented: $isCreateVendorList) {
                messagelist()
            }
            
            Spacer()
            
            VStack {
                Image(systemName: selectedTab == .profile ? "person.crop.circle" : "person.crop.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(selectedTab == .profile ? Color.blue : Color.gray)
                Text("Profile")
                    .font(.system(size: 10, weight: .regular, design: .default))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(selectedTab == .profile ? Color.blue : Color.gray)
            }
            .frame(width: 393 / 5, height: 83)
            .onTapGesture {
                selectedTab = .profile
                isBudgetApp.toggle()
            }
            .fullScreenCover(isPresented: $isBudgetApp) {
                SupplierProfile()
            }
            Spacer()
            Spacer()
            Spacer()
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .frame(width: 200, height: 100)
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
