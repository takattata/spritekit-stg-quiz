//
//  CGPoint+Extension.swift
//  mamanote-stg
//
//  Created by Takashima on 2017/11/05.
//  Copyright © 2017年 takattata. All rights reserved.
//

import SpriteKit

extension CGPoint {
    static func * (left: CGPoint, right: CGFloat) -> CGPoint {
        return CGPoint(x: left.x*right, y: left.y*right)
    }
    static func * (left: CGFloat, right: CGPoint) -> CGPoint {
        return CGPoint(x: right.x*left, y: right.y*left)
    }

    static func += (left: inout CGPoint, right: CGPoint) {
        left.x = left.x+right.x
        left.y = left.y+right.y
    }

    static func random(min: CGPoint, max: CGPoint) -> CGPoint {
        let x = CGFloat.random(min: min.x, max: max.x)
        let y = CGFloat.random(min: min.y, max: max.y)
        return CGPoint(x: x, y: y)
    }
    static func random(at area: CGSize) -> CGPoint {
        return random(min: CGPoint(x: 0, y: 0), max: CGPoint(x: area.width, y: area.height))
    }
}
