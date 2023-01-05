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
                    } label: {
                        Image(systemName:"arrowtriangle.left.fill")
                    }
                    Text(String(year))
                        .padding(.horizontal, Screen.maxWidth * 0.2)
                    Button {
                        if year < 2023 {
                            year += 1
                        }
                    } label: {
                        Image(systemName:"arrowtriangle.right.fill")
                    }

                }
                .font(.custom("Pretendard-Regular", size: 25))
                .padding(.vertical, Screen.maxWidth * 0.07)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(bucketStore.bucket) { bucket in
                            HStack {
                                Text(bucket.icon)
                                    .font(.custom("Pretendard-Regular", size: 25))

                                    .padding(.trailing,Screen.maxWidth * 0.01)
                                Text(bucket.title)
                                    .font(.custom("Pretendard-Regular", size: 22))
                            }
                            .padding(.leading, Screen.maxWidth * 0.06)
                            .frame(width: Screen.maxWidth * 0.8, height: Screen.maxHeight * 0.09, alignment: .leading)
                            .background {
                                Color("cellColor")
                            }
                            .cornerRadius(20)
                        }
                    }
                }
            }
            .background {
                Color("bgColor")
                    .frame(width: Screen.maxWidth, height: Screen.maxHeight)
            }
            .navigationBarItems(trailing:Button(action: {
                isClickMarker.toggle()
            }, label: {
                Image(systemName: "plus")
                    .bold()
            }))
            .navigationBarTitle("나의 별킷리스트")
            .sheet(isPresented: $isClickMarker) {
                BucketListAddView(isClickMarker: $isClickMarker)
                    .presentationDetents([.fraction(0.8)])
            }
        } // NavigationView
        .onAppear {
            Task {
                UserDefaults.standard.set("7BW5aWDlcP8E5NllOu4f", forKey: "userIdToken")
                (bucketStore.bucket, bucketStore.bucketIdList) = try await bucketStore.fetchBucket()
            }
        }
    }
    
}


struct BucketListView_Previews: PreviewProvider {
    static var previews: some View {
        BucketListView()
    }
}
