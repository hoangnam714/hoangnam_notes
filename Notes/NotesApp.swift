//
//  NotesApp.swift
//  Notes
//
//  Created by admin on 23/11/2023.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct NotesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var dataStore: DataStore = .init()
    @AppStorage("userName") var userName: String = ""
    @AppStorage("userID") var userID: String = ""
    @AppStorage("isLogin") var isLogin: Bool = false
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                LoginView()
                    .opacity(isLogin ? 0 : 1)
                    .zIndex(0)
                TabbarView()
                    .opacity(isLogin ? 1 : 0)
                    .zIndex(1)
            }
            .environmentObject(dataStore)
        }
    }
}
