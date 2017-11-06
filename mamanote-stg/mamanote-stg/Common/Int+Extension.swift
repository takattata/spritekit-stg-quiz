//
//  Int+Extension.swift
//  mamanote-stg
//
//  Created by Takashima on 2017/11/06.
//  Copyright © 2017年 takattata. All rights reserved.
//

import Foundation

extension Int {
    static func random(range: Range<Int>) -> Int {
        let rangeLength = range.upperBound - range.lowerBound
        let random = arc4random_uniform(UInt32(rangeLength))
        return Int(random) + range.lowerBound
    }
}
