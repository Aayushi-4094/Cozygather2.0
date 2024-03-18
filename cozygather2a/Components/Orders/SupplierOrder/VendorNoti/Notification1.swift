import SwiftUI

struct Notification1: View {
    @State private var isDetailPresented = false
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Spacer()
                    Label("Notification", systemImage: "")
                        .font(Font.custom("AirbnbCereal_W_Md", size: 24))
                        .foregroundColor(Color(red: 0.07, green: 0.05, blue: 0.15))
                    Spacer()
//                    Button(action: {
//                        // Add action for the bell button
//                    }) {
//                        Image(systemName: "bell")
//                            .font(.title)
//                            .foregroundColor(.blue)
//                    }
                }
                .padding()
                .background(Color.white)
                Divider()
                    .background(Color.black)
                    .position(CGPoint(x: 180, y: 0))
            }
            VStack{
                CustomNotificationBox1(imageName: "noti1", date: "January 25, 2024", description: "Hi.",time: "just now")
                    .padding()
                    .position(CGPoint(x: 210.0, y: -200.0))
                    .frame(width: 430, height: 10)
                    .onTapGesture {
                        isDetailPresented = true
                    }
                    .sheet(isPresented: $isDetailPresented) {
                        NotificationDetail()
                    }
                
                CustomNotificationBox1(imageName: "noti2", date: "February 2, 2024", description: "Hello.",time: "JustNow")
                    .padding()
                    .position(CGPoint(x: 210.0, y: -100.0))
                    .frame(width: 430, height: 10)
                
         
                  
                 
                    
                
            }
            VendorToolbar()
                .position(CGPoint(x: 200.0, y: 350.0))
        }
    }
}

struct CustomNotificationBox1: View {
    var imageName: String
    var date: String
    var description: String
    var time:String
    
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
            VStack(alignment: .leading) {
                Text(date)
                    .font(.headline)
                    .foregroundColor(.black)
                
                Text(description)
                    .foregroundColor(.gray)
                
                Spacer()
            }
            Spacer()
            Text(time)
                .font(.headline)
                .foregroundColor(.black)
        }
    }
}

struct Notifications1_Preview: PreviewProvider {
    static var previews: some View {
        Notification1()
    }
}
