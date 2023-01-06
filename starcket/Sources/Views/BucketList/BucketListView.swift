//
//  BucketListView.swift
//  starcket
//
//  Created by geonhyeong on 2023/01/05.
//

import SwiftUI

struct BucketListView: View {
    @StateObject var bucketStore = BucketStore()
    @State private var isClickMarker = false
    @State var year: Int = 2023
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button {
                        year -= 1
                        bucketStore.isLoading = true
                        Task {
                            (bucketStore.bucket, bucketStore.bucketIdList) = try await bucketStore.fetchBucketByDate(String(year))
                            bucketStore.isLoading = false
                        }
                    } label: {
                        Image(systemName:"arrowtriangle.left.fill")
                    }
                    Text("\(String(year))년")
                        .padding(.horizontal, Screen.maxWidth * 0.2)
                    Button {
                        if year < 2023 {
                            year += 1
                        }
                        bucketStore.isLoading = true
                        Task {
                            (bucketStore.bucket, bucketStore.bucketIdList) = try await bucketStore.fetchBucketByDate(String(year))
                            bucketStore.isLoading = false
                        }
                    } label: {
                        Image(systemName:"arrowtriangle.right.fill")
                    }
                    
                }
                .font(.custom("Pretendard-Regular", size: 25))
                .padding(.vertical, Screen.maxWidth * 0.07)
                if bucketStore.isLoading {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color(uiColor: UIColor(named: "AccentColor")!)))
                        .scaleEffect(2)
                    Spacer()
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            ForEach(bucketStore.bucket) { bucket in
                                NavigationLink {
                                    BucketDetailListView(bucketStore: bucketStore, detailIdList: bucket.detailId, bucketId: bucket.id, year: $year, isCheck: bucket.isCheck)
                                } label: {
                                    HStack {
                                        Text(bucket.icon)
                                            .font(.custom("Pretendard-Regular", size: 25))
                                        
                                            .padding(.trailing,Screen.maxWidth * 0.01)
                                        Text(bucket.title)
                                            .font(.custom("Pretendard-Regular", size: 18))
                                    }
                                    .padding(.leading, Screen.maxWidth * 0.06)
                                    .frame(width: Screen.maxWidth * 0.87, height: Screen.maxHeight * 0.09, alignment: .leading)
                                    .background {
                                        bucket.isCheck ? Color("19") : Color("cellColor")
                                    }
                                    .foregroundColor(bucket.isCheck ? Color("font2") : Color("font1"))
                                    .cornerRadius(20)
                                    //                                .overlay(RoundedRectangle(cornerRadius: 30)
                                    //                                    .stroke(bucket.isCheck ? Color.black : Color.gray, lineWidth: 3))
                                }
                                
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                //                Color(hex: "FDFCED")
                Color("bgColor")
            }
            .navigationBarItems(trailing:Button(action: {
                isClickMarker.toggle()
            }, label: {
                Image(systemName: "plus.circle")
                    .font(.system(size: 22, weight: .semibold))
            }))
            .navigationBarTitle("나의 별킷리스트", displayMode: .inline)
            .sheet(isPresented: $isClickMarker) {
                BucketListAddView(isClickMarker: $isClickMarker)
                    .presentationDetents([.fraction(0.8)])
            }
            
            .onAppear {
                bucketStore.isLoading = true
                Task {
                    UserDefaults.standard.set("WJuLT2Ca3ucjdiSCmTh5756qNIC3", forKey: "userIdToken")
                    (bucketStore.bucket, bucketStore.bucketIdList) = try await bucketStore.fetchBucketByDate(String(year))
                    bucketStore.isLoading = false
                }
            }
        }
    }
    
}


struct BucketListView_Previews: PreviewProvider {
    static var previews: some View {
        BucketListView()
    }
}
