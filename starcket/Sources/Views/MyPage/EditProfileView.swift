//
//  EditProfileView.swift
//  starcket
//
//  Created by Sue on 2023/01/05.
//

import SwiftUI

struct EditProfileView: View {
    
    @EnvironmentObject var signUpAuthStore: SignUpAuthStore
    @State var newPassword = ""
    @State var checkPassword = ""
    @State private var isSecuredPassword = true
    @State private var isSecuredPasswordCheck = true
    @FocusState var isInFocusPassword: Bool
    @FocusState var isInFocusPasswordCheck: Bool
    @State var newAddress = ""
    @State var newPhoneNumber = ""
    

    @State var showingAlert = false
    @State var showingLogoutAlert = false
    
    // 비밀번호 정규표현식을 검사하는 함수입니다.
    func checkPasswordRule(password : String) -> Bool {
        let regExp = "^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,20}$"
        return password.range(of: regExp, options: .regularExpression) != nil
    }
    
    var body: some View{
        VStack{
            
            //MARK: - 비밀번호를 변경하는 부분
            
            Text("비밀번호 수정")
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 15)
                .padding(.bottom, 30)
                .padding(.top, 30)
        
            VStack(spacing: 30) {
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        // 비밀번호 숨김 아이콘일 때
                        if isSecuredPassword {
                            SecureField("비밀번호를 입력해주세요.", text: $newPassword)
                                .focused($isInFocusPassword) // 커서가 올라가있을 때 상태를 저장.
                                .modifier(ClearTextFieldModifier())
                        } else { // 비밀번호 보임 아이콘일 때
                            TextField("비밀번호를 입력해주세요.", text: $newPassword)
                                .focused($isInFocusPassword)
                                .modifier(ClearTextFieldModifier())
                        }
                        
                        Button(action: {
                            // 비밀번호 보임/숨김을 설정함.
                            isSecuredPassword.toggle()
                        }) {
                            Image(systemName: self.isSecuredPassword ? "eye.slash" : "eye")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20.5)
                                .accentColor(.gray)
                        }
                        // password가 비어있지 않으면서, 6자리 이상일 때 체크 아이콘 띄움.
                        if !newPassword.isEmpty && checkPasswordRule(password: newPassword) {
                            Image(systemName: "checkmark.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20.5)
                                .foregroundColor(.green)
                        }
                    } // HStack - TextField, Secured Image, Check Image
                    .frame(height: 30) // TextField가 있는 HStack의 height 고정 <- 아이콘 크기 변경 방지
                    .padding(.trailing, 20)
                    
                    Rectangle()
                        .modifier(TextFieldUnderLineRectangleModifier(stateTyping: isInFocusPassword))
                    
                    // 비밀번호 형식이 아닐 경우 경고 메시지
                    if !newPassword.isEmpty && !checkPasswordRule(password: newPassword) {
                        HStack(alignment: .center, spacing: 5) {
                            Image(systemName: "exclamationmark.circle")
                            Text("영문, 숫자, 특수문자를 포함하여 8~20자로 작성해주세요.")
                        }
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.horizontal, 20)
                    } else {
                        Text("") // TextField 자리 고정
                    }
                } // VStack - HStack과 밑줄 Rectangle
                .frame(height: 30)
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        // 비밀번호 숨김 아이콘일 때
                        if isSecuredPasswordCheck {
                            SecureField("비밀번호를 한번 더 입력해 주세요.", text: $checkPassword)
                                .focused($isInFocusPasswordCheck) // 커서가 올라가있을 때 상태를 저장.
                                .modifier(ClearTextFieldModifier())
                        } else { // 비밀번호 보임 아이콘일 때
                            TextField("비밀번호를 한번 더 입력해 주세요.", text: $checkPassword)
                                .focused($isInFocusPasswordCheck)
                                .modifier(ClearTextFieldModifier())
                        }
                        
                        Button(action: {
                            isSecuredPasswordCheck.toggle()
                        }) {
                            Image(systemName: self.isSecuredPasswordCheck ? "eye.slash" : "eye")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20.5)
                                .accentColor(.gray)
                        }
                        
                        
                        // passwordCheck가 비어있지 않으면서, password와 같으면 체크 아이콘 띄움.
                        if !checkPassword.isEmpty && newPassword == checkPassword && checkPasswordRule(password: checkPassword) {
                            Image(systemName: "checkmark.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20.5)
                                .foregroundColor(.green)
                        }
                    } // HStack - TextField, Secured Image, Check Image
                    .frame(height: 30) // TextField가 있는 HStack의 height 고정 <- 아이콘 크기 변경 방지
                    .padding(.trailing, 20)
                    
                    Rectangle()
                        .modifier(TextFieldUnderLineRectangleModifier(stateTyping: isInFocusPasswordCheck))
                    
                    // 비밀번호가 같지 않을 경우 경고 메시지
                    if !checkPassword.isEmpty && newPassword != checkPassword {
                        HStack(alignment: .center, spacing: 5) {
                            Image(systemName: "exclamationmark.circle")
                            Text("비밀번호를 다시 입력해주세요.")
                        }
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.horizontal, 20)
                    } else {
                        Text("") // TextField 자리 고정
                    }
                } // VStack - HStack과 밑줄 Rectangle
                .frame(height: 30)
                
                
                Spacer()
                Button {
                    /// 비밀번호가 공백이거나, 엔터가 눌린 상태에서 변경 버튼이 눌리지 않게끔하는 조건을 걸고
                    /// 그 안에 두 번 입력한 비밀번호가 같을 경우 비밀번호 변경을 시행 가능하게 함
                    if !newPassword.isEmpty && checkPasswordRule(password: newPassword) {
                        signUpAuthStore.updatePassword(password: newPassword)
                        showingLogoutAlert = true
                    } else {
                        showingAlert = true
                    }
                    newPassword = ""
                    checkPassword = ""
                } label: {
                    Text("비밀번호 변경")
                        .frame(width: 330)
                        .modifier(ColoredButtonModifier(cornerRadius: 10))
                }
                // alert: 입력한 두 비밀번호가 일치하지 않을 때 알림
                // ok버튼을 누르면 텍스트필드 초기화
                .modifier(PasswordAlertModifier(showingAlert: $showingAlert, password: $newPassword, password_2: $checkPassword))
                .alert("비밀번호가 변경되어, 보안상 고객님의 모든 기기에서 로그아웃 됩니다.", isPresented: $showingLogoutAlert) {
                    Button("Ok") {
                        signUpAuthStore.requestUserSignOut()
                        
                    }
                }
                
                Spacer()
            }
            
            
                
        }.navigationTitle("내 정보 수정")
 
    }
    
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
