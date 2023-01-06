//
//  HomeView.swift
//  starcket
//
//  Created by 윤소희 on 2023/01/05.
//

import SwiftUI


struct HomeView: View {
    @StateObject var bucketStore: BucketStore = BucketStore()
    @State private var starList: [Bucket] = [] // 떠있는 별 List
    @State private var waitingStarList: [Bucket] = [] // 기다리는 별 .. List
    
   // 드래그한 만큼 별이 움직이도록 binding에 사용될 Property
    @State private var accumlatedOffset: [CGSize] = [] // 지금까지 드래그 된 값을 기록하고 있는 Property
    @State private var showingAddView: Bool = false
	@Binding var darkmodeToggle: Bool
	@Binding var tabSelection: Int

    var body: some View {
        NavigationStack {
            VStack{
                ZStack {
                    ForEach(Array(starList.enumerated()), id:\.offset) { idx, star in
                        Image("\(star.shape)")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .offset(bucketStore.starPosArr[idx])
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        bucketStore.starPosArr[idx].width = accumlatedOffset[idx].width + value.translation.width
                                        bucketStore.starPosArr[idx].height = accumlatedOffset[idx].height + value.translation.height
                                                                                
                                        if bucketStore.starPosArr[idx].width >= 160.0 {
                                            bucketStore.starPosArr[idx].width = 160.0
                                        }else if bucketStore.starPosArr[idx].width <= -160.0 {
                                            bucketStore.starPosArr[idx].width = -160.0
                                        }
                                        
                                        if bucketStore.starPosArr[idx].height <= -360.0 {
                                            bucketStore.starPosArr[idx].height = -360.0
                                        }else if bucketStore.starPosArr[idx].height >= 320.0 {
                                            bucketStore.starPosArr[idx].height = 320.0
                                        }
                                        
                                    }
                                    .onEnded { value in
                                        accumlatedOffset[idx].width += value.translation.width
                                        accumlatedOffset[idx].height += value.translation.height
                                        
                                        //1. 여기서 보내기
                                        
                                        bucketStore.updateStarPos(star.id , bucketStore.starPosArr[idx].width, bucketStore.starPosArr[idx].height)
                                    }
                            )
                    }
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddStarView(bucketStore: bucketStore, starList: $starList, waitingStarList: $waitingStarList, starPosArr: $bucketStore.starPosArr, accumlatedOffset: $accumlatedOffset)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
					HStack {
						Button {
							tabSelection = 0
						} label: {
							Image(systemName: "arrow.up")
								.foregroundColor(.white)
						}
						
						Button {
							showingAddView.toggle()
						} label: {
							Image(systemName: "line.3.horizontal")
								.foregroundColor(.white)
						}
					}
					.padding(.trailing, 15)
				}
            }
            .onAppear {
                Task{
                    //bucket에서 isFloat == true shape, title불러오기
                    (bucketStore.bucket, bucketStore.bucketIdList, bucketStore.starPosArr) = try await bucketStore.fetchBucket()
                    
					starList = bucketStore.bucket.filter {$0.isCheck == true && $0.isFloat == true && $0.createdAt.isBetween("2023-01-01".toDate()!, and: "2024-01-01".toDate()!)}
                    // isCheck == true && isFloat == false
                    waitingStarList = bucketStore.bucket.filter {$0.isCheck == true && $0.isFloat == false}
                    accumlatedOffset = Array(repeating: CGSize(width: 0, height: 0), count: bucketStore.starPosArr.count)
                }
            }
			.fullBackground(imageName: darkmodeToggle ? "Dark" : "Light")
			.preferredColorScheme(darkmodeToggle ? .light : .dark)
            //2. 여기서 .onDisappear 해서 보내기
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
		HomeView(darkmodeToggle: .constant(false), tabSelection: .constant(1))
    }
}
