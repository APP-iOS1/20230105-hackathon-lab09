//
//  SignInView.swift
//  starcket
//
//  Created by geonhyeong on 2023/01/05.
//

import SwiftUI
import PopupView

struct SignInView: View {
    
    @EnvironmentObject var authStore: AuthStore
    
    @State var navStack = NavigationPath()
    @State var email = ""
    @State var password = ""
    
    //텍스트 필드에 커서가 올라가 있는 상태를 저장
    //
    @FocusState var isInFocusEmail: Bool
    @FocusState var isInFocusPassword: Bool
    @State private var loginFailed = false

    @State private var isLoggedInFailed = false
    
    @State var testToggle: Bool = false
    // MARK: - Methods
    private func logInWithEmailPassword() {
        Task {
            await authStore.requestUserLogin(withEmail: email, withPassword: password)
            if authStore.currentUser?.userEmail != nil {
                isLoggedInFailed = false
                dismiss()
                authStore.fetchUserInfo(user: signupViewModel.currentUser!)

                print("로그인 성공 - 이메일: \(signUpViewModel.currentUser?.userEmail ?? "???")")
            } else {
                isLoggedInFailed = true
                print("로그인 실패")
            }
        }
    }

    
    var body: some View {
        NavigationStack(path: $navStack) {
            VStack {
                HStack {
                    Text("로그인")
                        .bold()
                        .font(.title)
                    Spacer()
                } // HStack - 로그인 text
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 0))
                
                Spacer()
                
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Image(systemName: "globe")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60)
                            .foregroundColor(.accentColor)
                            .padding(.bottom, 20)
                        Text("안녕하세요.\n전자상점입니다.")
                            .font(.title3)
                            .bold()
                        Text("회원 서비스 이용을 위해 로그인 해주세요.")
                            .font(.footnote)
                    } // VStack - 안내문구 text
                    Spacer()
                } // HStack - 안내문구 Vstack
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 80, trailing: 20))
            
                VStack {
                    VStack(spacing: 5) {
                        TextField("이메일", text: $email)
                            .focused($isInFocusEmail)
                            .modifier(ClearTextFieldModifier())
                            .font(.subheadline)
                        Rectangle()
                            .modifier(TextFieldUnderLineRectangleModifier(stateTyping: isInFocusEmail))
                    }
                    .padding(.bottom, 35)
                    
                    VStack(spacing: 5) {
                        SecureField("비밀번호", text: $password)
                            .focused($isInFocusPassword)
                            .modifier(ClearTextFieldModifier())
                            .font(.subheadline)
                        Rectangle()
                            .modifier(TextFieldUnderLineRectangleModifier(stateTyping: isInFocusPassword))
                    }
                } // VStack - 이메일, 비밀번호 TextField
                
                HStack {
                    Text("아직 계정이 없으신가요?")
                        .font(.footnote)

                    NavigationLink(value: "") {
                        Text("회원가입")
                            .font(.footnote)
                            .foregroundColor(.accentColor)
                    }
                    .navigationDestination(for: String.self) { value in
                        // Going to SignupView
                       // SignUpView(navStack: $navStack)
                    }
                    .navigationBarBackButtonHidden(true)
                } // HStack - 회원가입
                .padding(.top, 30)
                
                
                Spacer()
                Spacer()
                Spacer()
                
                Divider() // 로그인 버튼 구분선
                
                Button {
                    // Login action with firebase...
                    authStore.emailLoginUser(email: email, password: password)
                    testToggle.toggle()

                } label: {
                    Text("로그인하기")
                        .modifier(MaxWidthColoredButtonModifier(cornerRadius: 15))
                }
         
                
            } // VStack - body 바로 아래
            .background(Color.white) // 화면 밖 터치할 때 백그라운드 지정을 안 해주면 View에 올라간 요소들 클릭 시에만 적용됨.
            .onTapGesture() { // 키보드 밖 화면 터치 시 키보드 사라짐
                endEditing()
            } // onTapGesture
            .popup(isPresented: $testToggle, type: .floater(useSafeAreaInset: true), position: .top, animation: .default, autohideIn: 2, dragToDismiss: true, closeOnTap: true, closeOnTapOutside: true, view: {
                HStack {
                    Image(systemName: "exclamationmark.circle")
                        .foregroundColor(.white)
                    
                    Text("이메일 및 비밀번호를 다시 확인해주세요.")
                        .foregroundColor(.white)
                        .font(.footnote)
                        .bold()
                }
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                .background(Color.red)
                .cornerRadius(100)
            }) // Toast
        }
        
        
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .environmentObject(AuthStore())
    }
}


// MARK: - Extension View
/// 키보드 밖 화면 터치 시 키보드 사라지는 함수를 선언하기 위한 extension 입니다.
extension View {
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
