//
//  MyBucket.swift
//  MyBucket
//
//  Created by greenthings on 2023/01/05.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        
        // 5 days
        for hourOffset in 0 ..< 6 {
            let entryDate = Calendar.current.date(byAdding: .second, value: hourOffset, to: currentDate)!
            
            let startDate = Calendar.current.startOfDay(for: entryDate)
            
            let entry = SimpleEntry(date: startDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

// Model
// Time
struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct MyBucketEntryView : View {
    var entry: Provider.Entry
    // For a Wave
    @State var total: CGFloat = 1.0
    @State var progress: CGFloat = 0.4
    @State var startAnimation: CGFloat = 0
    // Rotation
    @State var rotation: Double = 0
    
    
    @Environment(\.colorScheme) var colorScheme
    

    var body: some View {
        
        VStack(spacing:0){
            GeometryReader { proxy in
                let size = proxy.size
                
                ZStack{
//                    Image("bucket")
//                    //Image(systaemName: "bag.fill")
//                        .frame(width:10, height:10)
//                        .clipped()
//                        .aspectRatio(contentMode: .fit)
                 
                    //foreground cant be white
                        //.foregroundColor(.white)

                    // wave
                    
                    Group {
                        WaterWave(progress: progress, waveHeight: 0.05, offset:  startAnimation)
                            .fill(Color(hex:"#9bc5ed"))
                        //4.
                        // Water Drop
                            .overlay(content:{
                                
                                ZStack{

                                    Image("star")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: size.width / 1.5, height: size.height / 1.5)
                                        .offset(x: 0, y: 0)
                                        .rotationEffect(.degrees(rotation))

                                }
                                
                            })
                        //3.
                        //Masking into Drop Shape
//                            .mask {
//                                Image("bucket")
//                                //Image(systemName: "bag.fill")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width:50, height:50)
//
//
//                            }
                    }
                    
                    Group {
                        DeepWaterWave(progress: progress, waveHeight: 0.05, offset:  startAnimation)
                            .fill(Color(hex:"#c8e3fd"))
                        //4.
                        // Water Drop
                            .overlay(content:{
                                
                                ZStack{
                                    
                                    
                                    
                                    Circle()
                                        .fill(.white.opacity(0.3))
                                        .frame(width: 15, height: 15)
                                        .offset(x: -20)
                                    
                                    Circle()
                                        .fill(.white.opacity(0.3))
                                        .frame(width: 15, height: 15)
                                        .offset(x: 40, y: 30)
                                    
                                    Circle()
                                        .fill(.white.opacity(0.3))
                                        .frame(width: 25, height: 25)
                                        .offset(x: -30, y: 80)
                                    
                                    
                                    Circle()
                                        .fill(.white.opacity(0.3))
                                        .frame(width: 10, height: 10)
                                        .offset(x: 40, y: 100)
                                    
                                    Circle()
                                        .fill(.white.opacity(0.3))
                                        .frame(width: 10, height: 10)
                                        .offset(x: -40, y: 50)
                                    
                                    
                                    
                                    
//                                    Image("bucketO")
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fit)
//                                        .frame(width:50, height:50)
                                    
                                    
                                }
                                
                            })
                        //3.
                        //Masking into Drop Shape
//                            .mask {
//                                Image("bucket")
//                                //Image(systemName: "bag.fill")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width:50, height:50)
//                                    .padding(0)
//                            }
                    }
                    
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

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .edgesIgnoringSafeArea(.all)
        .background( colorScheme == .dark ? .blue : .black)
        
        
    }
}

@main
struct MyBucket: Widget {
    let kind: String = "MyBucket"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            MyBucketEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct MyBucket_Previews: PreviewProvider {
    static var previews: some View {
        MyBucketEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
