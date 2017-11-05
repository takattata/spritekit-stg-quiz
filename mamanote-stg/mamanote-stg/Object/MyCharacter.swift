//
//  MyCharacter.swift
//  mamanote-stg
//
//  Created by Takashima on 2017/11/03.
//  Copyright © 2017年 takattata. All rights reserved.
//

import SpriteKit

class MyCharacter: SKSpriteNode {
    static let NAME = String(describing: MyCharacter.self)
    private let attackLimit = 6
    private let vx = 8.0

    private var attackLimitCounter = 0
    private var isDamaged = false

    init(x: CGFloat, y: CGFloat) {
        let initTexture = SKTexture(imageNamed: ImageConstants.myCharacter)
        super.init(texture: initTexture, color: .white, size: initTexture.size())
        name = MyCharacter.NAME
        position = CGPoint(x: x, y: y)
        ///TEMP:
        setScale(1.5)

        physicsBody = SKPhysicsBody(circleOfRadius: size.width*0.4)
        physicsBody?.isDynamic = true
        physicsBody?.categoryBitMask = PhysicsCategory.MyCharacter
        physicsBody?.contactTestBitMask = PhysicsCategory.Enemy
        physicsBody?.collisionBitMask = PhysicsCategory.None
        physicsBody?.usesPreciseCollisionDetection = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func moveX(to destination: CGFloat) {
        let distance = CGFloat(position.x < destination ? vx : -1*vx)
        position.x += distance
    }

    func attack(maxY: CGFloat) -> SKSpriteNode {
        attackLimitCounter = 0
        return Bullet(at: position, maxY: maxY)
    }

    ///FIXME: remove scene.
    func update(with scene: SKScene, tap: CGPoint?) {
        if isDamaged { return }
        if let tap = tap {
            attackLimitCounter += 1
            moveX(to: tap.x)
            if attackLimitCounter >= attackLimit {
                scene.addChild(attack(maxY: scene.size.height))
            }
        }
    }

    func damage() {
        isDamaged = true
        run(SKAction.repeat(
            SKAction.sequence([
                SKAction.hide(),
                SKAction.wait(forDuration: 0.2),
                SKAction.unhide(),
                SKAction.wait(forDuration: 0.2)]),
            count: 4)) {
                self.isDamaged = false
        }
    }
}
