//
//  MyCharacter.swift
//  mamanote-stg
//
//  Created by Takashima on 2017/11/03.
//  Copyright © 2017年 takattata. All rights reserved.
//

import SpriteKit

class MyCharacter {
    private let vx = 8.0

    private(set) var node: SKSpriteNode

    init(x: CGFloat, y: CGFloat) {
        node = SKSpriteNode(imageNamed: ImageConstants.myCharacter)
        node.position = CGPoint(x: x, y: y)
    }

    func moveX(to destination: CGFloat) {
        let distance = CGFloat(node.position.x < destination ? vx : -1*vx)
        node.position.x += distance
    }

    func attack(maxY: CGFloat) -> SKSpriteNode {
        return Bullet(at: node.position, maxY: maxY).node
    }
}
