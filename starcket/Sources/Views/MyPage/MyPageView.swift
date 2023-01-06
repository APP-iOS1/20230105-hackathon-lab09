//
//  MyPageView.swift
//  starcket
//
//  Created by geonhyeong on 2023/01/05.
//

import SwiftUI
import FirebaseFirestore
import Firebase

struct MyPageView: View {
    @State var faceIDToggle: Bool = false
    @State var darkmodeToggle: Bool = false
    @State var pushNotiToggle: Bool = false
    @State var logOutAlert: Bool = false
    
    @EnvironmentObject var authStore: AuthStore // 구글,카카오
    @EnvironmentObject var signUpAuthStore: SignUpAuthStore //이메일
    
    
    //이거 여구름, 이메일 정리하고 나서 실제로 연결시켜서 보여줘야함
    //회원정보 수정도 해야함
    var body: some View {
        NavigationStack {
            List {
                Section ("👤 PROFILE") {
                    NavigationLink {
                        EditProfileView()
                    } label: {
                        HStack {
                            Image("star")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:55)
                            VStack (alignment: .leading, spacing: 5) {
                                Spacer()
                                Text("여구름") // MARK: 데이터 연동 필요
                                    .bold()
                                Text("hihistar@naver.com") // MARK: 데이터 연동 필요
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                        }
                        
                    }
                }

                Section ("⚙️ SETTINGS") {
                    HStack{
                        Text("Face ID")
                        Toggle(isOn: $faceIDToggle) { }
                    }
                    HStack {
                        Text("다크 모드")
                        Toggle(isOn: $darkmodeToggle) { }
                    }//hstack
                    HStack {
                        Text("푸시 알림")
                        Toggle(isOn: $pushNotiToggle) { }
                    }//hstack
                    
                    NavigationLink {
                        PurchasePremiumView()
                    } label: {
                        Text("프리미엄 구매")
                    }
                } // setting section
                
                Section("📄 OTHERS") {
                    NavigationLink {
                        MoreView()
                    } label: {
                        Text("기타")
                    }
                    
                }
                
                Section ("🚪 ACCOUNT") {
//                    NavigationLink {
//                        EditProfileView()
//                    } label: {
//                        Text("회원정보 수정")
//                    }
                    //로그아웃 -> alert 로그아웃 하시겠습니까?
                    Button {
                        logOutAlert.toggle()
                    } label: {
                        Text("로그아웃")
                            .foregroundColor(.red)

                    }
                } // setting section
                


            }
            .listStyle(GroupedListStyle())
        }
        .onAppear {
            print("email : \(signUpAuthStore.currentUser?.email)")
            print("name : \(signUpAuthStore.currentUser?.name)")
        }
        .alert("", isPresented: $logOutAlert) {
       
               
                Button("Yes", role: .destructive) {
                    // 소셜 로그인
                    // 이메일로그인
                    signUpAuthStore.requestUserSignOut()
                    authStore.kakaoLogout()
                    authStore.googleSignOut()
                }
   
        } message: {
            Text("로그아웃 하시겠어요?")

        }

    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
            .environmentObject(AuthStore())
            .environmentObject(SignUpAuthStore())
    }
}
