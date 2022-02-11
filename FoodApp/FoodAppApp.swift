//
//  FoodAppApp.swift
//  FoodApp
//
//  Created by Ierchenko Anna  on 2/7/22.
//

import SwiftUI
import Firebase

@main
struct FoodAppApp: App {
    @UIApplicationDelegateAdaptor(AppDlegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

//initializeing Firebase

class AppDlegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                        launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
