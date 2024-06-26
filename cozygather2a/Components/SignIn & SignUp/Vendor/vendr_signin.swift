import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct VendrSignIn: View {
    @State private var color = Color.black.opacity(0.7)
    @State private var email = ""
    @State private var pass = ""
    @State private var visible = false
    @State private var VendorHomePageActive = false
    @State private var isVendrSignUpActive = false
    @State private var error = ""
    @State private var alert = false
    @State private var isAuthenticated = false // New state to track authentication status
    
    @State private var DetailViewActive = false
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .frame(width: 200, height: 100)
                .padding(.top, 30)
            
            Text("Sign In")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color(red:67/255, green:13/255, blue:75/255))
                .padding(.top, 20)
            
            TextField("Email", text: self.$email)
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).stroke(self.email != "" ? Color(red: 198/255, green: 174/255, blue: 128/255) : Color(red:67/255, green:13/255, blue:75/255) , lineWidth: 2))
                .padding(.top, 15)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            
            HStack(spacing: 15) {
                VStack {
                    if self.visible {
                        TextField("Password", text: self.$pass)
                    } else {
                        SecureField("Password", text: self.$pass)
                    }
                }
                
                Button(action: {
                    self.visible.toggle()
                }) {
                    Image(systemName: self.visible ? "eye.fill" : "eye.slash.fill")
                        .foregroundColor(self.color)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 8).stroke(self.pass != "" ? Color(red: 198/255, green: 174/255, blue: 128/255) : Color(red:67/255, green:13/255, blue:75/255) , lineWidth: 2))
            .padding(.top, 15)
            
            Button(action: {
                self.signIn()
            }) {
                Text("Sign In")
                    .foregroundColor(.white)
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
            }
            .background(Color(red:67/255, green:13/255, blue:75/255))
            .cornerRadius(8)
            .padding(.top, 20)
            .fullScreenCover(isPresented: $DetailViewActive, content: {
                DetailView()
            })
        }
        .padding(.horizontal, 25)
        .alert(isPresented: $alert) {
            Alert(title: Text("Error"), message: Text(error), dismissButton: .default(Text("OK")))
        }
        
//        .fullScreenCover(isPresented: $isAuthenticated) { // Navigate to VendorHomePage if authenticated
//            VendorHomePage()
//        }

        HStack {
            Text("Don't have an account?")
            Button(action: {
                withAnimation {
                    isVendrSignUpActive.toggle()
                }
            }) {
                Text("Sign Up")
                    .foregroundColor(Color(red:67/255, green:13/255, blue:75/255))
                    .font(.subheadline)
            }
            .fullScreenCover(isPresented: $isVendrSignUpActive) {
                VendrSignUp()
            }
        }
        .padding(.top)
    }

    func signIn() {
        Auth.auth().signIn(withEmail: self.email, password: self.pass) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
                print("Sign-in error:", self.error) // Add this line to print the sign-in error
                self.alert.toggle()
            } else {
                print("Sign-in successful")
                self.DetailViewActive = true
            }
        }
    }
}

struct VendrSignIn_Previews: PreviewProvider {
    static var previews: some View {
        VendrSignIn()
    }
}
