//import FirebaseAuth
//import FirebaseFirestore
//import FirebaseFirestoreSwift
//
//class AuthenticationManager: ObservableObject {
//    static let shared = AuthenticationManager()
//
//    @Published var currentUser: User?
//
//    private init() {}
//
//    func signUp(email: String, password: String, fullName: String, userName: String, completion: @escaping (Bool) -> Void) {
//        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
//            guard error == nil else {
//                completion(false)
//                return
//            }
//
//            let newUser = User(id: result?.user.uid ?? "", fullName: fullName, userName: userName)
//            self.currentUser = newUser
//            self.storeUserInFirestore(newUser)
//            completion(true)
//        }
//    }
//
//    func signIn(email: String, password: String, completion: @escaping (Bool) -> Void) {
//        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
//            guard error == nil else {
//                completion(false)
//                return
//            }
//
//            // Fetch user information from Firestore
//            self.fetchUserFromFirestore(userId: result?.user.uid ?? "") { user in
//                self.currentUser = user
//                completion(true)
//            }
//        }
//    }
//
//    private func storeUserInFirestore(_ user: User) {
//        do {
//            let _ = try Firestore.firestore().collection("users").document(user.id).setData(from: user)
//        } catch {
//            print("Error storing user in Firestore: \(error)")
//        }
//    }
//
//    private func fetchUserFromFirestore(userId: String, completion: @escaping (User?) -> Void) {
//        Firestore.firestore().collection("users").document(userId).getDocument { (document, error) in            guard let document = document, document.exists, let user = try? document.data(as: User.self) else {
//                completion(nil)
//                return
//            }
//
//            completion(user)
//        }
//    }
//}
