//
//  MoreView.swift
//  starcket
//
//  Created by Sue on 2023/01/05.
//

import SwiftUI

struct MoreView: View {
    @State private var showingSheet = false
    
    var body: some View {
        List {
            Button {
                
            } label: {
                Text("의견 보내기")
            }
            
            
            Button {
                
            } label: {
                Text("이용약관 및 개인정보처리 방침 ")
            }
            
            Button {
                
            } label: {
                Text("오픈소스 라이선스")
            }

        }.listStyle(.plain)
    }
}

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView()
    }
}
