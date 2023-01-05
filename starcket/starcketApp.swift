//
//  starcketApp.swift
//  starcket
//
//  Created by geonhyeong on 2023/01/05.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
				   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
	FirebaseApp.configure()

	return true
  }
}

@main
struct starcketApp: App {
	// register app delegate for Firebase setup
	@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
