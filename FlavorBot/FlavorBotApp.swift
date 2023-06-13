//
//  FlavorBotApp.swift
//  FlavorBot
//
//  Created by Taif Al.qahtani on 05/06/2023.
//

import SwiftUI
import FirebaseCore

//Configure Firebase
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct FlavorBotApp: App {
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    //Navigation Router
    @StateObject var viewRouter : ViewRouter = ViewRouter()
    
    var body: some Scene {
        WindowGroup {
            MotherView(viewRouter: viewRouter).environmentObject(ViewRouter())
        }
    }
}
