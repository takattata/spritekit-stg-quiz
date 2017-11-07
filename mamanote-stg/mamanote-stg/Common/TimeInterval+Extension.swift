//
//  TimeInterval+Extension.swift
//  mamanote-stg
//
//  Created by Takashima on 2017/11/07.
//  Copyright © 2017年 takattata. All rights reserved.
//

import Foundation

extension TimeInterval {
    func string() -> String {
        let components = NSDateComponents()
        components.second = Int(max(0.0, self))
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]
        return formatter.string(from: components as DateComponents)!
    }
}
