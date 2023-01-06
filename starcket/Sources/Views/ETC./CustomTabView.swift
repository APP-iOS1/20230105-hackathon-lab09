//
//  CustomTabView.swift
//  DorongDorong
//
//  Created by geonhyeong on 2022/11/17.
//

import SwiftUI

enum Tab {
	case home
	case list
	case chart
	case profile
}

class TabBarManager: ObservableObject {
	@Published var showTabBar: Bool = true
	@Published var curTabSelection: Tab = .home
	@Published var preTabSelection: Tab = .home
	@Published var barOffset: CGFloat = -139
	@Published var bottomPadding: CGFloat = Screen.maxHeight * 0.10

	static let shared = TabBarManager() // Singleton
}

struct CustomTabView: View {
	//MARK: Property Wrapper
	@ObservedObject var tabbarManager = TabBarManager.shared
	@Binding var darkmodeToggle: Bool

	
	//MARK: Property
	let offsetList: [CGFloat] = [-139, -68, 4, 76, 144]
	
	var body: some View {
		VStack(spacing: 0) {
			Spacer()
			ZStack {
				HStack(alignment: .center, spacing: 8) {
					ForEach(0..<4) { index in
						Spacer().frame(width: Screen.maxWidth * 0.02)
						
						Button {
							switch index {
							case 0: tabbarManager.curTabSelection = .home
							case 1: tabbarManager.curTabSelection = .list
							case 2: tabbarManager.curTabSelection = .chart
							default: tabbarManager.curTabSelection = .profile
							}
						} label: {
							switch index {
							case 0: TabButton(darkmodeToggle: $darkmodeToggle,  isSelection: tabbarManager.curTabSelection == .home, name: "별킷", systemName: "house.fill", systemNameByNotSelected: "house.fill")
							case 1:
								TabButton(darkmodeToggle: $darkmodeToggle, isSelection: tabbarManager.curTabSelection == .list, name: "리스트", systemName: "checklist.checked", systemNameByNotSelected: "checklist.checked")
							case 2: TabButton(darkmodeToggle: $darkmodeToggle, isSelection: tabbarManager.curTabSelection == .chart, name: "분석", systemName: "chart.bar.xaxis", systemNameByNotSelected: "chart.bar.xaxis")
							default: TabButton(darkmodeToggle: $darkmodeToggle, isSelection: tabbarManager.curTabSelection == .profile, name: "마이프로필", systemName: "person.crop.circle.fill", systemNameByNotSelected: "person.crop.circle.fill")
							}
						} // Button
						
						Spacer().frame(width: Screen.maxWidth * 0.02)
					} //ForEach
					.frame(height: Screen.maxHeight * 0.10)
					.edgesIgnoringSafeArea(.all)
				} // HStack
				.frame(width: Screen.maxWidth)
				.background(darkmodeToggle ? .black : .white)
//				.clipShape(RoundedRectangle(cornerRadius: 22))
				.overlay {
//					RoundedRectangle(cornerRadius: 22)
//						.stroke(.gray, lineWidth: 2)
//
//					Rectangle()
//						.foregroundColor(Color(tabbarManager.curTabSelection == .register ? "" : "Color2"))
//						.frame(width: Screen.maxWidth * 0.15, height: 3)
//						.offset(x: tabbarManager.barOffset, y: -Screen.maxHeight * 0.10/2)
//						.animation(.spring(), value: tabbarManager.barOffset)
				}
			} // ZStack
			.edgesIgnoringSafeArea([.bottom])
			.onAppear {
				tabbarManager.bottomPadding = Screen.maxHeight * 0.10
			}
		} // VStack
	}
}

//MARK: - TabButton
struct TabButton: View {
	@Binding var darkmodeToggle: Bool
	
	//MARK: Property
	let isSelection: Bool 	// 현재 Tab
	let name: String		// Tab 이름
	let systemName: String 	// 선택되었을때
	let systemNameByNotSelected: String // 선택되지 않았을때
	
	var body: some View {
		VStack(spacing: 5) {
			Image(systemName: isSelection ? systemName : systemNameByNotSelected)
				.resizable()
				.scaledToFit()
				.frame(width: 25)
			Text(name)
				.font(.custom("Pretendard-Medium", size: 11))
			Spacer()
		} // VStack
		.padding(.vertical, 17)
		.foregroundColor(isSelection ? .accentColor : .gray)
	}
}

//MARK: - Plus TabButton
struct PlusTabButton: View {
	//MARK: Property
	let isSelection: Bool 	// 현재 Tab
	let name: String		// Tab 이름
	let systemName: String 	// 선택되었을때
	
	var body: some View {
		VStack {
			Image(systemName: systemName)
				.resizable()
				.scaledToFit()
				.frame(width: 40)
				.foregroundColor(Color("Color2"))
			Spacer()
		} // VStack
		.padding(.vertical, 17)
	}
}

struct CustomTabView_Previews: PreviewProvider {
	static var previews: some View {
		CustomTabView(darkmodeToggle: .constant(false))
	}
}
