import SwiftUI

struct Notification1: View {
    @State private var isDetailPresented = false
    
    var notifications: [NotificationItem] = [
        NotificationItem(imageName: "noti1", date: "January 25, 2024", description: "Hi.", time: "Just now"),
        NotificationItem(imageName: "noti2", date: "February 2, 2024", description: "Hello.", time: "Just Now")
    ]
    
    var body: some View {
        VStack {
            ZStack{
                VStack(spacing: 0) {
                    Text("Notifications")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemBackground))
                        .foregroundColor(Color(.label))
                    
                    Divider()
                    
                    List {
                        ForEach(notifications) { notification in
                            NotificationRow(notification: notification, isDetailPresented: $isDetailPresented)
                        }
                        .listRowInsets(EdgeInsets())
                    }
                    .listStyle(PlainListStyle())
                }
               // .background(Color(.systemBackground))
            }
           // .background(Color(red:248/255, green/239/255, blue:247/255))
        }
        .navigationBarHidden(true)
       // .background(Color(.systemBackground).edgesIgnoringSafeArea(.all))
    }
}

struct NotificationRow: View {
    var notification: NotificationItem
    @Binding var isDetailPresented: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 16) {
                Image(notification.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .cornerRadius(8)
                
                VStack(alignment: .leading) {
                    Text(notification.date)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(Color(.label))
                    
                    Text(notification.description)
                        .font(.subheadline)
                        .foregroundColor(Color(.secondaryLabel))
                        .lineLimit(2)
                    
                    Spacer()
                }
                
                Spacer()
                
                Text(notification.time)
                    .font(.subheadline)
                    .foregroundColor(Color(.label))
            }
            .padding(8)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: Color(.black).opacity(0.1), radius: 4, x: 0, y: 2)
            .onTapGesture {
                isDetailPresented = true
            }
            .sheet(isPresented: $isDetailPresented) {
                NotificationDetail()
            }
        }
        .padding(.horizontal)
    }
}

struct NotificationItem: Identifiable {
    var id = UUID()
    var imageName: String
    var date: String
    var description: String
    var time: String
}

struct Notifications1_Preview: PreviewProvider {
    static var previews: some View {
        Notification1()
    }
}
