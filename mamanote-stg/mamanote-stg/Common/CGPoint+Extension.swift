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
}
