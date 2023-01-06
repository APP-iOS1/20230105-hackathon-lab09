//
//  HistoryStarView.swift
//  starcket
//
//  Created by geonhyeong on 2023/01/06.
//

import SwiftUI

struct HistoryStarView: View {
	@Binding var tabSelection: Int

    var body: some View {
		NavigationStack {
			VStack {
				Image("MilkyWay")
					.resizable()
					.scaledToFit()
					.frame(width: Screen.maxWidth, height: Screen.maxHeight)
			}
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					HStack {
						Button {
							tabSelection = 1
						} label: {
							Image(systemName: "arrow.down")
								.foregroundColor(.white)
						}
						
						Button {
							
						} label: {
							Image(systemName: "line.3.horizontal")
								.foregroundColor(.clear)
						}
						.disabled(true)
					}
					.padding(.trailing, 15)
				}
			}
		}
    }
}

struct HistoryStarView_Previews: PreviewProvider {
    static var previews: some View {
		HistoryStarView(tabSelection: .constant(0))
    }
}
