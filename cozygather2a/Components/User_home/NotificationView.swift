//import SwiftUI
//
//struct NotificationView: View {
//    var body: some View {
//        VStack {
//            VStack{
//                HStack {
//                                        Spacer()
//                    
//                    Label("Notification", systemImage: "")
//                        .font(Font.custom("AirbnbCereal_W_Md", size: 24))
//                        .foregroundColor(Color(red: 0.07, green: 0.05, blue: 0.15))
//                    
//                    
//                    Spacer()
//                    
//                    Button(action: {
//                        // Add action for the bell button
//                    }) {
//                        Image(systemName: "bell")
//                            .font(.title)
//                            .foregroundColor(.blue)
//                        
//                    }
//                }
//                .padding()
//                .background(Color.white)
//                Divider()
//                    .background(Color.black)
//                    .position(CGPoint(x: 200, y: 0))
//            }
//            
//            VStack{
//                
//                CustomNotificationBox(imageName: "noti1", date: "January 25, 2024", description: "Hi.",time: "just now")
//                    .padding()
//                    .position(CGPoint(x: 210.0, y: -600.0))
//                    .frame(width: 430, height: 10)
//                
//                
//                CustomNotificationBox(imageName: "noti2", date: "February 2, 2024", description: "Hello.",time: "JustNow")
//                    .padding()
//                    .position(CGPoint(x: 210.0, y: -500.0))
//                    .frame(width: 430, height: 10)
//                
//            }
//        }
//         
//    }
//}
//
//
//import SwiftUI
//
//struct CustomNotificationBox: View {
//    var imageName: String
//    var date: String
//    var description: String
//    var time:String
//    
//    var body: some View {
//        HStack {
//            
//            Image(imageName)
//                .resizable()
//                .frame(width: 70, height: 70)
//                .aspectRatio(contentMode: .fill)
//                .clipShape(Circle())
//                .overlay(Circle().stroke(Color.white, lineWidth: 4))
//                .shadow(radius: 10)
//                .position(CGPoint(x: 60.0, y: 10.0))
//            
//            VStack(alignment: .leading) {
//                Text(date)
//                    .font(.headline)
//                    .foregroundColor(.black)
//                
//                Text(description)
//                    .foregroundColor(.gray)
//                
//                Spacer()
//            }
//            .position(CGPoint(x: 20.0, y: 10.0))
//            Spacer()
//                Text(time)
//                    .font(.headline)
//                    .foregroundColor(.black)
//                    .position(CGPoint(x: 70.0, y: 10.0))
//                
//            }
//
//        }
//    }
//    
//    struct NotificationView_Preview: PreviewProvider {
//        static var previews: some View {
//            NotificationView()
//        }
//    }
