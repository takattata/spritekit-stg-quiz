//
//  Bullet.swift
//  mamanote-stg
//
//  Created by Takashima on 2017/11/03.
//  Copyright © 2017年 takattata. All rights reserved.
//

import SpriteKit

class Bullet: SKSpriteNode {
    static let NAME = String(describing: Bullet.self)

    init(at position: CGPoint, maxY: CGFloat) {
        let initTexture = SKTexture(imageNamed: ImageConstants.heart)
        super.init(texture: initTexture, color: .white, size: initTexture.size())
        name = Bullet.NAME
        self.position = position
        let actionMove = SKAction.move(to: CGPoint(x: position.x, y: position.y + maxY), duration: 4.0)
        let actionMoveDone = SKAction.removeFromParent()
        run(SKAction.sequence([actionMove, actionMoveDone]))

        physicsBody = SKPhysicsBody(circleOfRadius: size.width*0.4)
        physicsBody?.isDynamic = true
        physicsBody?.categoryBitMask = PhysicsCategory.Bullet
        physicsBody?.contactTestBitMask = PhysicsCategory.Baby | PhysicsCategory.Enemy
        physicsBody?.collisionBitMask = PhysicsCategory.None
        physicsBody?.usesPreciseCollisionDetection = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
