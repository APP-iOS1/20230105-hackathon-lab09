//
//  ContentView.swift
//  starcket
//
//  Created by geonhyeong on 2023/01/05.
//

import SwiftUI

struct ContentView: View {
    @State private var tabSelection: Int = 0
    
    
    var body: some View {
        NavigationView {
            SignInView()
//            TabView(selection: $tabSelection) {
//                HomeView()
//                    .tabItem {
//                        Image(systemName: "house.fill")
//                        Text("별킷")
//                    }.tag(0)
//                BucketListView()
//                    .tabItem {
//                        Image(systemName: "checklist.checked")
//                        Text("리스트")
//                    }.tag(1)
//                AnalyzeView()
//                    .tabItem {
//                        Image(systemName: "chart.bar.xaxis")
//                        Text("분석")
//                    }.tag(2)
//                MyPageView()
//                    .tabItem {
//                        Image(systemName: "person.crop.circle.fill")
//                        Text("마이페이지")
//                    }.tag(3)
//            }
            
            //수현 테스트용
//            if UserDefaults.standard.object(forKey: "userIdToken") != nil {
//                TabView(selection: $tabSelection) {
//                    HomeView()
//                        .tabItem {
//                            Image(systemName: "house.fill")
//                            Text("별킷")
//                        }.tag(0)
//                    BucketListView()
//                        .tabItem {
//                            Image(systemName: "checklist.checked")
//                            Text("리스트")
//                        }.tag(1)
//                    AnalyzeView()
//                        .tabItem {
//                            Image(systemName: "chart.bar.xaxis")
//                            Text("분석")
//                        }.tag(2)
//                    MyPageView()
//                        .tabItem {
//                            Image(systemName: "person.crop.circle.fill")
//                            Text("마이페이지")
//                        }.tag(3)
//                }
//            }else{
//
//                SignInView()
//            }
       
        }
    }
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
    }
}
