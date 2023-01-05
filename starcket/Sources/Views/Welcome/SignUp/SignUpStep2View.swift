//
//  SignUpStep2View.swift
//  big-project-a-customer-ios
//
//  Created by geonhyeong on 2022/12/27.
//

import SwiftUI
import PopupView


// MARK: - SignUpStep2View
///닉네임을 설정하는 View 입니다.
struct SignUpStep2View: View {
    
    // MARK: - Property Wrappers
    @Environment(\.dismiss) private var dismiss
    @Binding var email: String
    @Binding var password: String
    @State var nickName = ""
    @FocusState var isInFocusNickName: Bool
    @State private var isShowSucceedToast = false
    @State private var isDuplicated = false
    @State private var isNotDuplicated = false
    @Binding var navStack: NavigationPath
    
    @EnvironmentObject var signUpAuthStore: SignUpAuthStore
    
    
    // MARK: - Methods
    // Firebase Authentication에 계정을 생성하고 성공 유무를 isSucceedSignUp에 담는 함수입니다.
    private func signUpWithEmailPassword() {
        Task {
            if await signUpAuthStore.createUser(email: email, password: password, nickname: nickName) {
                navStack = .init() // 루트뷰(로그인뷰)로 돌아가기
                print("회원가입 성공")
            } else {
                print("회원가입 실패")
            }
        }
    }

    // 닉네임 중복을 검사하는 함수입니다.
    func checkNicknameDuplicated() {
        Task {
            if await signUpAuthStore.isNicknameDuplicated(currentUserNickname: nickName) {
                // 이메일이 중복될 경우
                isDuplicated = true
                isNotDuplicated = false
            } else {
                isDuplicated = false
                isNotDuplicated = true
            }
        }
    }

    
    
    // MARK: - Body SignUpStep2View
    /// SignUpStep2View의 body 입니다.
    var body: some View {

        VStack {
            HStack {
                Text("닉네임을\n입력해 주세요.")
                    .font(.title2)
                Spacer()
            } // HStack 입력 안내문구
            .padding(EdgeInsets(top: 30, leading: 15, bottom: 40, trailing: 15))
            
            VStack(spacing: 5) {
                HStack {
                    TextField("닉네임 (20자리 이내)", text: $nickName)
                        .focused($isInFocusNickName)
                        .modifier(ClearTextFieldModifier())
                        .onChange(of: nickName) { newValue in
                            signUpAuthStore.nickNameDuplicationState = .duplicated
                        }
                    
                    // email 필드가 비어있지 않으면서 정규식에 적합한다면
                    if !nickName.isEmpty {
                        // 이메일 중복검사
                        // 중복확인 버튼을 띄우고 사용 가능하다면 체크 아이콘 띄우고, 아니면 버튼 유지
                        if signUpAuthStore.nickNameDuplicationState == .duplicated {
                            Button {
                                checkNicknameDuplicated()
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
                        } else if signUpAuthStore.nickNameDuplicationState == .checking{
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
                } // HStack
                .frame(height: 30) // TextField가 있는 HStack의 height 고정 <- 아이콘 크기 변경 방지
                .padding(.trailing, 20)
                
                Rectangle()
                    .modifier(TextFieldUnderLineRectangleModifier(stateTyping: isInFocusNickName))
            } // VStack TextField 닉네임
            
            Spacer()
            Divider() // 로그인 버튼 구분선
            
            Button {
                // 앞서 입력한 이메일과 비밀번호로 Firebase Auth에 계정을 생성하고 사용자 정보 문서(이메일, 닉네임)가 생성되어야 함.
                Task {
                    if signUpAuthStore.nickNameDuplicationState == .notDuplicated {
                        // 이메일이나 닉네임이 중복되지 않을 경우
                        isShowSucceedToast.toggle()
                        signUpWithEmailPassword()
                    } else {
                        // 닉네임이 중복될 경우
                        checkNicknameDuplicated()
                    }
                }
            } label: {
                // 비동기 작업이 끝나기 전까지(작업 중)는 ProgressView를 띄워서 회원가입 버튼을 없앤다.
                if signUpAuthStore.authenticationState == .authenticating {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .black))
                        .frame(height: 40)
                } else { // 계정 생성 전이나 후에는 버튼을 띄운다.
                    Text("회원가입")
                        .modifier(MaxWidthColoredButtonModifier(cornerRadius: 15))
                }
            }
            // TextField가 비어있으면 "회원가입" 버튼 비활성화
            .disabled(nickName.isEmpty || nickName.count > 20 || signUpAuthStore.nickNameDuplicationState != .notDuplicated ? true : false)
        } // VStack
        .background(Color.white) // 화면 밖 터치할 때 백그라운드 지정을 안 해주면 View에 올라간 요소들 클릭 시에만 적용됨.
        .onTapGesture() { // 키보드 밖 화면 터치 시 키보드 사라짐
            endEditing()
        } // onTapGesture
        .toolbar {
            ToolbarItem(placement: .principal) { // 회원가입 진행 현황 툴바
                CustomProgressView(nowStep: 3)
            } // toolbarItem
        } // toolbar
        .popup(isPresented: $isShowSucceedToast, type: .floater(useSafeAreaInset: true), position: .top, animation: .default, autohideIn: 2, dragToDismiss: true, closeOnTap: true, closeOnTapOutside: true, view: {
            HStack {
                Image(systemName: "checkmark.circle")
                    .foregroundColor(.white)
                
                Text("회원가입이 성공적으로 완료되었습니다.")
                    .foregroundColor(.white)
                    .font(.footnote)
                    .bold()
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            .background(Color.accentColor)
            .cornerRadius(100)
        }) // Toast - 회원가입 성공 팝업
        .popup(isPresented: $isDuplicated, type: .floater(useSafeAreaInset: true), position: .top, animation: .default, autohideIn: 2, dragToDismiss: true, closeOnTap: true, closeOnTapOutside: true, view: {
            HStack {
                Image(systemName: "exclamationmark.circle")
                    .foregroundColor(.white)
                
                Text("중복되는 닉네임이 존재해요.")
                    .foregroundColor(.white)
                    .font(.footnote)
                    .bold()
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            .background(Color.red)
            .cornerRadius(100)
        }) // Toast - 닉네임 중복 팝업
        .popup(isPresented: $isNotDuplicated, type: .floater(useSafeAreaInset: true), position: .top, animation: .default, autohideIn: 2, dragToDismiss: true, closeOnTap: true, closeOnTapOutside: true, view: {
            HStack {
                Image(systemName: "checkmark.circle")
                    .foregroundColor(.white)
                
                Text("사용 가능한 닉네임이에요.")
                    .foregroundColor(.white)
                    .font(.footnote)
                    .bold()
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            .background(Color.green)
            .cornerRadius(100)
        }) // Toast - 닉네임 사용 가능 팝업

    } // Body
}


struct SignUpStep2View_Previews: PreviewProvider {
    static var previews: some View {
        SignUpStep2View(email: .constant(""), password: .constant(""), navStack: .constant(NavigationPath()))
            .environmentObject(SignUpAuthStore())
    }
}
