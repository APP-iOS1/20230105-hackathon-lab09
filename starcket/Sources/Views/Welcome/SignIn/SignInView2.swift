//
//  SignInView2.swift
//  starcket
//
//  Created by Sue on 2023/01/06.
//

//GrayBackgroundTextFieldModifier
import SwiftUI
struct SignInView2: View {
    @EnvironmentObject var authStore: AuthStore
    @EnvironmentObject var signUpAuthStore: SignUpAuthStore
    @Environment(\.dismiss) private var dismiss
    
    @State var navStack = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navStack) {
            VStack (spacing: 0) {
                Image("shineLoginStar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 170)
                
                Text("별킷리스트")
                    .foregroundColor(.white)
                    .font(.custom("KNPSKkomi-Regular", size: 45))
                    .padding(.bottom, 100)
                
                //                .padding(.bottom, 20)
                VStack (spacing: 20)  {
                    
                    NavigationLink {
                        EmailSignInView()
                    } label: {
                        Text("이메일로 시작하기")
                            .font(.custom("KNPSKkomi-Regular", size: 23))
                            .frame(width: 350, height: 50)
                            .background(.white)
                            .cornerRadius(15)
                            .foregroundColor(.black)
                        
                    }

                    /*
                     Text("다음")
                     .font(.title3)
                     .padding(EdgeInsets(top: 10, leading: 150, bottom: 10, trailing: 150))
                     .background(.blue)
                     .cornerRadius(14)
                     .foregroundColor(.white)
                     */
                    Button {
                        authStore.handleKaKaoLogin()
                    } label: {
                        Text("카카오톡 계정으로 시작하기")
                            .font(.custom("KNPSKkomi-Regular", size: 23))
                            .frame(width: 350, height: 50)
                            .background(Color(red: 1.0, green: 0.894, blue: 0.0))
                            .cornerRadius(15)
                            .foregroundColor(Color(red: 0.246, green: 0.113, blue: 0.113))
                        
  
                    }
                    
                    Button {
                        authStore.googleSignIn()
                    } label: {
                        Text("구글 계정으로 시작하기")
                            .font(.custom("KNPSKkomi-Regular", size: 23))
                            .frame(width: 350, height: 50)
                            .background(Color(red: 0.201, green: 0.507, blue: 0.939))
                            .cornerRadius(15)
                            .foregroundColor(.white)
                        
                    }// 구글 계정으로 로그인
                    
                    
                    HStack {
                        Text("아직 계정이 없으신가요?")
                            .font(.custom("KNPSKkomi-Regular", size: 22))
                            .foregroundColor(.white)
                        
                        NavigationLink(value: "") {
                            Text("회원가입")
                                .foregroundColor(.white)
                                .font(.custom("KNPSKkomi-Regular", size: 22))
                                .foregroundColor(.accentColor)
                        }
                        .navigationDestination(for: String.self) { value in
                            // Going to SignupView
                            SignUpView(navStack: $navStack)
                        }
                        //.navigationBarBackButtonHidden(true)
                    } // HStack - 회원가입
                    .padding(.top, 30)
                    
                }
                
            }
            
            //        .frame(width: Screen.maxWidth, height: Screen.maxHeight)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                //                Color(hex: "FDFCED")
                Image("MilkyWay")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
            }
        }.accentColor(.white)
    }
}

struct SignInView2_Previews: PreviewProvider {
    static var previews: some View {
        SignInView2()
            .environmentObject(AuthStore())
            .environmentObject(SignUpAuthStore())
    }
}

