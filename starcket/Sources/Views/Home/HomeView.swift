//
//  HomeView.swift
//  starcket
//
//  Created by geonhyeong on 2023/01/05.
//

import SwiftUI

struct HomeView: View {
    @StateObject var bucketStore: BucketStore = BucketStore()
    @State private var starList: [Image] = [Image("0")]
    @State private var starPosList: [CGSize] = [CGSize(width: 0, height: 0)] // 드래그한 만큼 별이 움직이도록 binding에 사용될 Property
    @State private var accumlatedOffset: [CGSize] = [CGSize(width: 0, height: 0)] // 지금까지 드래그 된 값을 기록하고 있는 Property
    @State private var showingAddView: Bool = false
    var body: some View {
        NavigationView {
            VStack{
                ZStack {
                    starList[0]
                        .resizable()
                        .frame(width: 100, height: 100 )
                        .offset(starPosList[0])
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    starPosList[0].width = accumlatedOffset[0].width + value.translation.width
                                    starPosList[0].height = accumlatedOffset[0].height + value.translation.height
                                }
                                .onEnded { value in
                                    accumlatedOffset[0].width += value.translation.width
                                    accumlatedOffset[0].height += value.translation.height
                                }
                        )
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
                    try await bucketStore.fetchBucket()
                }
            }
        }
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

//import SwiftUI
//
//struct Example31_3: View {
//    @State private var starList: [MyStar1] = []
//    @State private var starPosList: [CGSize] = [] // 드래그한 만큼 별이 움직이도록 binding에 사용될 Property
//    @State private var accumlatedOffset: [CGSize] = [] // 지금까지 드래그 된 값을 기록하고 있는 Property
//
//    var body: some View {
//        VStack {
//            ZStack {
//                ForEach(starList.indices, id: \.self) { i in
//                    starList[i].star
//                        .offset(starPosList[i])
//                        .gesture(
//                            DragGesture()
//                                .onChanged { value in
//                                    starPosList[i].width = accumlatedOffset[i].width + value.translation.width
//                                    starPosList[i].height = accumlatedOffset[i].height + value.translation.height
//                                }
//                                .onEnded { value in
//                                    accumlatedOffset[i].width += value.translation.width
//                                    accumlatedOffset[i].height += value.translation.height
//                                }
//                        )
//                }
//            } // ZStack
//
//            Spacer()
//            Button {
//                starList.append(MyStar1())
//                starPosList.append(.zero)
//                accumlatedOffset.append(.zero)
//            } label: {
//                Text("별 추가하기")
//                    .font(.system(size: 20, weight: .semibold))
//                    .padding(13)
//                    .foregroundColor(.black)
//                    .background(.yellow)
//            }
//            .cornerRadius(13)
//        } // VStack
//    }
//}
//
////MARK: - 별모양 Shape
//struct MyStarShape1: Shape {
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
//        let radius = rect.width / 10 // 길이
//
//        var angle = -18.0 // -18도에서 시작 각도가 위로 향하도록
//
//        for _ in 1...5 {
//            // 중심점 계산하기
//            let cc = CGPoint(
//                x: center.x + radius * cos(Angle(degrees: angle).radians),
//                y: center.y + radius * sin(Angle(degrees: angle).radians)
//            )
//
//            // 144도로 계산
//            path.addArc(center: cc, radius: 0, startAngle: Angle(degrees: angle - 72), endAngle: Angle(degrees: angle + 72), clockwise: false)
//
//            // 별의 다음 점으로 144도 이동
//            angle += 144
//        }
//
//        return path
//    }
//}
//
//class MyStar1: Identifiable {
//    let id = UUID()
//    let star: MyStarShape1 = MyStarShape1()
//}
//
//struct Example31_3_Previews: PreviewProvider {
//    static var previews: some View {
//        Example31_3()
//    }
//}
