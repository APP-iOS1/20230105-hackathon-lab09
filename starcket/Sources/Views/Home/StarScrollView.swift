//
//  StarScrollView.swift
//  starcket
//
//  Created by geonhyeong on 2023/01/06.
//

import SwiftUI

struct StarScrollView: View {
	@Binding var darkmodeToggle: Bool
	@State private var tabSelection: Int = 0

	var body: some View {
		GeometryReader { proxy in
			TabView(selection: $tabSelection) {
				HistoryStarView(tabSelection: $tabSelection)
					.rotationEffect(.degrees(-90))
					.frame(width: Screen.maxWidth, height: Screen.maxHeight - proxy.safeAreaInsets.bottom - proxy.safeAreaInsets.top - 100)
					.edgesIgnoringSafeArea(.all)
					.tag(0)

				HomeView(darkmodeToggle: $darkmodeToggle, tabSelection: $tabSelection)
					.rotationEffect(.degrees(-90))
					.frame(width: Screen.maxWidth, height: Screen.maxHeight - proxy.safeAreaInsets.bottom - proxy.safeAreaInsets.top - 100)
					.tag(1)
			}
			.frame(
				width: proxy.size.height, // Height & width swap
				height: proxy.size.width
			)
			.rotationEffect(.degrees(90), anchor: .topLeading) // Rotate TabView
			.offset(x: proxy.size.width) // Offset back into screens bounds
			.tabViewStyle(
				PageTabViewStyle(indexDisplayMode: .never)
			)
			.onAppear {
				tabSelection = 1
			}
		}
		.animation(.easeOut(duration: 1), value: tabSelection)
	}
}

struct StarScrollView_Previews: PreviewProvider {
	static var previews: some View {
		StarScrollView(darkmodeToggle: .constant(false))
	}
}
