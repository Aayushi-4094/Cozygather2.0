import SwiftUI

struct TransitionToAskDetails: View {
    var body: some View {
        NavigationView { // Embed the content in a NavigationView
            VStack {
                Text("Now complete your profile by filling the details")
                    .font(Font.custom("AirbnbCereal_W_Md", size: 40))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.07, green: 0.05, blue: 0.15))
                    .frame(width: 284, alignment: .center)
                    .padding()

                NavigationLink(destination: detail()) { // Add NavigationLink
                    HStack(alignment: .center, spacing: 4) {
                        Text("Fill In The Details")
                            .font(Font.custom("YourCustomFont", size: 16))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 14)
                    .frame(width: 211, alignment: .center)
                    .background(Color(red: 0.34, green: 0.41, blue: 1))
                    .cornerRadius(12)
                }
                .padding() // Add padding around the NavigationLink
            }
            .navigationBarHidden(true) // Hide the navigation bar
        }
    }
}

struct TransitionToAskDetails_Previews: PreviewProvider {
    static var previews: some View {
        TransitionToAskDetails()
    }
}
