//
//  TxtfieldModifier.swift
//  starcket
//
//  Created by Sue on 2023/01/05.
//

import Foundation
import SwiftUI

// MARK: - Modifier : 배경이 투명한 TextField 속성
struct ClearTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            .font(.subheadline)
            .padding(.horizontal, 20)
    }
}

// MARK: - Modifier : TextField 아래 밑줄을 표현하기 위한 Rectangle 속성
struct TextFieldUnderLineRectangleModifier: ViewModifier {
    let stateTyping: Bool
    var padding: CGFloat = 20
    func body(content: Content) -> some View {
        content
            .frame(height: 1)
            .foregroundColor(stateTyping ? .accentColor : .gray)
            .padding(.horizontal, padding)
    }
}

struct TextFieldClearButton: ViewModifier {
    @Binding var text: String
    
    func body(content: Content) -> some View {
        HStack {
            content
            
            if !text.isEmpty {
                Button(
                    action: { self.text = "" },
                    label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(Color(UIColor.opaqueSeparator))
                            .padding(.vertical, 10)
//                            .padding(.trailing, 10)
                    }
                )
            }
        }
    }
}
