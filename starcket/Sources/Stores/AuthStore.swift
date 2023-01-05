//
//  AuthStore.swift
//  starcket
//
//  Created by Sue on 2023/01/05.
//

import Foundation
import Combine
import Firebase
import FirebaseAuth
import GoogleSignIn // 구글 로그인
//import KakaoSDKAuth
//import KakaoSDKUser


/*
 1. UserStore 만들고 회원가입 시 user에 대한 코드 수정 필요
 2. 로그아웃(이메일,구글,카카오)에 대해서 SignInState, LogInState 어떻게 할지 정리 필요
 */

// 로그인 상태
enum SignInState {
    case splash
    case signIn
    case signOut
}

// 로그인 성공 여부
enum LogInState {
    case success
    case fail
    case none
}
// 로그인한 플랫폼
enum LoginPlatform {
    case email
    case google
    case kakao
    case none // 얘가 있어야할지 없어야할지 잘 모르겠지만 일단,,
}

class AuthStore: ObservableObject {
    
    static let shared = AuthStore() //싱글톤
    
    //인증 상태를 관리하는 변수
    @Published var state: SignInState = .splash // 로그인 상태
    @Published var loginState: LogInState = .none //로그인 성공 여부
    @Published var loginPlatform: LoginPlatform = .none
    
    //let userVM: UserViewModel = UserViewModel()
    
    //MARK: - 이메일 로그인
    //이메일 계정 생성 (회원가입)
    func emailCreateUser(email: String, password: String, phoneNumber: String, nickName: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
                return
            }
            guard let authUser = result?.user.uid else { return }
            
//            let user: User = User(id: authUser, name: nickName, email: email, phoneNumber: phoneNumber, image: "", myRegisterStore: [], myReview: [], bookmark: [], isAlert: false)

            //print("Successfully created account with ID: \(result?.user.uid ?? "")")
            //print("type: \(type(of: result?.user.uid))") Optional<String>
            
            // 이제 이걸 UserViewModel에도 넣어줘야 하는데...
            //self.userVM.addUser(user)
        }
    }
    
    // 이메일 로그인
    func emailLoginUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed due to error:", err)
                self.loginState = .fail
                return
            }
            // 이메일 로그인 성공 시
            self.loginState = .success //로그인 성공 여부
            print("Successfully logged in with ID: \(result?.user.uid ?? "")")
            // UserDefaults에 저장
            UserDefaults.standard.set(result?.user.uid, forKey: "userIdToken")
            
        }
    }
    
    // 이메일 로그아웃
    func emailLogout() {
        try? Auth.auth().signOut()
        self.state = .signOut
        self.loginState = .none

    }
    
    // 비밀번호 재설정
    func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { err in
            if let err = err {
                print("err : \(err)")
                return
            }
        }
    }
    // 이메일 정규 표현식 확인
    func checkEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return  NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
     
    
    // 영문, 숫자, 특수문자를 포함하여 최소 8자리 이상으로 구성되어야 함
    func checkPasswordRule(password : String) -> Bool {
        let regExp = "^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!?@#$%^&*()_+=-]).{8,16}$"
        return password.range(of: regExp, options: .regularExpression) != nil
    }
    
    //MARK: - 구글 로그인
    // 구글 로그인
    func googleSignIn() {
        // 한번 로그인한 적이 있음
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            // 있으면 복원 (yes then restore)
            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
                authenticateUser(for: user, with: error)
                
            }
        } else {// 처음 로그인
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
            
            let configuration = GIDConfiguration(clientID: clientID)
            
            // 맨 위에 뜨게 하도록
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            guard let rootViewController = windowScene.windows.first?.rootViewController else { return }

            GIDSignIn.sharedInstance.configuration = configuration
            GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [unowned self] result, error in
                guard let user = result?.user else { return }
                authenticateUser(for: user, with: error)
                
            }
            
        }
    }
    
    
    private func authenticateUser(for user: GIDGoogleUser?, with error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }

        guard let accessToken = user?.accessToken, let idToken = user?.idToken else {return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
        
        // 3
        Auth.auth().signIn(with: credential) { [unowned self] (result, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                UserDefaults.standard.set(result?.user.uid, forKey: "userIdToken")
                // 이메일 로그인 성공 시
                self.loginState = .success //로그인 성공 여부
                self.state = .signIn // 로그인 상태
            }
        }
    }
    
    // 로그아웃
    func googleSignOut() {
        
        GIDSignIn.sharedInstance.signOut()
        
        do {
            
            try Auth.auth().signOut()
             
            state = .signOut // 로그인 상태
            loginState = .none //로그인 성공 여부 다시 초기화
            
        } catch {
            print(error.localizedDescription)
        }
    }

    
    
}
