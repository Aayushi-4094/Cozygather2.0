//
//  cozygather2aApp.swift
//  cozygather2a
//
//  Created by user2batch2 on 18/03/24.
//

//import SwiftUI
//import FirebaseCore
//
//@main
//struct cozygather2aApp: App {
//    var body: some Scene {
//        WindowGroup {
//          NavigationView {
//            ContentView()
//          }
//        }
//      }
//    }
//
//class AppDelegate: NSObject, UIApplicationDelegate {
//  func application(_ application: UIApplication,
//                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    FirebaseApp.configure()
//    return true
//  }
//}
import SwiftUI
import Firebase

@main
struct cozygather2aApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
