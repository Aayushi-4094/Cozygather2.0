import SwiftUI
import Firebase
import FirebaseAuth

struct User: Identifiable {
    var id: String
    var fullName: String
    var userName: String
    // Add other user properties as needed
}

struct SignUpPage: View {
    @State private var color = Color.black.opacity(0.7)
    @State private var fullName = ""
    @State private var userName = ""
    @State private var phoneNumber = ""
    @State private var email = ""
    @State private var pass = ""
    @State private var repass = ""
    @State private var visible = false
    @State private var revisible = false
    @State private var isSignInPageActive = false
    @State private var alert = false
    @State private var error = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Sign Up")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(self.color)
                .padding(.top, 35)

            TextField("Full name", text: self.$fullName)
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).stroke(self.email != "" ? Color(red: 198/255, green: 174/255, blue: 128/255) : Color(red:67/255, green:13/255, blue:75/255) , lineWidth: 2))
                .padding(.horizontal, 20)
                .frame(height: 50)
                .autocapitalization(.words)
                .keyboardType(.default)

            TextField("User Name", text: self.$userName)
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).stroke(self.email != "" ? Color(red: 198/255, green: 174/255, blue: 128/255) : Color(red:67/255, green:13/255, blue:75/255) , lineWidth: 2))
                .padding(.horizontal, 20)
                .frame(height: 50)
                .autocapitalization(.none)
                .keyboardType(.default)

            TextField("Phone Number", text: self.$phoneNumber)
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).stroke(self.email != "" ? Color(red: 198/255, green: 174/255, blue: 128/255) : Color(red:67/255, green:13/255, blue:75/255) , lineWidth: 2))
                .padding(.horizontal, 20)
                .frame(height: 50)
                .keyboardType(.phonePad)

            TextField("Email", text: self.$email)
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).stroke(self.email != "" ? Color(red: 198/255, green: 174/255, blue: 128/255) : Color(red:67/255, green:13/255, blue:75/255) , lineWidth: 2))
                .padding(.horizontal, 20)
                .frame(height: 50)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)

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
            .background(RoundedRectangle(cornerRadius: 8).stroke(self.email != "" ? Color(red: 198/255, green: 174/255, blue: 128/255) : Color(red:67/255, green:13/255, blue:75/255) , lineWidth: 2))
            .padding(.horizontal, 20)
            .frame(height: 50)

            HStack(spacing: 15) {
                VStack {
                    if self.revisible {
                        TextField("Password", text: self.$repass)
                    } else {
                        SecureField("Password", text: self.$repass)
                    }
                }
                Button(action: {
                    self.revisible.toggle()
                }) {
                    Image(systemName: self.revisible ? "eye.fill" : "eye.slash.fill")
                        .foregroundColor(self.color)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 8).stroke(self.email != "" ? Color(red: 198/255, green: 174/255, blue: 128/255) : Color(red:67/255, green:13/255, blue:75/255) , lineWidth: 2))
            .padding(.horizontal, 20)
            .frame(height: 50)

            Button(action: {
                self.signUp()
            }) {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
                    .background(Color(red:67/255, green:13/255, blue:75/255))
                    .cornerRadius(8)
            }
            .padding(.horizontal, 20)
            
            .fullScreenCover(isPresented: $isSignInPageActive) {
                        SignInPage()
                    }
                    .onAppear {
                        if UserDefaults.standard.bool(forKey: "isSignedUp") {
                            // User has already signed up, navigate to sign-in page directly
                            isSignInPageActive = true
                        }
                    }

            HStack {
                Text("Already have an account?")
                Button(action: {
                    withAnimation {
                        isSignInPageActive.toggle()
                    }
                }) {
                    Text("Sign In")
                        .foregroundColor(Color(red:67/255, green:13/255, blue:75/255))
                        .font(.subheadline)
                }
                .fullScreenCover(isPresented: $isSignInPageActive) {
                    SignInPage()
                }
            }
            .padding(.top)
        }
    }

//    func signUp() {
//            if pass == repass {
//                Auth.auth().createUser(withEmail: email, password: pass) { (result, error) in
//                    if let error = error {
//                        self.error = error.localizedDescription
//                        self.alert.toggle()
//                   }
//                        else {
//                                            let newUser = User(id: result?.user.uid ?? "", fullName: self.fullName, userName: self.userName)
//                                            FirestoreManager.shared.createUser(newUser)
//                                            print("Sign-up successful")
//                        // Store the user information in Firestore or another database
//                        // Replace the placeholder comment with the actual code
//                        FirestoreManager.shared.createUser(newUser)
//                        print("Sign-up successful")
//                        isSignInPageActive.toggle()
//                    }
//                }
//            } else {
//                self.error = "Passwords do not match"
//                self.alert.toggle()
//            }
//        UserDefaults.standard.set(true, forKey: "isSignedUp")
//        }
    func signUp() {
        if pass == repass {
            Auth.auth().createUser(withEmail: email, password: pass) { (result, error) in
                if let error = error {
                    self.error = error.localizedDescription
                    print("Sign-up error:", self.error) // Add this line to print the sign-up error
                    self.alert.toggle()
                } else {
                    let newUser = User(id: result?.user.uid ?? "", fullName: self.fullName, userName: self.userName)
                    FirestoreManager.shared.createUser(newUser)
                    print("Sign-up successful")
                    isSignInPageActive.toggle()
                }
            }
        } else {
            self.error = "Passwords do not match"
            self.alert.toggle()
        }
        UserDefaults.standard.set(true, forKey: "isSignedUp")
    }

    }

struct SignUpPage_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPage()
    }
}
