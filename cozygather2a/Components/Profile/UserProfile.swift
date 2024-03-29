import SwiftUI

struct UserProfile: View {
    @State private var emailText = ""
    @State private var PhoneNumber = ""
    @State private var Location = ""
    @State private var Negotiation = ""
    @State private var isToggleOn = false
    @State private var selectedService = "Services"
    @State private var isPopoverVisible = false

    var body: some View {
        VStack(spacing: 20) {
            HStack {
//                Button(action: {
//                    // Add action for the back button
//                }) {
//                    Image(systemName: "chevron.left")
//                        .font(.title)
//                        .foregroundColor(.blue)
//                }
                Spacer()

                Text("Profile")
                    .font(Font.custom("AirbnbCereal_W_Md", size: 24))
                    .foregroundColor(Color(.label))

                Spacer()
            }
            .padding([.horizontal, .top])
            .background(Color(.systemBackground))
            .offset(y: 20) // Adjust the offset as needed

            VStack(spacing: 20) {
                Image("noti2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                    .padding(.bottom, 10)

                Text("User Name") // Placeholder label
                    .font(.title) // Increased font size
                    .foregroundColor(Color(red: 0.07, green: 0.05, blue: 0.15))
                    .padding(.bottom, 10) // Added spacing

                Divider() // Horizontal line after the username

                VStack(spacing: 20) {
                    SectionRow(imageName: "calendar", text: "Calendar")
                    Spacer() // Added spacer
                    SectionRow(imageName: "message", text: "Message Center")
                    Spacer() // Added spacer
                    SectionRow(imageName: "person", text: "Profile")
                    Spacer() // Added spacer
                    SectionRow(imageName: "dollarsign", text: "Payments")
                    Spacer() // Added spacer
                    SectionRow(imageName: "alarm", text: "Reminders")
                    Spacer() // Added spacer
                    SectionRow(imageName: "dollarsign", text: "Privacy Policy")
                }
                .padding([.horizontal, .bottom])

            }
            .padding()

            Spacer() // Leave space at the bottom for the navigation control bar
            Toolbar()
            
        }
        .padding(.horizontal)
     .background(Color(.systemBackground))
        .navigationBarHidden(true) // Hide the navigation bar
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}

struct SectionRow: View {
    let imageName: String
    let text: String

    var body: some View {
        HStack {
            Image(systemName: imageName)
                .foregroundColor(Color(.label))
                .padding(.leading, 0)

            Text(text)
                .foregroundColor(Color(.label))
                .font(.headline) // Added font size
                .padding(.trailing, 0)

            Spacer()// Added spacer

            Image(systemName: "chevron.right")
                .foregroundColor(Color(.secondaryLabel))
                .padding(.trailing, 0)
        }
    }
}
