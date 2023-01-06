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
  @State var animate = false
  @State var endSplash = false
    
	var body: some View {
  ZStack {
		ZStack {
			ZStack {
				switch tabbarManager.curTabSelection {
				case .home:
					StarScrollView(darkmodeToggle: $darkmodeToggle)
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
                ZStack{
                
                Image("LargeStar")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: animate ? .fill : .fit)
                    .frame(width: animate ? nil : 85, height: animate ? nil : 85)
                
                    .scaleEffect(animate ? 3 : 1)
                
                    .frame(width: UIScreen.main.bounds.width)
            }
            .ignoresSafeArea()
            .onAppear(perform: animateSplash)
            .opacity(endSplash ? 0 : 1)
   }
   
   func animateSplash(){
        DispatchQueue.main.asyncAfter(deadline: .now()){
            withAnimation(Animation.easeOut(duration: 0.45)){
                animate.toggle()
            }
            withAnimation(Animation.easeOut(duration: 0.45)){
                endSplash.toggle()
            }
        }
    }
}

	static var previews: some View {
		ContentView()
	}