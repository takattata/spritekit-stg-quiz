//
//  Bullet.swift
//  mamanote-stg
//
//  Created by Takashima on 2017/11/03.
//  Copyright © 2017年 takattata. All rights reserved.
//

import SpriteKit

class Bullet {
    static let NAME = String(describing: Bullet.self)

    private(set) var node: SKSpriteNode

    init(at position: CGPoint, maxY: CGFloat) {
        node = SKSpriteNode(imageNamed: ImageConstants.heart)
        node.name = Bullet.NAME
        node.position = position
        let actionMove = SKAction.move(to: CGPoint(x: position.x, y: position.y + maxY), duration: 4.0)
        let actionMoveDone = SKAction.removeFromParent()
        node.run(SKAction.sequence([actionMove, actionMoveDone]))

        node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width*0.4)
        node.physicsBody?.isDynamic = true
        node.physicsBody?.categoryBitMask = PhysicsCategory.Bullet
        node.physicsBody?.contactTestBitMask = PhysicsCategory.Baby | PhysicsCategory.Enemy
        node.physicsBody?.collisionBitMask = PhysicsCategory.None
        node.physicsBody?.usesPreciseCollisionDetection = true
    }
}
