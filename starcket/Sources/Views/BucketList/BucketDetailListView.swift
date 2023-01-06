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
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    ForEach(bucketDetailStore.bucketDetail) { bucket in
                        NavigationLink {
                            BucketDetailView()
                        } label: {
                            HStack {
                                Text(bucket.title)
                                    .font(.custom("Pretendard-Regular", size: 22))
                                Spacer()
                                Text("\(bucket.createdDate)")
                                    .font(.custom("Pretendard-Regular", size: 18))
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal, Screen.maxWidth * 0.06)
                            .frame(width: Screen.maxWidth * 0.8, height: Screen.maxHeight * 0.09, alignment: .leading)
                            .background {
                                Color("cellColor")
                            }
                            .cornerRadius(20)
                        }
                        
                    }
                    
                }

            } // ScrollView
            
            Button {
                bucketStore.isLoading = true
                Task {
                    bucketStore.completedBucket(bucketId, true)
                    (bucketStore.bucket, bucketStore.bucketIdList) = try await bucketStore.fetchBucketByDate(String(year))
                    bucketStore.isLoading = false
                }
                dismiss
                

            } label: {
                Text("별킷 달성 완료")
                    .padding(.horizontal, Screen.maxHeight*0.09)
                    .font(.custom("Pretendard-Regular", size: 18))
                    .padding(.vertical, Screen.maxWidth*0.05)
            }
            .background(Color("mainColor"))
            .cornerRadius(40)
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                
                NavigationLink {
                    BucketListDetailAddView()
                } label: {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 22, weight: .semibold))
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
