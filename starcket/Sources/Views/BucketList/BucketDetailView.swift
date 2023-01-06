//
//  BucketListDetailView.swift
//  starcket
//
//  Created by 홍수만 on 2023/01/05.
//

import SwiftUI

struct BucketDetailView: View {
    @StateObject var bucketDetailStore = BucketDetailStore()
    
    var body: some View {
        ScrollView{
            VStack{
                VStack(alignment: .leading){
                    Text("DetailViewTitle")
                    //                .font(.custom("Pretendard-Bold", size: 23))
                        .font(.system(size: 25, weight: .bold))
                    HStack{
                        Spacer()
                        Text("didAt")
                            .font(.system(size: 20, weight: .regular))
                    }
                    
                }
                .padding(.horizontal, 40)
                
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 330)
                    .padding(.bottom, 45)
                
                VStack(alignment: .leading){
                    Text("Detail Title")
                        .font(.system(size: 25, weight: .bold))
                        .padding(.horizontal, 30)
                    
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(height: 1)
                        .padding(.horizontal, 20)
                    
                    Text("Detail Content")
                        .font(.system(size: 20, weight: .bold))
                        .padding(.horizontal, 30)
                    
                }
                Spacer()
            }
        }
        .padding(.top, 30)
        .background{
            Color("tempBgColor")
                .edgesIgnoringSafeArea(.all)
        }
        .onAppear{
            
        }
    }
}

struct BucketDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BucketDetailView()
    }
}
