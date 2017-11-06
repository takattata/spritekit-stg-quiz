//
//  CGFloat+Extension.swift
//  mamanote-stg
//
//  Created by Takashima on 2017/11/05.
//  Copyright © 2017年 takattata. All rights reserved.
//

import SpriteKit

extension CGFloat {
    static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * (max - min) + min
    }

    static func * (left: CGFloat, right: Int) -> CGFloat {
        return left * CGFloat(right)
    }
}
