import SwiftUI

struct NotificationDetail: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    NNavigationBarView()
                    
                    NActionButtonsView()
                    
                    NUserCardView()
                    
                    NSectionHeaderView(title: "Description")
                    
                    NDescriptionTextView(text: "Enjoy your favorite dish and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase.")
                    
                    NSectionHeaderView(title: "Specifications")
                    
                    NSpecificationTextView(text: "Enjoy your favorite dish and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase.")
                    
                    NSpecificationsView()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct NNavigationBarView: View {
    var body: some View {
        HStack {
//            Button(action: {}) {
//                Image(systemName: "chevron.left")
//                    .foregroundColor(.black)
//            }
            Spacer()
            Text("Notification Detail")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
//            Button(action: {}) {
//                Image(systemName: "bell")
//                    .foregroundColor(.black)
//            }
        }
        .padding(.horizontal)
        Divider()
    }
}



struct NActionButtonsView: View {
    var body: some View {
        HStack {
            Button(action: {}) {
                Text("Reject")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(20)
            }
            Button(action: {}) {
                Text("Accept")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(20)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        Divider()
    }
}

struct NSectionHeaderView: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
            .padding(.horizontal)
    }
}

struct NDescriptionTextView: View {
    var text: String
    
    var body: some View {
        Text(text)
            .padding(.horizontal)
    }
}

struct NSpecificationTextView: View {
    var text: String
    
    var body: some View {
        Text(text)
            .padding(.horizontal)
    }
}

struct NSpecificationsView: View {
    var body: some View {
        VStack {
            Spacer()
            NSpecificationView(iconName: "calendar", text: "12th January 2024")
            NSpecificationView(iconName: "clock", text: "4:00 PM")
            NSpecificationView(iconName: "mappin", text: "Mother's Village")
        }
        .padding(.horizontal)
    }
}

struct NSpecificationView: View {
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

struct NUserCardView: View {
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

struct NImagePlaceholderView: View {
    var body: some View {
        Image("noti1")
            .resizable()
            .scaledToFill()
            .foregroundColor(.gray)
            .background(Color.gray.opacity(0.3))
    }
}

struct NotificationDetail_Previews: PreviewProvider {
    static var previews: some View {
        NotificationDetail()
    }
}
