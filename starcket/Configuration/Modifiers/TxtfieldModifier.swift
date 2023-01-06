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


// MARK: - Modifier : 배경이 회색인 TextField 속성
struct GrayBackgroundTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color("bgColor"))
            .cornerRadius(15)
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            .font(.subheadline)
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


struct PasswordAlertModifier: ViewModifier {
    @Binding var showingAlert: Bool
    @Binding var password: String
    @Binding var password_2: String
    func body(content: Content) -> some View {
        content
            .alert("비밀번호를 다시 입력해주세요", isPresented: $showingAlert) {
                Button("Ok") {
                    password = ""
                    password_2 = ""
                }
            }
    }
}
