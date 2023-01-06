//
//  EmailSignInView.swift
//  starcket
//
//  Created by Sue on 2023/01/06.
//

import SwiftUI
import PopupView

struct EmailSignInView: View {
    @EnvironmentObject var authStore: AuthStore
    @EnvironmentObject var signUpAuthStore: SignUpAuthStore
    @Environment(\.dismiss) private var dismiss
    
    @State var email = ""
    @State var password = ""
    @State private var loginFailed = false
    @FocusState var isInFocusEmail: Bool
    @FocusState var isInFocusPassword: Bool
    @State private var isLoggedInFailed = false
    
    // MARK: - Methods
    private func logInWithEmailPassword() {
        Task {
            await signUpAuthStore.requestUserLogin(withEmail: email, withPassword: password)
            if signUpAuthStore.currentUser?.email != nil {
                isLoggedInFailed = false
                dismiss()
                signUpAuthStore.fetchUserInfo(user: signUpAuthStore.currentUser!)

                print("로그인 성공 - 이메일: \(signUpAuthStore.currentUser?.email ?? "???")")
            } else {
                isLoggedInFailed = true
                print("로그인 실패")
            }
        }
    }
    
    
    var body: some View {
        
        VStack {
            Image("shineLoginStar")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 170)
                .padding(.bottom, 50)
            
            VStack {
                VStack(spacing: 5) {
                    TextField("이메일", text: $email)
                        .focused($isInFocusEmail)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        .font(.custom("KNPSKkomi-Regular", size: 17))
                        .foregroundColor(.black)
                    
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 1)
                
                VStack(spacing: 5) {
                    SecureField("비밀번호", text: $password)
                        .focused($isInFocusPassword)
                        .font(.custom("KNPSKkomi-Regular", size: 17))
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        .foregroundColor(.black)

                }
                .padding(.horizontal, 20)
            }
            .padding(.bottom, 70)
            //.background(.white)
            

            NavigationLink {
                ContentView()
            } label: {
                Text("로그인하기")
                    .font(.custom("KNPSKkomi-Regular", size: 23))
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .bold()
                    .background(Color("mainColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(EdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 20))
            }          
        }
        .navigationTitle("이메일 로그인")
        .accentColor(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            //                Color(hex: "FDFCED")
            Image("MilkyWay")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
        }
        .onTapGesture() { // 키보드 밖 화면 터치 시 키보드 사라짐
            endEditing()
        } // onTapGesture
//        .popup(isPresented: $isLoggedInFailed, type: .floater(useSafeAreaInset: true), position: .top, animation: .default, autohideIn: 2, dragToDismiss: true, closeOnTap: true, closeOnTapOutside: true, view: {
//            HStack {
//                Image(systemName: "exclamationmark.circle")
//                    .foregroundColor(.white)
//
//                Text("이메일 및 비밀번호를 다시 확인해주세요.")
//                    .foregroundColor(.white)
//                    .font(.footnote)
//                    .bold()
//            }
//            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
//            .background(Color.red)
//            .cornerRadius(100)
//        })
    }
}

struct EmailSignInView_Previews: PreviewProvider {
    static var previews: some View {
        EmailSignInView()
            .environmentObject(AuthStore())
            .environmentObject(SignUpAuthStore())
    }
}
