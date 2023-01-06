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
    
    
    // Rotation
    @State var rotation: Double = 0
    
    
    // This Year
    @State var year: Int = 2023
    
    init() {
            //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "KNPSKkomi-Regular", size: 38)!]

            //Use this if NavigationBarTitle is with displayMode = .inline
            //UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 20)!]
        }
    
    var body: some View {
        NavigationView {
            VStack {
                
//                HStack {
//                    Text("연도별 별킷 달성률")
//                        .font(.title)
//                        .bold()
//                    Spacer()
//                }
//                .padding(EdgeInsets(top: 35, leading: 20, bottom: 35, trailing: 20))
//
                HStack {
                    Button {
                        year -= 1
                        bucketStore.isLoading = true
                        
                        total = 0.0
                        progress = 0.0
                        showingProgress = 0
                        rotation = 0.0
                        
                        Task {
                            (bucketStore.bucket, bucketStore.bucketIdList) = try await bucketStore.fetchBucketByDate(String(year))
                            
                            total = CGFloat(bucketStore.bucket.count)
                            
                            
                            for bucket in bucketStore.bucket{
                                if bucket.isCheck {
                                    //print(bucket.isCheck)
                                    showingProgress += 1
                                    progress += 1 / CGFloat(bucketStore.bucket.count)
                                }
                            }
                            bucketStore.isLoading = false
                        }
                    } label: {
                        Image(systemName:"chevron.left")
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                    
                    Text(String(year) + "년")
                        .font(.custom("KNPSKkomi-Regular", size: 22))
                        .padding(.horizontal, 20)
                    
                    Button {
                        if year < 2023 {
                            year += 1
                        }
                        bucketStore.isLoading = true
                        
                        total = 0.0
                        progress = 0.0
                        showingProgress = 0
                        rotation = 0.0
                        
                        Task {
                            (bucketStore.bucket, bucketStore.bucketIdList) = try await bucketStore.fetchBucketByDate(String(year))
                            
                            total = CGFloat(bucketStore.bucket.count)
                            
                            
                            for bucket in bucketStore.bucket{
                                if bucket.isCheck {
                                    //print(bucket.isCheck)
                                    showingProgress += 1
                                    progress += 1 / CGFloat(bucketStore.bucket.count)
                                }
                            }
                            bucketStore.isLoading = false
                        }
                    } label: {
                        Image(systemName:"chevron.right")
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                    
                }
                .padding(.vertical, 28)
                
                VStack(spacing:0){
                    GeometryReader { proxy in
                        let size = proxy.size
                        
                        ZStack{
                            Image("bucket")
                            //Image(systaemName: "bag.fill")
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
                                    .fill(Color(hex:"#9bc5ed"))
                                //4.
                                // Water Drop
                                //                                .overlay(content:{
                                //
                                //                                    ZStack{
                                //
                                //                                        Image("star")
                                //                                            .resizable()
                                //                                            .frame(width: size.width / 2, height:size.width / 2)
                                //                                            .offset(x: 0, y: 60)
                                //                                            .rotationEffect(.degrees(rotation))
                                //
                                //                                    }
                                //
                                //                                })
                                //3.
                                //Masking into Drop Shape
                                    .mask {
                                        Image("bucket")
                                        //Image(systemName: "bag.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .padding(0)
                                    }
                            }
                            
                            Group {
                                DeepWaterWave(progress: progress, waveHeight: 0.05, offset:  startAnimation)
                                    .fill(Color(hex:"#c8e3fd"))
                                //4.
                                // Water Drop
                                    .overlay(content:{
                                        
                                        ZStack{
                                            
                                            
                                            
                                            Circle()
                                                .fill(.white.opacity(0.4))
                                                .frame(width: 15, height: 15)
                                                .offset(x: -40)
                                            
                                            Circle()
                                                .fill(.white.opacity(0.4))
                                                .frame(width: 15, height: 15)
                                                .offset(x: 50, y: 40)
                                            
                                            Circle()
                                                .fill(.white.opacity(0.4))
                                                .frame(width: 25, height: 25)
                                                .offset(x: -40, y: 90)
                                            
                                            
                                            Circle()
                                                .fill(.white.opacity(0.4))
                                                .frame(width: 10, height: 10)
                                                .offset(x: 50, y: 120)
                                            
                                            Circle()
                                                .fill(.white.opacity(0.4))
                                                .frame(width: 10, height: 10)
                                                .offset(x: -50, y: 60)
                                            
                                            
                                            
                                            
                                            Image("bucketO")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                            
                                            
                                        }
                                        
                                    })
                                //3.
                                //Masking into Drop Shape
                                    .mask {
                                        Image("bucket")
                                        //Image(systemName: "bag.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .padding(0)
                                    }
                            }
                            
                            
                            Image("star")
                                .resizable()
                                .frame(width: size.width / 2, height:size.width / 2)
                                .offset(x: 0, y: 60)
                                .rotationEffect(.degrees(rotation))
                            
                            
                            
                            
                            
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
                    
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    
                    
                    VStack(spacing: 8) {
                        // let percentage = Int((showingProgress / Int(total)) * 100)
                        // 예시로 progress = 0.5
                        let percentage = Int(progress * 100)
                        Text("\(percentage)% 달성!")
                            .bold()
                        //.foregroundColor(.yellow)
                        
                            .font(.custom("KNPSKkomi-Regular", size: 23))
                        
                        Text(" \(Int(total))개 중에 \(Int(showingProgress))개를 달성하였어요.")
                        // .bold()
                        //.foregroundColor(.yellow)
                            .font(.custom("KNPSKkomi-Regular", size: 17))
                            .fontWeight(.light)
                    }
                    .padding(.bottom, 45)
                }
                .background(Color("cellColor"))
                .cornerRadius(40)
                .padding(EdgeInsets(top: 5, leading: 25, bottom: 40, trailing: 25))
                
                
                //            VStack{
                //                // let percentage = Int((showingProgress / Int(total)) * 100)
                //                // 예시로 progress = 0.5
                //                let percentage = Int(progress * 100)
                //                Text("\(percentage) % 달성")
                //                    //.bold()
                //                //.foregroundColor(.yellow)
                //                   .font(.title2)
                //
                //                Text(" \(Int(total))개 중에 \(Int(showingProgress))개를 달성하셨네요!")
                //                   // .bold()
                //                //.foregroundColor(.yellow)
                //                    .font(.title3)
                //            }
                //            .frame(width: Screen.maxWidth,height: Screen.maxHeight / 10)
                //            .padding(.bottom, 40)
                
                
            }
            .navigationTitle(Text("연도별 별킷 달성률"))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            //.frame(width: Screen.maxWidth,height: Screen.maxHeight / 10)
            .background(Color("bgColor"))
            .onAppear {
                withAnimation(.linear(duration:2).repeatForever(autoreverses: true)) {
                    self.rotation = (self.rotation < 360 ? self.rotation - 30 : 0)
                }
                
                
                Task {
                    UserDefaults.standard.set("7BW5aWDlcP8E5NllOu4f", forKey: "userIdToken")
                    //                (bucketStore.bucket, bucketStore.bucketIdList, bucketStore.starPosArr) = try await bucketStore.fetchBucket()
                    (bucketStore.bucket, bucketStore.bucketIdList) = try await bucketStore.fetchBucketByDate(String(year))
                    //
                    //                print(total)
                    //                print(bucketStore.bucket.count)
                    
                    total = CGFloat(bucketStore.bucket.count)
                    
                    
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
                rotation = 0.0
                
            }
        }
    }
}

//struct AnalyzeView_Previews: PreviewProvider {
//    static var previews: some View {
//        AnalyzeView()
//    }
//}


//
//HStack{
//    Image(systemName: "arrow.left")
//        .font(.title)
//
//    Text("2023년")
//        .font(.title)
//
//    Image(systemName: "arrow.right")
//        .font(.title)
//
//}
