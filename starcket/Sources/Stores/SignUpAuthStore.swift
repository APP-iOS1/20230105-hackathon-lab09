//
//  SignUpAuthStore.swift
//  starcket
//
//  Created by Sue on 2023/01/05.
//
import Foundation
import FirebaseFirestore
import Firebase

enum AuthenticationState {
    case unauthenticated
    case authenticating
    case authenticated
}

enum LoginRequestState {
    case loggingIn
    case loggedIn
    case notLoggedIn
}

enum EmailDuplicationState {
    case checking
    case duplicated
    case notDuplicated
}

enum NickNamelDuplicationState {
    case checking
    case duplicated
    case notDuplicated
}

class SignUpAuthStore: ObservableObject {
    @Published var errorMessage = ""
    @Published var authenticationState: AuthenticationState = .unauthenticated
    @Published var loginRequestState: LoginRequestState = .notLoggedIn
    @Published var emailDuplicationState: EmailDuplicationState = .duplicated // 중복한다고 전제
    @Published var nickNameDuplicationState: NickNamelDuplicationState = .duplicated // 중복한다고 전제
    @Published var currentUser: User?
//    var credential: AuthCredential

    let database = Firestore.firestore()
    let authentification = Auth.auth()
    var authStore = AuthStore.shared
    
    
    
    // MARK: - Create New Customer(user)
    /// Auth에 새로운 사용자를 생성합니다.
    /// - Parameter email: 입력받은 사용자의 email
    /// - Parameter password: 입력받은 사용자의 password
    /// - Parameter nickname: 입력받은 사용자의 nickname
    @MainActor
    func createUser(email: String, password: String, nickname: String) async -> Bool {
        authenticationState = .authenticating
        do  {
            try await authentification.createUser(withEmail: email, password: password)
            print("account created.")
            errorMessage = ""
            authenticationState = .authenticated
            // firestore에 user 등록
            let currentUserId = authentification.currentUser?.uid ?? ""
            registerUser(uid: currentUserId, email: email, nickname: nickname)
            return true
        }
        catch {
            print(error.localizedDescription)
            errorMessage = error.localizedDescription
            authenticationState = .unauthenticated
            return false
        }
    }
    
    // MARK: - Register Customer(user) in Firestore
    /// Auth에 새롭게 만든 사용자 정보를 Firestore에 등록합니다.
    /// - Parameter uid: 현재 사용자의 Auth uid
    /// - Parameter email: 현재 사용자의 email
    /// - Parameter nickname: 현재 사용자의 nickname
    func registerUser(uid: String, email: String, nickname: String) {
        database.collection("User")
            .document(uid)
            .setData([
                "id" : uid,
                "bucketId": [],
                "detailId": [],
                "name" : nickname,
                "email" : email,
                "isPremium": true
            ])
    }
    
