//
//  SafeDoseApp.swift
//  SafeDose
//
//  Created by Ashley Valdez on 4/27/24.
//

import SwiftUI
import Firebase

@main
struct SafeDoseApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            EnterMedicationName().environmentObject(viewModel)
        }
    }
    
    class AppDelegate: NSObject, UIApplicationDelegate {
        func application(_ application: UIApplication,
                         didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            FirebaseApp.configure()
            
            return true
        }
    }
}
