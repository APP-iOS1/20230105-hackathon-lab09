//
//  BucketDetailListView.swift
//  starcket
//
//  Created by 이지연 on 2023/01/05.
//

import SwiftUI

struct BucketDetailListView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var bucketDetailStore = BucketDetailStore()
    @StateObject var bucketStore: BucketStore
    var detailIdList: [String]
    var bucketId: String
    @Binding var year: Int
    var isCheck: Bool
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    ForEach(bucketDetailStore.bucketDetail, id: \.id) { bucket in
                        NavigationLink {
                            Text("gd")
                        } label: {
                            
                            HStack(alignment: .bottom) {
                                Text(bucket.title)
                                    .font(.custom("KNPSKkomi-Regular", size: 20))
                                Spacer()
                                Text("\(bucket.createdDate)")
                                    .font(.custom("KNPSKkomi-Regular", size: 14))
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal, Screen.maxWidth * 0.06)
                            .frame(width: Screen.maxWidth * 0.87, height: Screen.maxHeight * 0.09, alignment: .leading)
                            .background {
                                Color("cellColor")
                            }
                            .cornerRadius(20)
                            .padding(.top, Screen.maxWidth * 0.07)
                        }
                        
                    }
                    
                }

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                //                Color(hex: "FDFCED")
                Color("bgColor")
            }// ScrollView
            
            Button {
                bucketStore.isLoading = true
                Task {
                    bucketStore.completedBucket(bucketId, true)
                    (bucketStore.bucket, bucketStore.bucketIdList) = try await bucketStore.fetchBucketByDate(String(year))
                    bucketStore.isLoading = false
                }
            } label: {
                if isCheck {
                Text("별킷 달성 완료")
                        .font(.custom("KNPSKkomi-Regular", size: 18))
                } else {
                    Text("별킷 달성하기")
                        .font(.custom("KNPSKkomi-Regular", size: 18))
                }
            }
            .modifier(MaxWidthColoredButtonModifier(color: Color("mainColor"), cornerRadius: 15))
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                if !isCheck {
                    NavigationLink {
                        BucketListDetailAddView()
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 22, weight: .light))
                    }
                }
            }
        }
        .onAppear {
            Task {
                bucketDetailStore.bucketDetail = try await bucketDetailStore.fetchBucketDetail(detailIdList)
            }
        }
    }
}
        
        struct BucketDetailListView_Previews: PreviewProvider {
            static var previews: some View {
                BucketListView()
            }
        }
