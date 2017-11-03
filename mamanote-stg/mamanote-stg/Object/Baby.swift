//
//  Baby.swift
//  mamanote-stg
//
//  Created by Takashima on 2017/11/03.
//  Copyright © 2017年 takattata. All rights reserved.
//

import SpriteKit
import UIKit

class Baby: SKSpriteNode {
    private let MAX_HP = 200

    private var textures: [SKTexture] = []
    private var hp = 0

    func configure(x: CGFloat, y: CGFloat) {
        ImageConstants.babies.forEach { imageName in
            textures.append(SKTexture(imageNamed: imageName))
        }
        texture = textures.first
        position = CGPoint(x: x, y: y)
    }

    // RETURN: clear?.
    func recover() -> Bool {
        let preStatus = babyStatus()
        hp += 1
        if hp >= MAX_HP {
            return true
        }

        let status = babyStatus()
        if preStatus != status {
            texture = textures[status]
        }
        return false
    }

    private func babyStatus() -> Int {
        return hp / (MAX_HP / ImageConstants.babyCount)
    }
}
