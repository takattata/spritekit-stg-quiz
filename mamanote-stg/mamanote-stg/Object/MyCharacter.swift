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

    private(set) var node: SKSpriteNode?

    func configure(x: CGFloat, y: CGFloat) {
        node = SKSpriteNode(imageNamed: ImageConstants.myCharacter)
        node?.position = CGPoint(x: x, y: y)
    }

    func moveX(to destination: CGFloat) {
        if let x = node?.position.x {
            let distance = CGFloat(x < destination ? vx : -1*vx)
            node?.position.x += distance
        }
    }

    func attack(maxY: CGFloat) -> SKSpriteNode {
        ///TESTME: to closure.
        let heart = SKSpriteNode(imageNamed: ImageConstants.heart)
        heart.position = (node?.position)!
        let actionMove = SKAction.move(to: CGPoint(x: heart.position.x, y: heart.position.y + maxY), duration: 4.0)
        let actionMoveDone = SKAction.removeFromParent()
        heart.run(SKAction.sequence([actionMove, actionMoveDone]))
        return heart
    }
}
