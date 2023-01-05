//
//  AnalyzeView.swift
//  starcket
//
//  Created by geonhyeong on 2023/01/05.
//

import SwiftUI

struct AnalyzeView: View {
    
    @StateObject var bucketStore: BucketStore = BucketStore()
    
    // For a Wave
    @State var total: CGFloat = 1.0
    @State var progress: CGFloat = 0.0
    @State var startAnimation: CGFloat = 0
    
    // Showing
    @State var showingProgress: Int = 0
    
    var body: some View {
        VStack{
            
            HStack{
                Image(systemName: "arrow.left")
                    .font(.title)
                
                Text("2023년")
                    .font(.title)
                
                Image(systemName: "arrow.right")
                    .font(.title)
                
            }

            Section{
                // let percentage = Int((showingProgress / Int(total)) * 100)
                // 예시로 progress = 0.5
                let percentage = Int(progress * 100)
                Text("\(percentage) % 달성")
                    .bold()
                    .foregroundColor(.yellow)
                    .font(.title)
                
                GeometryReader { proxy in
                    let size = proxy.size
                    
                    ZStack{
                        Image(systemName: "bag.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        //foreground cant be white
                            .foregroundColor(.white)
                        // streching in X Axis
                        //.scaleEffect(x: 1.1 , y:1)
                        //.offset(y: -1)
                        // wave
                        
                        Group {
                            WaterWave(progress: progress, waveHeight: 0.05, offset:  startAnimation)
                                .fill(.yellow)
                            //4.
                            // Water Drop
                                .overlay(content:{
                                    
                                    ZStack{
                                        
                                        
                                        Circle()
                                            .fill(.white.opacity(0.1))
                                            .frame(width: 15, height: 15)
                                            .offset(x: -20)
                                        
                                        Circle()
                                            .fill(.white.opacity(0.1))
                                            .frame(width: 15, height: 15)
                                            .offset(x: 40, y: 30)
                                        
                                        Circle()
                                            .fill(.white.opacity(0.1))
                                            .frame(width: 25, height: 25)
                                            .offset(x: -30, y: 80)
                                        
                                        
                                        Circle()
                                            .fill(.white.opacity(0.1))
                                            .frame(width: 10, height: 10)
                                            .offset(x: 40, y: 100)
                                        
                                        Circle()
                                            .fill(.white.opacity(0.1))
                                            .frame(width: 10, height: 10)
                                            .offset(x: -40, y: 50)
                                        
                                    }
                                    
                                })
                            //3.
                            //Masking into Drop Shape
                                .mask {
                                    
                                    Image(systemName: "bag.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .padding(0)
                            }
                        }
                        
                        Group {
                            DeepWaterWave(progress: progress, waveHeight: 0.05, offset:  startAnimation)
                                .fill(.orange)
                            //4.
                            // Water Drop
                                .overlay(content:{
                                    
                                    ZStack{
                                        
                                        
                                        Circle()
                                            .fill(.white.opacity(0.1))
                                            .frame(width: 15, height: 15)
                                            .offset(x: -20)
                                        
                                        Circle()
                                            .fill(.white.opacity(0.1))
                                            .frame(width: 15, height: 15)
                                            .offset(x: 40, y: 30)
                                        
                                        Circle()
                                            .fill(.white.opacity(0.1))
                                            .frame(width: 25, height: 25)
                                            .offset(x: -30, y: 80)
                                        
                                        
                                        Circle()
                                            .fill(.white.opacity(0.1))
                                            .frame(width: 10, height: 10)
                                            .offset(x: 40, y: 100)
                                        
                                        Circle()
                                            .fill(.white.opacity(0.1))
                                            .frame(width: 10, height: 10)
                                            .offset(x: -40, y: 50)
                                        
                                    }
                                    
                                })
                            //3.
                            //Masking into Drop Shape
                                .mask {
                                    
                                    Image(systemName: "bag.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .padding(0)
                            }
                        }
                        
                
                     
                        
                        
                        // 5.
                        // Add Buttton
                        //                            .overlay(alignment: .bottom){
                        //
                        //                                Button {
                        //                                    print("more higher")
                        //                                    progress += 0.05
                        //                                    if total < progress{
                        //                                        progress = 0.4
                        //                                    }
                        //                                } label: {
                        //                                    Image(systemName: "plus")
                        //                                        .font(.system(size:40, weight: .black))
                        //                                        .foregroundColor(.yellow)
                        //                                        .padding(25)
                        //                                        .background(.white, in: Circle())
                        //                                }
                        //                                .offset(y:40)
                        //
                        //
                        //                            }
                        
                    }
                        .frame(width: size.width, height: size.height, alignment: .center)
                        .onAppear{
                            // Looping Animation
                            withAnimation(.linear(duration: 2).repeatForever(autoreverses: true)){
                                // If you set value less than the rect width it will not finish completely
                                // startAnimbation = size.width - 100
                                startAnimation = size.width / 2
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            
            VStack{
                Text(" \(Int(total))개 중에 \(Int(showingProgress))개를 달성하셨어요!!")
                    .bold()
                    .foregroundColor(.yellow)
                    .font(.title)
            }
            Spacer()
        }
        .padding()
        .onAppear {
            Task {
                UserDefaults.standard.set("7BW5aWDlcP8E5NllOu4f", forKey: "userIdToken")
                (bucketStore.bucket, bucketStore.bucketIdList) = try await bucketStore.fetchBucket()
                
                total = CGFloat(bucketStore.bucket.count)
                print(total)
                print(bucketStore.bucket.count)
                
                for bucket in bucketStore.bucket{
                    if bucket.isCheck {
                        //print(bucket.isCheck)
                        showingProgress += 1
                        progress += 1 / CGFloat(bucketStore.bucket.count)
                    }
                }
            }
        }
        .onDisappear{
            total = 0.0
            progress = 0.0
            showingProgress = 0
            
        }
    }
}

//struct AnalyzeView_Previews: PreviewProvider {
//    static var previews: some View {
//        AnalyzeView()
//    }
//}
