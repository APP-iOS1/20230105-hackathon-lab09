//
//  AddStarView.swift
//  starcket
//
//  Created by 윤소희 on 2023/01/05.
//

import SwiftUI

struct AddStarView: View {
//    @Environment(\.presentationMode) var addingStar // dismiss
    var stars = [0, 0, 0, 0, 0] // DB의 Bucket의 shape 값
    var starNum:Int = 0 // DB의 Bucket의 isCheck가 true인 거 개수
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    var body: some View {
        VStack{
            HStack{
                Text("추가할 수 있는 별이 \(starNum)개 있습니다.")
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
                    ForEach((0..<stars.count), id: \.self) { i in
                        Button {
                            
                        } label: {
                            Image("\(0)")
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

