//
//  ContentView.swift
//  starcket
//
//  Created by geonhyeong on 2023/01/05.
//

import SwiftUI

struct ContentView: View {
	@State private var tabSelection: Int = 0
	@State private var darkmodeToggle: Bool = true
	@ObservedObject var tabbarManager = TabBarManager.shared

	var body: some View {
		//        NavigationView {
		//            SignInView()
		ZStack {
			ZStack {
				switch tabbarManager.curTabSelection {
				case .home:
					StarScrollView(darkmodeToggle: $darkmodeToggle)
//					HomeView(darkmodeToggle: $darkmodeToggle)
				case .list:
					BucketListView()
				case .chart:
					AnalyzeView()
				case .profile:
					MyPageView(darkmodeToggle: $darkmodeToggle)
				}
			} // ZStack
			.padding(.bottom, tabbarManager.bottomPadding)
			
			if (tabbarManager.showTabBar) {
				CustomTabView(darkmodeToggle: $darkmodeToggle)
			}
		} // ZStack
		.edgesIgnoringSafeArea(.bottom)
		.preferredColorScheme(darkmodeToggle ? .dark : .light)

//		TabView(selection: $tabSelection) {
//			HomeView(darkmodeToggle: $darkmodeToggle)
//				.tabItem {
//					Image(systemName: "house.fill")
//					Text("별킷")
//				}.tag(0)
//			BucketListView()
//				.tabItem {
//					Image(systemName: "checklist.checked")
//					Text("리스트")
//				}.tag(1)
//			AnalyzeView()
//				.tabItem {
//					Image(systemName: "chart.bar.xaxis")
//					Text("분석")
//				}.tag(2)
//			MyPageView(darkmodeToggle: $darkmodeToggle)
//				.tabItem {
//					Image(systemName: "person.crop.circle.fill")
//					Text("마이페이지")
//				}.tag(3)
//
//			// 수현 테스트용
//			SoohyunTest()
//				.tabItem {
//					Image(systemName: "star")
//					Text("실험용")
//				}
//		}
//		.preferredColorScheme(darkmodeToggle ? .dark : .light)
		
		//            if UserDefaults.standard.object(forKey: "userIdToken") != nil {
		//                TabView(selection: $tabSelection) {
		//                    HomeView()
		//                        .tabItem {
		//                            Image(systemName: "house.fill")
		//                            Text("별킷")
		//                        }.tag(0)
		//                    BucketListView()
		//                        .tabItem {
		//                            Image(systemName: "checklist.checked")
		//                            Text("리스트")
		//                        }.tag(1)
		//                    AnalyzeView()
		//                        .tabItem {
		//                            Image(systemName: "chart.bar.xaxis")
		//                            Text("분석")
		//                        }.tag(2)
		//                    MyPageView()
		//                        .tabItem {
		//                            Image(systemName: "person.crop.circle.fill")
		//                            Text("마이페이지")
		//                        }.tag(3)
		//                }
		//            }else{
		//
		//                SignInView()
		//            }
		
		//        }
	}
}



struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
