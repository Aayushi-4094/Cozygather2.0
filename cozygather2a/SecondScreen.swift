import SwiftUI

struct SecondScreen: View {
    @State private var goToThirdScreen = false
    @State private var isVendorSignUpActive = false
    @State private var isUserSignUpActive = false

    var body: some View {
        NavigationView {
            VStack {
                Image("logo1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height * 0.15)
                    .padding(.top, 20)

                Text("Where Simplified Planning Meets Stress-Free Celebrations")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)

                Spacer()

                Text("Choose your Profile")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.top, 20)

                HStack {
                    ProfileButton(imageName: "supplier_logo", buttonText: "Supplier", isActive: $isVendorSignUpActive)

                    Divider()

                    ProfileButton(imageName: "user_logo", buttonText: "User", isActive: $isUserSignUpActive)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 20)

                Spacer()
            }
            .fullScreenCover(isPresented: $isVendorSignUpActive) {
                VendrSignUp()
            }
            .fullScreenCover(isPresented: $isUserSignUpActive) {
                SignUpPage()
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
        .background(Color(red: 0.96, green: 0.94, blue: 0.93))
    }
}

struct SecondScreen_Previews: PreviewProvider {
    static var previews: some View {
        SecondScreen()
    }
}

struct ProfileButton: View {
    let imageName: String
    let buttonText: String
    @Binding var isActive: Bool

    var body: some View {
        VStack {
            Button(action: {
                isActive = true
            }) {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.15)
                    .cornerRadius(20)
                    .shadow(radius: 5)
            }

            Text(buttonText)
                .font(.headline)
                .padding(.top, 10)
        }
    }
}
