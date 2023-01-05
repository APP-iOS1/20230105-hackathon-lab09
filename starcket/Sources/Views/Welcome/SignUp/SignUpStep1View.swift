//
//  SignUpStep1View.swift
//  big-project-a-customer-ios
//
//  Created by geonhyeong on 2022/12/27.
//

import SwiftUI
import PopupView

// MARK: - Extension View
/// 키보드 밖 화면 터치 시 키보드 사라지는 함수를 선언하기 위한 extension 입니다.
extension View {
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

// MARK: - SignUpStep1View
///이메일과 비밀번호를 설정하는 View 입니다.
struct SignUpStep1View: View {
    // MARK: - Property Wrappers
    //	@Binding var isLoginSheet: Bool
    @Environment(\.dismiss) private var dismiss
    
    @State var email = ""
    @State var password = ""
    @State var passwordCheck = ""
    @FocusState var isInFocusEmail: Bool
    @FocusState var isInFocusPassword: Bool
    @FocusState var isInFocusPasswordCheck: Bool
    @State private var isSecuredPassword = true
    @State private var isSecuredPasswordCheck = true
    @State private var isDuplicated = false
    @State private var isNotDuplicated = false
    
    @Binding var navStack: NavigationPath
    
    @State var isSucceedSignUp = false // ** 서버 연동 후 필요한 코드 **
    @EnvironmentObject var signUpAuthStore: SignUpAuthStore
    
    
    // MARK: Methods
    // 이메일이 aaa@aaa.aa 형식인지 검사하는 함수입니다.
    func checkEmailRule(string: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return  NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: string)
    }
    // 비밀번호 정규표현식을 검사하는 함수입니다.
    func checkPasswordRule(password : String) -> Bool {
        let regExp = "^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,20}$"
        return password.range(of: regExp, options: .regularExpression) != nil
    }
    // 이메일 중복을 검사하는 함수입니다.
    func checkEmailDuplicated() {
        Task {
            if await signUpAuthStore.isEmailDuplicated(currentUserEmail: email) {
                // 이메일이 중복될 경우
                isDuplicated = true
                isNotDuplicated = false
            } else {
                isDuplicated = false
                isNotDuplicated = true
            }
        }
    }
    
    
    // MARK: - Body SignUpStep1View
    /// SignUpStep1View의 body 입니다.
    var body: some View {
        VStack {
            HStack {
                Text("이메일과 비밀번호를\n입력해 주세요.")
                    .font(.title2)
                Spacer()
            } // HStack 입력 안내문구
            .padding(EdgeInsets(top: 30, leading: 15, bottom: 40, trailing: 15))
            
            VStack(spacing: 40) {
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        TextField("이메일 (예: test@gmail.com)", text: $email)
                        .focused($isInFocusEmail)
                        .modifier(ClearTextFieldModifier())
                        .onChange(of: email) { newValue in
                            signUpAuthStore.emailDuplicationState = .duplicated
                        }
                        
                        // email 필드가 비어있지 않으면서 정규식에 적합한다면
                        if !email.isEmpty && checkEmailRule(string: email) {
                            // 이메일 중복검사
                            // 중복확인 버튼을 띄우고 사용 가능하다면 체크 아이콘 띄우고, 아니면 버튼 유지
                            if signUpAuthStore.emailDuplicationState == .duplicated {
                                Button {
                                    checkEmailDuplicated()
                                } label: {
                                    Text("중복 확인") // MARK: 수정자 분리 필요함.
                                        .font(.footnote)
                                        .foregroundColor(.accentColor)
                                        .padding(5)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(Color.accentColor, lineWidth: 1)
                                        )
                                        .background(Color.white)
                                } // Button
                            } else if signUpAuthStore.emailDuplicationState == .checking{
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
                                    .frame(height: 40)
                            } else {
                                Image(systemName: "checkmark.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20.5)
                                    .foregroundColor(.green)
                            } // else
                        } // if
                    }
                    .frame(height: 30) // TextField가 있는 HStack의 height 고정 <- 아이콘 크기 변경 방지
                    .padding(.trailing, 20)
                    
                    Rectangle()
                        .modifier(TextFieldUnderLineRectangleModifier(stateTyping: isInFocusEmail))
                    
                    // 이메일 형식이 아닐 경우 경고 메시지
                    if !email.isEmpty && !checkEmailRule(string: email) {
                        HStack(alignment: .center, spacing: 5) {
                            Image(systemName: "exclamationmark.circle")
                            Text("올바른 이메일 형식이 아닙니다.")
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
                        if isSecuredPassword {
                            SecureField("비밀번호를 입력해주세요.", text: $password)
                                .focused($isInFocusPassword) // 커서가 올라가있을 때 상태를 저장.
                                .modifier(ClearTextFieldModifier())
                        } else { // 비밀번호 보임 아이콘일 때
                            TextField("비밀번호를 입력해주세요.", text: $password)
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
                        if !password.isEmpty && checkPasswordRule(password: password) {
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
                    if !password.isEmpty && !checkPasswordRule(password: password) {
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
                            SecureField("비밀번호를 다시 입력해 주세요.", text: $passwordCheck)
                                .focused($isInFocusPasswordCheck) // 커서가 올라가있을 때 상태를 저장.
                                .modifier(ClearTextFieldModifier())
                        } else { // 비밀번호 보임 아이콘일 때
                            TextField("비밀번호를 다시 입력해 주세요.", text: $passwordCheck)
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
                        if !passwordCheck.isEmpty && password == passwordCheck && checkPasswordRule(password: passwordCheck) {
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
                    if !passwordCheck.isEmpty && password != passwordCheck {
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
            } // VStack - 이메일, 비밀번호 TextField)
            
            Spacer()
            Divider() // 로그인 버튼 구분선
            
            // 이메일, 비밀번호 검사 후 다음 버튼을 띄운다. ( Step3: 닉네임 설정 뷰으로 넘어가기 )
            NavigationLink {
                SignUpStep2View(email: $email, password: $password, navStack: $navStack)
            } label: {
                Text("다음")
                    .modifier(MaxWidthColoredButtonModifier(cornerRadius: 15))
            } // NavigationLink - 다음
            // TextField가 비어있거나 비밀번호 2개가 다를 경우에는 "다음" 버튼 비활성화
            .disabled(email.isEmpty || password.isEmpty || passwordCheck.isEmpty || password != passwordCheck || !checkEmailRule(string: email) || !checkPasswordRule(password: password) || signUpAuthStore.emailDuplicationState != .notDuplicated ? true : false)
            
            
        } // VStack
        .background(Color.white) // 화면 밖 터치할 때 백그라운드 지정을 안 해주면 View에 올라간 요소들 클릭 시에만 적용됨.
        .onTapGesture() { // 키보드 밖 화면 터치 시 키보드 사라짐
            endEditing()
        } // onTapGesture
        .toolbar {
            ToolbarItem(placement: .principal) { // 회원가입 진행 현황 툴바
                CustomProgressView(nowStep: 2)
            } // toolbarItem
        } // toolbar
        .popup(isPresented: $isDuplicated, type: .floater(useSafeAreaInset: true), position: .top, animation: .default, autohideIn: 2, dragToDismiss: true, closeOnTap: true, closeOnTapOutside: true, view: {
            HStack {
                Image(systemName: "exclamationmark.circle")
                    .foregroundColor(.white)
                
                Text("중복되는 이메일이 존재해요.")
                    .foregroundColor(.white)
                    .font(.footnote)
                    .bold()
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            .background(Color.red)
            .cornerRadius(100)
        }) // Toast - 이메일 중복 팝업
        .popup(isPresented: $isNotDuplicated, type: .floater(useSafeAreaInset: true), position: .top, animation: .default, autohideIn: 2, dragToDismiss: true, closeOnTap: true, closeOnTapOutside: true, view: {
            HStack {
                Image(systemName: "checkmark.circle")
                    .foregroundColor(.white)
                
                Text("사용 가능한 이메일이에요.")
                    .foregroundColor(.white)
                    .font(.footnote)
                    .bold()
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            .background(Color.green)
            .cornerRadius(100)
        }) // Toast - 이메일 사용 가능 팝업
    } // Body
}


// MARK: - SignUpStep1View Previews
struct SignUpStep1View_Previews: PreviewProvider {
    static var previews: some View {
        SignUpStep1View(navStack: .constant(NavigationPath()))
    }
}