    // MARK: - 이메일 중복 검사
    /// 사용자가 입력한 이메일이 이미 사용하고 있는지 검사합니다.
    /// 입력받은 이메일이 DB에 이미 있다면 false를, 그렇지 않다면 true를 반환합니다.
    /// - Parameter currentUserEmail: 입력받은 사용자 이메일
    /// - Returns: 중복된 이메일이 있는지에 대한 Boolean 값
    @MainActor
    func isEmailDuplicated(currentUserEmail: String) async -> Bool {
        emailDuplicationState = .checking
        do {
            let document = try await database.collection("User")
                .whereField("email", isEqualTo: currentUserEmail)
                .getDocuments()
            emailDuplicationState = document.isEmpty ? .notDuplicated : .duplicated
            return !(document.isEmpty)
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    // MARK: - 닉네임 중복 검사
    /// 사용자가 입력한 닉네임이 이미 사용하고 있는지 검사합니다.
    /// 입력받은 닉네임이 DB에 이미 있다면 false를, 그렇지 않다면 true를 반환합니다.
    /// - Parameter currentUserNickname: 입력받은 사용자 닉네임
    /// - Returns: 중복된 닉네임이 있는지에 대한 Boolean 값
    @MainActor
    func isNicknameDuplicated(currentUserNickname: String) async -> Bool {
        nickNameDuplicationState = .checking
        do {
            let document = try await database.collection("User")
                .whereField("name", isEqualTo: currentUserNickname)
                .getDocuments()
            nickNameDuplicationState = document.isEmpty ? .notDuplicated : .duplicated
            return !(document.isEmpty)
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    // MARK: - Login
    @MainActor
    public func requestUserLogin(withEmail email: String, withPassword password: String) async -> Void {
        loginRequestState = .loggingIn //로그인 중

        do {
            loginRequestState = .loggedIn
            try await authentification.signIn(withEmail: email, password: password)
            // 현재 로그인 한 유저의 정보 담아주는 코드
            // 변경이 필요함!
            let userNickname = await requestUserNickname(uid: authentification.currentUser?.uid ?? "")
            authStore.loginPlatform = .email
            self.currentUser = User(id: self.authentification.currentUser?.uid ?? "", bucketId: [], detailId: [], name: userNickname, email: email, isPremium: true)
            UserDefaults.standard.set(self.authentification.currentUser?.uid, forKey: "userIdToken")
            //print("userIdToken \(self.authentification.currentUser?.uid)")
            print("userNickname: \(userNickname)")
        } catch {
            loginRequestState = .notLoggedIn
            dump("DEBUG : LOGIN FAILED \(error.localizedDescription)")
        }
        authenticationState = .authenticated
    }
    
    // MARK: - User Logout
    /// 로그인한 사용자의 로그아웃을 요청합니다.
    public func requestUserSignOut() {
        do {
            try authentification.signOut()
            loginRequestState = .notLoggedIn
            authStore.state = .signOut
            // 로컬에 있는 CustomerInfo 구조체의 객체를 날림
            self.currentUser = nil
        } catch {
            dump("DEBUG : LOG OUT FAILED \(error.localizedDescription)")
        }
    }
    
    // MARK: - request Nickname
    /// uid 값을 통해 database의 특정 uid에 저장된 userNickname을 요청합니다.
    ///  - Parameter uid : currentUser의 UID
    ///  - Returns : currentUser의 userNickname
    private func requestUserNickname(uid: String) async -> String {
        var retValue = ""
//        print("requestUserNickname 1")
        return await withCheckedContinuation({ continuation in
            database.collection("User").document(uid).getDocument { (document, error) in
                if let document = document, document.exists {
                    retValue = document.get("name") as! String
//                    print("requestUserNickname 2: \(retValue)")
                    continuation.resume(returning: retValue)
                } else {
                    print("2-")
                    continuation.resume(throwing: error as! Never)
                }
            }
        })
    }
    
    // MARK: - 회원정보 업데이트 (주소, 연락처)
    ///  - Parameter userAddress : 새로 입력한 주소
    ///  - Parameter phoneNumber : 새로 입력한 연락처
    ///  - Parameter user : 로그인한 유저의 객체 (CustomerInfo)
    ///  - firestore 반영: updateData 메소드를 이용하여 firestore에 정보를 업데이트한다.
    ///  - 로컬반영: 로컬에 있는 currentUser 객체를 재생성(초기화)하여 정보를 업데이트함
    func updateUserInfo(name: String, user: User) {
        database.collection("User")
            .document(user.id).updateData([
                "name" : name
            ]) { err in
                if let err = err {
                    print("회원정보 수정 오류: \(err)")
                } else {
                    print("회원정보 수정 완료")
                    self.currentUser = User(id: self.authentification.currentUser?.uid ?? "", bucketId: self.currentUser?.bucketId ?? [], detailId: self.currentUser?.detailId ?? [], name: name, email: self.currentUser?.email ?? "", isPremium: true)
                }
            }
    }
    
    // MARK: - FireStore의 유저정보 fetch
    ///  - Parameter user : 로그인한 유저의 객체 (CustomerInfo)
    ///  - 로그인 시 firestore에 저장된 유저 정보를 currentUser에 할당한다.
    func fetchUserInfo(user: User) {
        database.collection("User").getDocuments { snapshot, error in
            if let snapshot {
                
                for document in snapshot.documents {
                    let id : String = document.documentID
                    let docData = document.data()

                    if id == user.id {
                        
                       
                        let bucketId: [String] = docData["bucketId"] as? [String] ?? []
                        let detailId: [String] = docData["detailId"] as? [String] ?? []
                        let name: String = docData["name"] as? String ?? ""
                        let email: String = docData["email"] as? String ?? ""
                        let isPremium: Bool = docData["isPremium"] as? Bool ?? true
                       
                        self.currentUser = User(id: id, bucketId: bucketId, detailId: detailId, name: name, email: email, isPremium: isPremium)

                        print(self.currentUser!)
                    }
                }
                
            }
        }
    }
    // MARK: - 비밀번호 업데이트
    ///  - Parameter password : 변경하려는 비밀번호
    ///  - Auth에 접근하여 비밀번호를 업데이트한다
    func updatePassword(password: String) {
        authentification.currentUser?.updatePassword(to: password) { err in
            if let err = err {
                print("password update error: \(err)")
            } else {
                print("password update")
            }
        }
    }


    // MARK: - 로그인 메소드를 사용하여 비밀번호 체크
    ///  - Parameter email : 로그인 시 사용하는 이메일
    ///  - Parameter password : 로그인 시 사용하는 비밀번호
    ///  - Returns : 로그인 성공 유무에 따라 Bool값을 return
    public func reAuthLoginIn(withEmail email: String, withPassword password: String) async -> Bool {
        print("email: \(email), pw: \(password)")
        
        do {
            try await authentification.signIn(withEmail: email, password: password)
            
            return true
        } catch(let error) {
            dump("error: \(error)")
            
            return false
        }
    }

    
}
