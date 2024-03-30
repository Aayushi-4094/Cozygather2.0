//import SwiftUI
//
//struct InvitationCardsView: View {
//    let invitations: [InvitationData]
//    
//    var body: some View {
//        ScrollView(.horizontal) {
//            HStack(spacing: 20) {
//                ForEach(invitations) { invitation in
//                    InvitationCard(invitation: invitation)
//                }
//            }
//            .padding()
//        }
//    }
//}
//
//struct InvitationCard: View {
//    let invitation: InvitationData
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text(invitation.eventName)
//                .font(.title)
//            Text(invitation.eventLocation)
//                .font(.subheadline)
//            Text(invitation.eventDateTime)
//                .font(.subheadline)
//        }
//        .padding()
//        .foregroundColor(.white)
//        .background(Color.blue)
//        .cornerRadius(10)
//        .frame(width: 200, height: 150)
//    }
//}
//
//
//struct InvitationCard_Previews: PreviewProvider {
//    static var previews: some View {
//        InvitationCard(invitation: <#InvitationData#>, imageName: "image1", eventName: "Birthday Party", eventLocation: "123 Main St", eventDateTime: "January 1, 2023 7:00 PM")
//    }
//}
