//
//  ContentView.swift
//  starcket
//
//  Created by geonhyeong on 2023/01/05.
//

import SwiftUI

struct ContentView: View {
    
    
    @State private var tabSelection: Int = 0
    
    @State var animate = false
    @State var endSplash = false
    
    
    var body: some View {
        ZStack{
            TabView(selection: $tabSelection) {
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("별킷")
                    }.tag(0)
                BucketListView()
                    .tabItem {
                        Image(systemName: "checklist.checked")
                        Text("리스트")
                    }.tag(1)
                AnalyzeView()
                    .tabItem {
                        Image(systemName: "chart.bar.xaxis")
                        Text("분석")
                    }.tag(2)
                MyPageView()
                    .tabItem {
                        Image(systemName: "person.crop.circle.fill")
                        Text("마이페이지")
                    }.tag(3)
                
            }
            
            ZStack{
                
                Image("LargeStar")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: animate ? .fill : .fit)
                    .frame(width: animate ? nil : 85, height: animate ? nil : 85)
                
                    .scaleEffect(animate ? 3 : 1)
                
                    .frame(width: UIScreen.main.bounds.width)
            }
            .ignoresSafeArea()
            .onAppear(perform: animateSplash)
            .opacity(endSplash ? 0 : 1)
            

        }
    }
    
    
    func animateSplash(){
        DispatchQueue.main.asyncAfter(deadline: .now()){
            withAnimation(Animation.easeOut(duration: 0.45)){
                animate.toggle()
            }
            withAnimation(Animation.easeOut(duration: 0.45)){
                endSplash.toggle()
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
