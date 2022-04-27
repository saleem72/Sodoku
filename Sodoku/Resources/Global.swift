//
//  Global.swift
//  Sodoku
//
//  Created by Yousef on 4/20/22.
//

import SwiftUI

struct Global {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    
    static let cellWidth = (UIScreen.main.bounds.width - 32) / 9
    static let keyboardKeyWidth = (UIScreen.main.bounds.width - 32 - 72) / 9
    
    static func calculateAngle(centerPoint: CGPoint, endPoint: CGPoint) -> CGFloat {
        let radian = atan2(endPoint.x - centerPoint.x, centerPoint.y - endPoint.y)
        
        let degree = 180 + (radian * 180 / .pi)
        
        return degree
    }
}
