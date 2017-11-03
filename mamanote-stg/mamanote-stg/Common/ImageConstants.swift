//
//  ImageConstants.swift
//  mamanote-stg
//
//  Created by Takashima on 2017/11/03.
//  Copyright © 2017年 takattata. All rights reserved.
//

import Foundation

struct ImageConstants {
    static let babyClose = "baby_close"
    static let babyOpen = "baby_open"
    static let heart = "heart"

    static let babyCount = 5
    static let baby = { (id: Int) -> String in
        return "baby-\(id.description)"
    }
    static var babies: [String] {
        var array: [String] = []
        for i in (0..<babyCount) {
            array.append(baby(i))
        }
        return array
    }
}
