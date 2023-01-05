//
//  DeepWaterWave.swift
//  starcket
//
//  Created by greenthings on 2023/01/05.
//

import Foundation
import SwiftUI




struct DeepWaterWave: Shape{
    
    //2.
    // 0 ~ 1: Start to End
    var progress: CGFloat
    // Wave Height
    var waveHeight: CGFloat
    
    // Initial Animation Start
    var offset: CGFloat
    
    // Enabling Animation
    var animatableData: CGFloat{
        get{offset}
        set{offset = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        
        return Path{ path in
            // 1. start path
            path.move(to: .zero)
            
            // 2. Mark: Drawing Waves
            let progressHeight: CGFloat = (1 - progress) * rect.height
            let height = waveHeight * rect.height
            
            for value in stride(from: 0, to: rect.width, by: 0.01){
                
                let x: CGFloat = value
                //Cannot convert value of type 'Angle' to expected argument type 'CGFloat'
                // But using radins, we can make CGFloat
                let sine: CGFloat = cos(Angle(degrees: value + offset).radians)
                let y: CGFloat = progressHeight + (height * sine / 1.9)
                
                path.addLine(to: CGPoint(x: x, y: y))
            }
            
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
        }
    }
}
