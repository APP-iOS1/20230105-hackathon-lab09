//
//  AddStarView.swift
//  starcket
//
//  Created by 윤소희 on 2023/01/05.
//

import SwiftUI

struct AddStarView: View {
    @Environment(\.presentationMode) var addingStar // dismiss
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    // TODO: starPosList저장, 모서리에 닿을때 처리, 별 선택 시 크기 키워지게, waitingStar비워지면 버튼 비활성화
    
    @StateObject var bucketStore: BucketStore
    
    @Binding var starList: [Bucket]
    @Binding var waitingStarList: [Bucket]
    
    // 추가될 별들의 좌표 정보
    @Binding var starPosArr: [CGSize]  // 드래그한 만큼 별이 움직이도록 binding에 사용될 Property
    @Binding var accumlatedOffset: [CGSize] // 지금까지 드래그 된 값을 기록하고 있는 Property
    // 버튼이 눌렸을때 선택된 별의 크기를 키워주기 위한 프로퍼티
    @State private var buttonText: String = ""
    @State private var selectedStar: Int?
    
    
    
    //@Binding var waitingStarList: [Bucket]
    // waitingStarList = [11.1, 12.1, 12.23, 12.25]
    // waitingStarList에서 빼줘야할것같음
    // 별 버튼을 누르면 그 별의 isFloating값을 true로 해줘야함
    // shape값 넘겨줘야함 - update함수를 통해서 ?
    var body: some View {
		VStack(spacing: 0){
            HStack{
                Spacer()
                Button {
                    if waitingStarList.count > 0 {
                        starPosArr.append(.zero)
                        accumlatedOffset.append(.zero)
                        waitingStarList[0].shape = selectedStar ?? 0
                        // 버튼 누르면 별 추가
                        
                        // db 업데이트
                        bucketStore.updateStar(waitingStarList[0].id, isFloat: true, shape: selectedStar ?? 0)
                        print(waitingStarList[0].shape)
                        
                        starList.append(waitingStarList[0])
                        waitingStarList.removeFirst()
                        addingStar.wrappedValue.dismiss()
                    }else{
                        addingStar.wrappedValue.dismiss()
                    }
                    
                    
                } label: {
                    waitingStarList.count == 0 ? Text("닫기") : Text("추가")
                }
				.font(.custom("KNPSKkomi-Regular", size: 25))
                .padding()

            }
			VStack {
				Text("추가할 수 있는 별이 \(waitingStarList.count)개 있습니다.")
				
				Text("별을 추가하여 하늘로 띄워주세요!")
			}
			.padding(.leading, 15)
			.font(.custom("KNPSKkomi-Regular", size: 25))
			
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach((0..<8), id: \.self) { i in
                        Button {
                            // 여기서 별 종류 선택 -> 별종류 업데이트
                            selectedStar = i
                        } label: {
                            if i == selectedStar{
                                Image("\(i)")
                                    .resizable()
                                    .frame(width: 130, height: 130)
                            }else{
                                Image("\(i)")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .padding(15)
                            }
                        }
                        .disabled(waitingStarList.count <= 0)
                      
                    }
                }
            }
        }
    }
}

//struct AddStarView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddStarView()
//    }
//}

