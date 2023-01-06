//
//  BucketListDetailView.swift
//  starcket
//
//  Created by 홍수만 on 2023/01/05.
//

import SwiftUI

struct BucketDetailView: View {
    
    var body: some View {
        ScrollView{
            VStack{
                VStack(alignment: .leading){
                    Text("\"해커톤 대상 받기\"의 기록 ")
                        .font(.custom("KNPSKkomi-Regular", size: 29, relativeTo: .title))
                        .foregroundColor(Color("mainColor"))
                        .padding(.bottom, 10)
                    HStack{
                        Spacer()
                        Text("2023.01.06")
                            .font(.custom("KNPSKkomi-Regular", size: 20, relativeTo: .caption))
                    }
                    
                }
                .padding(.horizontal, 40)
                
                Image("detailImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 330)
                    .padding(.bottom, 45)
                
                VStack(alignment: .leading){
                    Text("해커톤 대상을 받았어요~~!!")
                        .font(.custom("KNPSKkomi-Regular", size: 25, relativeTo: .headline))
                        .padding(.horizontal, 30)
                    
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(height: 1)
                        .padding(.horizontal, 20)
                    
                    Text("짧은 시간이었지만 팀원 모두와 함께 노력해서 대상을 수상할 수 있었어요 너무 행복해요~~!!")
                        .font(.custom("KNPSKkomi-Regular", size: 22, relativeTo: .body))
                        .padding(.horizontal, 30)
                        .padding(.vertical, 15)
                    
                }
                Spacer()
            }
            
        }
        .padding(.top, 30)
        .background{
            Color("tempBgColor")
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct BucketDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BucketDetailView()
    }
}
