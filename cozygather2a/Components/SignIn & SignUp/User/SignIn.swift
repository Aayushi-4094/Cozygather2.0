//import SwiftUI
//import Firebase
//import FirebaseAuth
//import FirebaseFirestore
//
//struct SignInPage: View {
//    @State var color = Color.black.opacity(0.7)
//    @State var username = ""
//    @State var email = ""
//    @State var pass = ""
//    @State var visible = false
//    @State private var isHomeUserActive = false
//    @State private var isUserSignUpActive = false
//    @State private var alert = false
//    @State private var error = ""
//
//    var body: some View {
//        VStack {
//            Image("logo")
//                .resizable()
//                .frame(width: 200, height: 100)
//                .padding(.top, 30)
//            
//            Text("Sign In")
//                .font(.title)
//                .fontWeight(.bold)
//                .foregroundColor(self.color)
//                .padding(.top, 20)
//            
//            TextField("Username", text: self.$username)
//                .padding()
//                .background(RoundedRectangle(cornerRadius: 8).stroke(self.username != "" ? Color.blue : self.color, lineWidth: 2))
//                .padding(.top, 15)
//                .autocapitalization(.none)
//            
//            TextField("Email", text: self.$email)
//                            .padding()
//                            .background(RoundedRectangle(cornerRadius: 8).stroke(self.email != "" ? Color.blue : self.color, lineWidth: 2))
//                            .padding(.top, 15)
//                            .keyboardType(.emailAddress)
//                            .autocapitalization(.none)
//            
//            HStack(spacing: 15) {
//                VStack {
//                    if self.visible {
//                        TextField("Password", text: self.$pass)
//                    } else {
//                        SecureField("Password", text: self.$pass)
//                    }
//                }
//                
//                Button(action: {
//                    self.visible.toggle()
//                }) {
//                    Image(systemName: self.visible ? "eye.fill" : "eye.slash.fill")
//                        .foregroundColor(self.color)
//                }
//            }
//            .padding()
//            .background(RoundedRectangle(cornerRadius: 8).stroke(self.pass != "" ? Color.blue : self.color, lineWidth: 2))
//            .padding(.top, 15)
//            
//            Button(action: {
//                self.signIn()
//            }) {
//                Text("Sign In")
//                    .foregroundColor(.white)
//                    .padding(.vertical, 15)
//                    .frame(maxWidth: .infinity)
//            }
//            .background(Color.blue)
//            .cornerRadius(8)
//            .padding(.top, 20)
//            .fullScreenCover(isPresented: $isHomeUserActive, content: {
//                UserHomeView(username: <#String#>)
//            })
//            
//            
//            HStack {
//                Text("Don't have an account?")
//                Button(action: {
//                    withAnimation {
//                        isUserSignUpActive.toggle()
//                    }
//                }) {
//                    Text("Sign Up")
//                        .foregroundColor(.blue)
//                }
//                .fullScreenCover(isPresented: $isUserSignUpActive, content: {
//                    SignUpPage()
//                })
//            }
//            .padding(.top)
//        }
//        .padding(.horizontal, 25)
//    }
//    
//    func signIn() {
//        Auth.auth().signIn(withEmail: self.email, password: self.pass) { (result, error) in
//            if let error = error {
//                self.error = error.localizedDescription
//                self.alert.toggle()
//            } else {
//                print("Sign-in successful")
//                self.fetchUsernameFromFirestore()
//            }
//        }
//    }
//    
//    func fetchUsernameFromFirestore() {
//        if let user = Auth.auth().currentUser {
//            let userRef = Firestore.firestore().collection("users").document(user.uid)
//            userRef.getDocument { (document, error) in
//                if let document = document, document.exists {
//                    if let username = document.data()?["username"] as? String {
//                        self.username = username
//                        isHomeUserActive.toggle()
//                    } else {
//                        print("Username not found")
//                    }
//                } else {
//                    print("Document does not exist")
//                }
//            }
//        } else {
//            print("User is not logged in")
//        }
//        isHomeUserActive.toggle()
//    }
//}
//
//struct SignInPage_Previews: PreviewProvider {
//    static var previews: some View {
//        SignInPage()
//    }
//}
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct SignInPage: View {
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var pass = ""
    @State var visible = false
    @State private var isHomeUserActive = false
    @State private var isUserSignUpActive = false
    @State private var alert = false
    @State private var error = ""

    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .frame(width: 200, height: 100)
                .padding(.top, 30)
            
            Text("Sign In")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(self.color)
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
            .background(Color.blue)
            .cornerRadius(8)
            .padding(.top, 20)
            .fullScreenCover(isPresented: $isHomeUserActive, content: {
                UserHomeView(username: self.email) // Pass email as the username
            })
            
            
            HStack {
                Text("Don't have an account?")
                Button(action: {
                    withAnimation {
                        isUserSignUpActive.toggle()
                    }
                }) {
                    Text("Sign Up")
                        .foregroundColor(.blue)
                }
                .fullScreenCover(isPresented: $isUserSignUpActive, content: {
                    SignUpPage()
                })
            }
            .padding(.top)
        }
        .padding(.horizontal, 25)
    }
    
//    func signIn() {
//        Auth.auth().signIn(withEmail: self.email, password: self.pass) { (result, error) in
//            if let error = error {
//                self.error = error.localizedDescription
//                self.alert.toggle()
//            } else {
//                print("Sign-in successful")
//                isHomeUserActive.toggle()
//            }
//        }
//    }
    func signIn() {
        Auth.auth().signIn(withEmail: self.email, password: self.pass) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
                print("Sign-in error:", self.error) // Add this line to print the sign-in error
                self.alert.toggle()
            } else {
                print("Sign-in successful")
                isHomeUserActive.toggle()
            }
        }
    }

}

struct SignInPage_Previews: PreviewProvider {
    static var previews: some View {
        SignInPage()
    }
}
