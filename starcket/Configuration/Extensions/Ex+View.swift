//
//  Ex+View.swift
//  starcket
//
//  Created by 윤소희 on 2023/01/06.
//
import Foundation
import SwiftUI

public extension View {
	func fullBackground(imageName: String) -> some View {
       return background(
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: Screen.maxWidth, height: Screen.maxHeight)
                    .edgesIgnoringSafeArea(.all)
       )
    }
}
