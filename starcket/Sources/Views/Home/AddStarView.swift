//
//  AddStarView.swift
//  starcket
//
//  Created by 윤소희 on 2023/01/05.
//

import SwiftUI

struct AddStarView: View {
//    @Environment(\.presentationMode) var addingStar // dismiss
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    @State private var starPosList: [CGSize] = [] // 드래그한 만큼 별이 움직이도록 binding에 사용될 Property
    @State private var accumlatedOffset: [CGSize] = [] // 지금까지 드래그 된 값을 기록하고 있는 Property
    //@Binding var waitingStarList: [Bucket]
    // waitingStarList = [11.1, 12.1, 12.23, 12.25]
    // waitingStarList에서 빼줘야할것같음
    // 별 버튼을 누르면 그 별의 isFloating값을 true로 해줘야함
    // shape값 넘겨줘야함 - update함수를 통해서 ?
    @StateObject var bucketStore: BucketStore = BucketStore()
    var body: some View {
        VStack{
            HStack{
                Text("추가할 수 있는 별이 \(0)개 있습니다.")
                    .font(.title3)
                    .padding()
                Spacer()
                Button {
//                    addingStar.wrappedValue.dismiss()
                } label: {
                    Text("확인")
                }
                .padding()

            }
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach((0..<8), id: \.self) { i in
                        Button {
                            starPosList.append(.zero)
                            accumlatedOffset.append(.zero)
                        } label: {
                            Image("\(i)")
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                    }
                }
            }
        }
    }
}

struct AddStarView_Previews: PreviewProvider {
    static var previews: some View {
        AddStarView()
    }
}

