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
                .font(.custom("KNPSKkomi-Regular", size: 30))
                .bold()
                .padding(.top, 20)
                .padding(.bottom, 2)
            Text("2900원으로 아래 서비스들을 이용하실 수 있습니다.")
                .font(.custom("KNPSKkomi-Regular", size: 22))
                .padding(.bottom, 40)
            
            Image("preminumStar")
                .resizable()
                .aspectRatio(contentMode: .fit)

            VStack(alignment: .leading) {
                HStack {
                    Image("checkmark")
                        .resizable()
                        .frame(width: 36, height: 36)
                        .padding(.trailing, 10)
                    Text("다양한 별 모양 이미지")
                        .font(.custom("KNPSKkomi-Regular", size: 22))
            
                    Spacer()
                }
                .padding(.bottom, 10)
                HStack {
                    Image("checkmark")
                        .resizable()
                        .frame(width: 36, height: 36)
                        .padding(.trailing, 10)
                    Text("다양한 테마와 시즌 한정 테마")
                        .font(.custom("KNPSKkomi-Regular", size: 22))
            
                    Spacer()
                } .padding(.bottom, 10)
                
                HStack {
                    Image("checkmark")
                        .resizable()
                        .frame(width: 36, height: 36)
                        .padding(.trailing, 10)
                    Text("사진 첨부")
                        .font(.custom("KNPSKkomi-Regular", size: 22))
            
                    Spacer()
                } .padding(.bottom, 10)
                HStack {
                    Image("checkmark")
                        .resizable()
                        .frame(width: 36, height: 36)
                        .padding(.trailing, 10)
                    Text("앱 잠금 기능")
                        .font(.custom("KNPSKkomi-Regular", size: 22))
            
                    Spacer()
                } .padding(.bottom, 10)
                
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 10)
            
            
            Button {
                
            } label: {
                Text("이용 중")
                    .font(.custom("KNPSKkomi-Regular", size: 25))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .bold()
                    .background(Color.secondary)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(EdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 20))
                    .padding(.bottom, 30)
            }
            .disabled(true)
            
            
            Spacer()
                
        }
    }
}

struct PurchasePremiumView_Previews: PreviewProvider {
    static var previews: some View {
        PurchasePremiumView()
    }
}
