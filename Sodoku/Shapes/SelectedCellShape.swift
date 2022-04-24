//
//  SelectedCellShape.swift
//  Sodoku
//
//  Created by Yousef on 4/24/22.
//

import SwiftUI

struct SelectedCellShape: Shape {
    
    var lineWidth: CGFloat = 6
    var percentage: CGFloat = 0.3
    
    func path(in rect: CGRect) -> Path {
        
        let lip: CGFloat = rect.width * percentage
        
        let p1 = CGPoint(x: rect.minX, y: rect.minY + lip)
        let p2 = CGPoint(x: rect.minX, y: rect.minY)
        let p3 = CGPoint(x: rect.minX + lip, y: rect.minY)
        let p4 = CGPoint(x: rect.minX + lip, y: rect.minY + lineWidth)
        let p5 = CGPoint(x: rect.minX + lineWidth, y: rect.minY + lineWidth)
        let p6 = CGPoint(x: rect.minX + lineWidth, y: rect.minY + lip)
        
        let p7 = CGPoint(x: rect.maxX - lip, y: rect.minY)
        let p8 = CGPoint(x: rect.maxX, y: rect.minY)
        let p9 = CGPoint(x: rect.maxX, y: rect.minY + lip)
        let p10 = CGPoint(x: rect.maxX - lineWidth, y: rect.minY + lip)
        let p11 = CGPoint(x: rect.maxX - lineWidth, y: rect.minY + lineWidth)
        let p12 = CGPoint(x: rect.maxX - lip, y: rect.minY + lineWidth)
        
        let p13 = CGPoint(x: rect.maxX, y: rect.maxY - lip)
        let p14 = CGPoint(x: rect.maxX, y: rect.maxY)
        let p15 = CGPoint(x: rect.maxX - lip, y: rect.maxY)
        let p16 = CGPoint(x: rect.maxX - lip, y: rect.maxY - lineWidth)
        let p17 = CGPoint(x: rect.maxX - lineWidth, y: rect.maxY - lineWidth)
        let p18 = CGPoint(x: rect.maxX - lineWidth, y: rect.maxY - lip)
        
        let p19 = CGPoint(x: rect.minX + lip, y: rect.maxY)
        let p20 = CGPoint(x: rect.minX, y: rect.maxY)
        let p21 = CGPoint(x: rect.minX, y: rect.maxY - lip)
        let p22 = CGPoint(x: rect.minX + lineWidth, y: rect.maxY - lip)
        let p23 = CGPoint(x: rect.minX + lineWidth, y: rect.maxY - lineWidth)
        let p24 = CGPoint(x: rect.minX + lip, y: rect.maxY - lineWidth)
        
        var path = Path()
        path.move(to: p1)
        path.addLines([p1, p2, p3, p4, p5, p6, p1])
        
        path.move(to: p7)
        path.addLines([p7, p8, p9, p10, p11, p12, p7])
        
        path.move(to: p13)
        path.addLines([p13, p14, p15, p16, p17, p18, p13])
        
        path.move(to: p19)
        path.addLines([p19, p20, p21, p22, p23, p24, p19])
        
        return path
    }
}

//struct TestSelectedCellShape: View {
//    var body: some View {
//        VStack {
//            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//
//            ZStack {
//                SelectedCellShape(lineWidth: 8)
//                    .fill(Color.pink)
//                SelectedCellShape(lineWidth: 8)
//                    .stroke(Color.green, lineWidth: 2)
//            }
//            .frame(width: 100, height: 100)
//        }
//    }
//}
//
//struct TestSelectedCellShape_Previews: PreviewProvider {
//    static var previews: some View {
//        TestSelectedCellShape()
//    }
//}
