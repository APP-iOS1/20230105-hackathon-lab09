//
//  SoohyunTest.swift
//  starcket
//
//  Created by Sue on 2023/01/06.
//

import SwiftUI

struct SoohyunTest: View {
    @EnvironmentObject var authStore: AuthStore
    @EnvironmentObject var signUpAuthStore: SignUpAuthStore
    
    var body: some View {
        VStack(spacing: 20) {
            Button {
                authStore.handleKaKaoLogin()
            } label: {
                Text("카카오 로그인")
            }
            Button {
                authStore.kakaoLogout()
            } label: {
                Text("카카오 로그아웃")
            }
            
            Button {
                authStore.googleSignIn()
            } label: {
                Text("구글 로그인")
            }
            
            Button {
                authStore.googleSignOut()
            } label: {
                Text("구글 로그아웃")
            }


        }
    }
}

struct SoohyunTest_Previews: PreviewProvider {
    static var previews: some View {
        SoohyunTest()
    }
}
