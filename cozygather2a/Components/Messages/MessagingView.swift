//import SwiftUI
//
//struct Message: Identifiable {
//    let id = UUID()
//    let content: String
//    let isSentByUser: Bool
//}
//
//struct MessagingView: View {
//    @State private var messages: [Message] = [
//        Message(content: "Hello!", isSentByUser: false),
//        Message(content: "Can you send me the details of your order", isSentByUser: true),
//        Message(content: "Here are the details of my order", isSentByUser: false),
//    ]
//    
//    @State private var newMessage = ""
//    
//    var body: some View {
//        VStack {
//            HStack{
//                
//                Image("noti1")
//                    .cornerRadius(50)
//                Text("Sam")
//                    .font(.largeTitle)
//                Spacer()
//                
//                
//            }
//            .padding()
//        
//            List(messages) { message in
//                MessageView(message: message)
//            }
//            
//            HStack {
//                Image(systemName: "location.fill")
//                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
//                Image(systemName: "camera.fill")
//                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
//                Image(systemName: "photo.fill")
//                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
//                Image(systemName: "mic.fill")
//                    .foregroundColor(.blue)
//                TextField("Type a message", text: $newMessage)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding(8)
//                    .cornerRadius(20)
//                
//                Button(action: sendMessage) {
//                    Text("Send")
//                        .padding(8)
//                        .foregroundColor(.white)
//                        .background(Color.blue)
//                        .cornerRadius(8)
//                }
//            }
//            .padding()
//        }
//    }
//    
//    func sendMessage() {
//        guard !newMessage.isEmpty else { return }
//        
//        let message = Message(content: newMessage, isSentByUser: true)
//        messages.append(message)
//        newMessage = ""
//    }
//}
//
//struct MessageView: View {
//    let message: Message
//    
//    var body: some View {
//        HStack {
//            if message.isSentByUser {
//                Spacer()
//            }
//            
//            Text(message.content)
//                .padding(12)
//                .background(message.isSentByUser ? Color.blue : Color.gray)
//                .foregroundColor(.white)
//                .cornerRadius(12)
//            
//            if !message.isSentByUser {
//                Spacer()
//            }
//        }
//        .animation(.easeInOut)
//    }
//}
//struct MessagingView_preview: PreviewProvider {
//    static var previews: some View {
//        MessagingView()
//    }
//}
//
//
