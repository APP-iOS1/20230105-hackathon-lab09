//
//  starcketApp.swift
//  starcket
//
//  Created by geonhyeong on 2023/01/05.
//

import SwiftUI
import FirebaseCore
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
				   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
	FirebaseApp.configure()
    let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_NAVTIVE_APP_KEY"] ?? ""
      
    //print("kakaoAppKey: \(kakaoAppKey)")
    //Kakao SDK 초기화
    KakaoSDK.initSDK(appKey: kakaoAppKey as! String)

	return true
  }
}

@main
struct starcketApp: App {
	// register app delegate for Firebase setup
	@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authStore = AuthStore.shared

    var body: some Scene {
        WindowGroup {  
            ContentView()
                .onOpenURL { url in
                    if (AuthApi.isKakaoTalkLoginUrl(url)){
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                }
                .environmentObject(authStore)
                .environmentObject(SignUpAuthStore())
        }
    }
}
