import SwiftUI

struct ViewOrderDetails: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    NavigationBarView()
                    
//                 ActionButtonsView()
                    
                    UserCardView()
                    
                    SectionHeaderView(title: "Description")
                    
                    DescriptionTextView(text: "Enjoy your favorite dish and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase.")
                    
                    SectionHeaderView(title: "Specifications")
                    
                    SpecificationTextView(text: "Enjoy your favorite dish and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase.")
                    
                    SpecificationsView()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct NavigationBarView: View {
    var body: some View {
        HStack {
//            Button(action: {}) {
//                Image(systemName: "chevron.left")
//                    .foregroundColor(.black)
//            }
            Spacer()
            Text("Order Detail")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            Button(action: {}) {
                Image(systemName: "bell")
                    .foregroundColor(.black)
            }
        }
        .padding(.horizontal)
        Divider()
    }
}
//struct ActionButtonsView: View {
//    var body: some View {
//        HStack {
//            Button(action: {}) {
//                Text("Reject")
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.red)
//                    .cornerRadius(20)
//            }
//            Button(action: {}) {
//                Text("Accept")
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.green)
//                    .cornerRadius(20)
//            }
//        }
//        .frame(maxWidth: .infinity)
//        .padding(.horizontal)
//        Divider()
//    }
//}

struct SectionHeaderView: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
            .padding(.horizontal)
    }
}

struct DescriptionTextView: View {
    var text: String
    
    var body: some View {
        Text(text)
            .padding(.horizontal)
    }
}

struct SpecificationTextView: View {
    var text: String
    
    var body: some View {
        Text(text)
            .padding(.horizontal)
    }
}

struct SpecificationsView: View {
    var body: some View {
        VStack {
            Spacer()
            SpecificationView(iconName: "calendar", text: "12th January 2024")
            SpecificationView(iconName: "clock", text: "4:00 PM")
            SpecificationView(iconName: "mappin", text: "Tea Village")
        }
        .padding(.horizontal)
    }
}

struct SpecificationView: View {
    var iconName: String
    var text: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.gray)
            Text(text)
                .foregroundColor(.black)
        }
    }
}

struct UserCardView: View {
    var body: some View {
        HStack {
            ImagePlaceholderView()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text("Ashfak Sayem")
                    .font(.headline)
               
                    
            }
        }
        .padding()
    
        .padding(.horizontal)
    }
}

struct ImagePlaceholderView: View {
    var body: some View {
        Image("noti1")
            .resizable()
            .scaledToFill()
            .foregroundColor(.gray)
            .background(Color.gray.opacity(0.3))
    }
}
struct ViewOrderDetails_Previews: PreviewProvider {
    static var previews: some View {
        ViewOrderDetails()
    }
}

