//
//  SKNode+Extension.swift
//  mamanote-stg
//
//  Created by Takashima on 2017/11/05.
//  Copyright © 2017年 takattata. All rights reserved.
//

import SpriteKit

extension SKNode {
    func findNodes(with name: String) -> [SKNode]! {
        return children.filter { $0.name == name }
    }
}
