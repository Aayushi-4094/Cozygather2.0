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

    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .frame(width: 200, height: 100)
                .padding(.top, 30)
            
            Text("Sign In")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color(red: 33/225, green: 5/255, blue: 247/255))
                .padding(.top, 20)
            
            TextField("Email", text: self.$email)
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).stroke(self.email != "" ? Color.blue : self.color, lineWidth: 2))
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
            .background(RoundedRectangle(cornerRadius: 8).stroke(self.pass != "" ? Color.blue : self.color, lineWidth: 2))
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
                       .fullScreenCover(isPresented: $VendorHomePageActive, content: {
                           VendorHomePage()
                       })
                   }
                   .padding(.horizontal, 25)
                   .alert(isPresented: $alert) {
                       Alert(title: Text("Error"), message: Text(error), dismissButton: .default(Text("OK")))
                   }
        
                   .fullScreenCover(isPresented: $isAuthenticated) { // Navigate to VendorHomePage if authenticated
                       VendorHomePage()
                   }
               }

               func signIn() {
                   Auth.auth().signIn(withEmail: self.email, password: self.pass) { (result, error) in
                       if let error = error {
                           self.error = error.localizedDescription
                           print("Sign-in error:", self.error) // Add this line to print the sign-in error
                           self.alert.toggle()
                       } else {
                           print("Sign-in successful")
                           self.isAuthenticated = true // Set isAuthenticated to true upon successful sign-in
                       }
                   }
               }
           }

struct VendrSignIn_Previews: PreviewProvider {
    static var previews: some View {
        VendrSignIn()
    }
}
