//
//  HomeView.swift
//  starcket
//
//  Created by 윤소희 on 2023/01/05.
//

import SwiftUI

import SwiftUI

struct HomeView: View {
    @StateObject var bucketStore: BucketStore = BucketStore()
    @State private var starList: [Bucket] = []
    @State private var waitingStarList: [Bucket] = []
    @State private var starPosList: [CGSize] = [] // 드래그한 만큼 별이 움직이도록 binding에 사용될 Property
    @State private var accumlatedOffset: [CGSize] = [] // 지금까지 드래그 된 값을 기록하고 있는 Property
    @State private var showingAddView: Bool = false
    var body: some View {
        NavigationView {
            VStack{
                ZStack {
                    ForEach(Array(starList.enumerated()), id:\.offset) { idx, star in
                        Image("\(star.shape)")
                            .resizable()
                            .frame(width: 100, height: 100 )
                            .offset(starPosList[idx])
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        starPosList[idx].width = accumlatedOffset[idx].width + value.translation.width
                                        starPosList[idx].height = accumlatedOffset[idx].height + value.translation.height
                                    }
                                    .onEnded { value in
                                        accumlatedOffset[idx].width += value.translation.width
                                        accumlatedOffset[idx].height += value.translation.height
                                        
                                        //1. 여기서 보내기
                                    }
                            )
                    }
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddStarView()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                    }
                }
            }
            .onAppear {
                Task{
                    //bucket에서 isFloat == true shape, title불러오기
                    (bucketStore.bucket, bucketStore.bucketIdList) = try await bucketStore.fetchBucket()
                    
                    starList = bucketStore.bucket.filter {$0.isFloat == true}
                    // isCheck == true && isFloat == false
                    waitingStarList = bucketStore.bucket.filter {$0.isCheck == true && $0.isFloat == false}

                }
            }
            //2. 여기서 .onDisappear 해서 보내기
        }
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
