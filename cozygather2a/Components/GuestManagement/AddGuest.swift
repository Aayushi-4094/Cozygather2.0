//import SwiftUI
//
//struct AddGuest: View {
//
//  var body: some View {
//    NavigationView {
//      VStack {
//        Spacer()
//        HStack {
//            Spacer()
//            Text("Add Guests")
//                .font(.largeTitle)
//                .foregroundColor(Color(red: 82/225, green: 72/255, blue: 159/255))
//
//          Spacer()
//          NavigationLink(destination: GuestMain()) {
//            Text("Done")
//              .font(.caption)
//              .foregroundColor(.white)
//              .padding(.vertical, 5)
//              .padding(.horizontal, 10)
//            
//              .background(Color(red: 82/225, green: 72/255, blue: 159/255))
//              .cornerRadius(5)
//          }
//          .isDetailLink(false)
//          .frame(width: 80, height: 30) // Reduce the size of the button
//          Spacer()
//        }
//        Spacer()
//        
//        List {
//          Section(header: Text("Guests")
//            .foregroundColor(Color(red: 82/225, green: 72/255, blue: 159/255))) {
//            CustomAddGuestBox(imageName: "noti1", name: "Aarushi", phone: "+91 XXXXXXXXXX", email: "aa1946")
//              .listRowInsets(.init(top: 0, leading: 0, bottom: 10, trailing: 0)) // Adjust list row inset
//            CustomAddGuestBox(imageName: "noti1", name: "Aarushi", phone: "+91 XXXXXXXXXX", email: "aa1946")
//              .listRowInsets(.init(top: 0, leading: 0, bottom: 10, trailing: 0))
//          }
//        }
//        .background(Color(red: 250/225, green: 244/255, blue: 250/255))
//
//        .padding()
//        .listStyle(PlainListStyle()) // Remove separators for a cleaner list look
//      }
//      
//    }
//  }
//}
//
//struct CustomAddGuestBox: View {
//  var imageName: String
//  var name: String
//  var phone: String
//  var email: String
//  @State private var isDoneGuestAddAvailable = false
//
//  var body: some View {
//    HStack {
//      Image(imageName)
//        .resizable()
//        .frame(width: 70, height: 70)
//        .aspectRatio(contentMode: .fill)
//        .clipShape(Circle())
//        .overlay(Circle().stroke(Color.white, lineWidth: 4))
//        .shadow(radius: 10)
//
//      VStack(alignment: .leading) {
//        Text(name)
//          .font(.headline)
//          .foregroundColor(.black)
//
//        Text(phone)
//          .font(.subheadline)
//          .foregroundColor(.gray)
//
//        Text(email)
//          .font(.subheadline)
//          .foregroundColor(.gray)
//      }
//      .padding()
//
//      Spacer()
//
//      Button(action: {
//        // Add action for the done button
//      }) {
//        Image(systemName: "plus")
//          .resizable()
//          .frame(width: 30, height: 30)
//          .foregroundColor(Color(red: 82/225, green: 72/255, blue: 159/255))
//      }
//      .padding()
//    }
//  }
//}
//
//struct Guest: Identifiable {
//  let id = UUID()
//  let name: String
//  let phone: String
//  let email: String
//  let imageName: String
//}
//
//struct AddGuestView_Preview: PreviewProvider {
//  static var previews: some View {
//    AddGuest()
//  }
//}
