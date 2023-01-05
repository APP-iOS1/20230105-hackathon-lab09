//
//  PurchasePremiumView.swift
//  starcket
//
//  Created by Sue on 2023/01/05.
//

import SwiftUI

struct PurchasePremiumView: View {
    var body: some View {
        //List
        VStack {
            Text("별킷리스트 Premium을 경험해보세요")
                .font(.custom("Pretendard-ExtraBold", size: 22))
                .bold()
                .padding(.bottom, 50)
                .padding(.top, 20)

            
            Image(systemName: "star.fill")
                .resizable()
                .foregroundColor(.yellow)
                .frame(width: 180, height: 180)
                .padding(.bottom, 30)
            Text("프리밈엄 혜택")
                .font(.custom("Pretendard-Light", size: 17))
                .bold()
                .padding(.bottom, 40)
            VStack(alignment: .leading) {
                HStack {
                    Image("checkmark")
                        .resizable()
                        .frame(width: 43, height: 43)
                        .padding(.trailing, 10)
                    Text("다양한 별 모양 이미지")
                        .font(.custom("Pretendard-ExtraBold", size: 20))
            
                    Spacer()
                }
                .padding(.bottom, 10)
                HStack {
                    Image("checkmark")
                        .resizable()
                        .frame(width: 43, height: 43)
                        .padding(.trailing, 10)
                    Text("다양한 테마와 시즌 한정 테마")
                        .font(.custom("Pretendard-ExtraBold", size: 20))
            
                    Spacer()
                } .padding(.bottom, 10)
                
                HStack {
                    Image("checkmark")
                        .resizable()
                        .frame(width: 43, height: 43)
                        .padding(.trailing, 10)
                    Text("사진 첨부")
                        .font(.custom("Pretendard-ExtraBold", size: 20))
            
                    Spacer()
                } .padding(.bottom, 10)
                HStack {
                    Image("checkmark")
                        .resizable()
                        .frame(width: 43, height: 43)
                        .padding(.trailing, 10)
                    Text("앱 잠금 기능")
                        .font(.custom("Pretendard-ExtraBold", size: 20))
            
                    Spacer()
                } .padding(.bottom, 10)
                
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 10)
            
            
            Button {
                
            } label: {
                Text("₩ 2,900")
                    //.modifier(MaxWidthColoredButtonModifier(cornerRadius: 15))
            }
            
            Spacer()
                
        }
    }
}

struct PurchasePremiumView_Previews: PreviewProvider {
    static var previews: some View {
        PurchasePremiumView()
    }
}
