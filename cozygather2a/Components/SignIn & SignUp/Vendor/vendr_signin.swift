//import SwiftUI
//import Firebase
//import FirebaseAuth
//import FirebaseFirestore
//
//struct VendrSignIn: View{
//    @State var color = Color.black.opacity(0.7)
//    @State var email = ""
//    @State var pass = ""
//    @State var visible = false
//    @State private var TransitionToAskDetailsActive = false
//    @State private var isVendrSignUpActive = false
//    @State private var error = ""
//    @State private var alert = false
//    
//    var body: some View{
//        VStack{
//        Image("logo")
//                .resizable()
//                .frame(width: 200, height: 100)
//                .padding(.top, 30)
//            Text("Sign In")
//                            .font(.title)
//                            .fontWeight(.bold)
//                            .foregroundColor(self.color)
//                            .padding(.top, 20)
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
//            HStack {
//                Spacer()
//                Button(action: {}) {
//                    Text("Forgot password?")
//                        .fontWeight(.bold)
//                        .foregroundColor(.blue)
//                }
//                .padding(.top, 10)
//            }
//            
//            Button(action: {
//                            withAnimation {
//                                TransitionToAskDetailsActive.toggle()
//                            }
//                        }) {
//                            Text("Sign In")
//                                .foregroundColor(.white)
//                                .padding(.vertical, 15)
//                                .frame(maxWidth: .infinity)
//                        }
//                        .background(Color.blue)
//                        .cornerRadius(8)
//                        .padding(.top, 20)
//                        .fullScreenCover(isPresented: $TransitionToAskDetailsActive, content: {
//                            TransitionToAskDetails()
//                        })
//            
//            HStack{
//                Text("Don't have an account?")
//                Button(action: {
//                    withAnimation {
//                        isVendrSignUpActive.toggle()
//                    }
//                }) {
//                    Text("Sign Up")
//                        .foregroundColor(.blue)
//                    
//                }
//                .fullScreenCover(isPresented: $isVendrSignUpActive, content: {
//                    VendrSignUp()
//                })
//            }
//            .padding(.top)
//    }
//        .padding(.horizontal, 25)
//        
//    }
//    func signIn() {
//        Auth.auth().signIn(withEmail: self.email, password: self.pass) { (result, error) in
//            if let error = error {
//                self.error = error.localizedDescription
//                print("Sign-in error:", self.error) // Add this line to print the sign-in error
//                self.alert.toggle()
//            } else {
//                print("Sign-in successful")
//                TransitionToAskDetailsActive.toggle()
//            }
//        }
//    }
//
//}
//
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct VendrSignIn: View {
    @State private var color = Color.black.opacity(0.7)
    @State private var email = ""
    @State private var pass = ""
    @State private var visible = false
    @State private var TransitionToAskDetailsActive = false
    @State private var isVendrSignUpActive = false
    @State private var error = ""
    @State private var alert = false
    
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
            .fullScreenCover(isPresented: $TransitionToAskDetailsActive, content: {
                TransitionToAskDetails()
            })
            
            HStack {
                Text("Don't have an account?")
                Button(action: {
                    withAnimation {
                        isVendrSignUpActive.toggle()
                    }
                }) {
                    Text("Sign Up")
                        .foregroundColor(.blue)
                }
                .fullScreenCover(isPresented: $isVendrSignUpActive, content: {
                    VendrSignUp()
                })
            }
            .padding(.top)
        }
        .padding(.horizontal, 25)
    }
    
    func signIn() {
        Auth.auth().signIn(withEmail: self.email, password: self.pass) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
                print("Sign-in error:", self.error) // Add this line to print the sign-in error
                self.alert.toggle()
            } else {
                print("Sign-in successful")
                TransitionToAskDetailsActive.toggle()
            }
        }
    }
}

struct VendrSignIn_Previews: PreviewProvider {
    static var previews: some View {
        VendrSignIn()
    }
}
