//import SwiftUI
//import MessageUI
//
//struct messagelist: View {
//    @State private var numberOfMessages = 4 // Initial number of messages
//
//    var body: some View {
//        NavigationView {
//            ZStack {
//                VStack(spacing: 20) {
//                    HStack {
//                        Text("Messages")
//                            .font(.largeTitle)
//                            .foregroundColor(Color(red: 67/255, green: 13/255, blue: 75/255))
//                    }
//                    .padding(.top, 20) // Align top bar to the top
//                    Divider()
//                    
//                    ForEach(0..<numberOfMessages, id: \.self) { index in
//                        NavigationLink(destination: MessagingView()) {
//                            MessageBoxSampleView(imageName: "noti\(index + 1)", name: "Notification \(index + 1)", date: "Jan \(Int.random(in: 1...31))", description: "Sample description", timeButtonText: "\(Int.random(in: 1...60))")
//                        }
//                    }
//                    .padding(.top, 20) // Align notifications to the top
//                    
//                    Button(action: {
//                        numberOfMessages += 1 // Increase the number of messages by 1
//                    }) {
//                        Text("Load More Messages") // Updated button label
//                            .foregroundColor(.blue)
//                    }
//                    .padding(.bottom, 20)
//                    .padding(.top, 10)
//                }
//                .padding(.horizontal)
//                .navigationBarHidden(true)
//                
//                // Add VendorToolbar at the end of the page
//                .toolbar {
//                    ToolbarItem(placement: .bottomBar) {
//                        HStack {  // Wrap the content in HStack
//                            Spacer()  // Add Spacer to push content to the right
//                            VendorToolbar()
//                        }
//                        .offset(y:20)
//                    }
//                }
//            }
//            .background(Color(red:248/255, green: 239/255, blue:247/255))
//        }
//    }
//}
//
//struct MessageBoxSampleView: View {
//    let imageName: String
//    let name: String
//    let date: String
//    let description: String
//    let timeButtonText: String
//
//    var body: some View {
//        HStack(alignment:.top) {
//            Image(imageName)
//                .resizable()
//                .aspectRatio(contentMode:.fit)
//                .frame(width :70, height :70)
//                .cornerRadius(35)
//
//            VStack(alignment:.leading, spacing: 5) {
//                Text(name)
//                    .font(.headline)
//                    .foregroundColor(Color(red:67/255, green: 13/255, blue: 75/255))
//
//                Text(description)
//                    .foregroundColor(Color(red:198/255, green: 174/255, blue: 128/255))
//            }
//
//            Spacer()
//
//            VStack(alignment:.trailing, spacing: 5) {
//                Text(date)
//                    .foregroundColor(Color(red:198/255, green: 174/255, blue: 128/255))
//                    .font(.subheadline)
//                Text("\(timeButtonText) min ago")
//                    .foregroundColor(Color(red:198/255, green: 174/255, blue: 128/255))
//                    .font(.subheadline)
//                    .padding(5)
//                    .background(Color(red:67/255, green:13/255, blue:75/255))
//                    .cornerRadius(5)
//            }
//        }
//        .padding()
//    }
//}
//
//struct messagelist_Previews : PreviewProvider {
//    static var previews : some View {
//        messagelist()
//    }
//}
