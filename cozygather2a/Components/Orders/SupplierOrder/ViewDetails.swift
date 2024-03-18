import SwiftUI

struct ViewDetails: View {
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button(action: {
                    // Add action for the back button
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(.blue)
                }
                Spacer()

                Label("Orders", systemImage: "")
                    .font(Font.custom("AirbnbCereal_W_Md", size: 24))
                    .foregroundColor(Color(red: 0.07, green: 0.05, blue: 0.15))
                    .padding(.bottom, 20)

                Spacer()

                Button(action: {
                    // Add action for the bell button
                }) {
                    Image(systemName: "bell")
                        .font(.title)
                        .foregroundColor(.blue)
                }
            }
            .padding()
            .background(Color.white)

            HStack {
                Button(action: {
                    // Add action for reject button
                }) {
                    Text("Reject")
                        .foregroundColor(.black )
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        
                }

                Button(action: {
                    // Add action for accept button
                }) {
                    Text("Accept")
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }
            }

            Circle()
                .fill(Color.blue) // Change color as needed
                .frame(width: 80, height: 80)
                .overlay(
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .foregroundColor(.white)
                        .frame(width: 60, height: 60)

                )
                .padding()

            

            
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Description")
                    .font(.title)
                    .bold()

                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
            }
            .padding()

            VStack(alignment: .leading, spacing: 10) {
                Text("Specifications")
                    .font(.title)
                    .bold()

                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
            }
            .padding()

            VStack(alignment: .leading, spacing: 10) {
                Text("")
                    .font(.title)
                    .bold()

                Text("Date: January 25, 2024\nTime: 3:00 PM\nVenue: Your Venue Name")
            }
            .padding()

            Spacer() // Leave space for navigation control bar
        }
        .padding(.horizontal)
        .background(Color.white)
        .navigationBarHidden(true) // Hide the navigation bar
    }
}

struct ViewDetails_Previews: PreviewProvider {
    static var previews: some View {
        ViewDetails()
    }
}
