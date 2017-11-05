//
//  GameScene.swift
//  mamanote-stg
//
//  Created by Takashima on 2017/11/03.
//  Copyright © 2017年 takattata. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory {
    static let None: UInt32 = 0
    static let All: UInt32 = .max
    static let Baby: UInt32 = 0b1
    static let Bullet: UInt32 = 0b10
    static let MyCharacter: UInt32 = 0b100
    static let Enemy: UInt32 = 0b1000
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    private let ATTACK_LIMIT = 6

    private var baby: Baby?
    private var myCharacter: MyCharacter?
    private var isTapping = false
    private var touchLocation = CGPoint()
    private var attackLimitCounter = 0

    override func didMove(to view: SKView) {
        backgroundColor = .white
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self

        baby = Baby(x: frame.midX, y: frame.midY*1.6)
        addChild(baby!)
        myCharacter = MyCharacter(x: frame.midX, y: frame.midY*0.1)
        addChild(myCharacter!)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        touchLocation = touch.location(in: self)
        isTapping = true
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        touchLocation = touch.location(in: self)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        touchLocation = touch.location(in: self)
        isTapping = false
    }

    override func update(_ currentTime: TimeInterval) {
        ///FIXME: touchesMovedだと止まったままタップしている時に途中で認識されなくなる.
        if let myCharacter = myCharacter, isTapping {
            attackLimitCounter += 1
            myCharacter.moveX(to: touchLocation.x)
            if attackLimitCounter >= ATTACK_LIMIT {
                addChild(myCharacter.attack(maxY: size.height))
                attackLimitCounter = 0
            }
        }
//
//        let enemies = findNodes(with: Enemy.NAME)
//        enemies?.forEach { enemy in
//            if let enemy = enemy as?
//        }
    }

    func didBegin(_ contact: SKPhysicsContact) {
        let physicsBodies = sortPhysicsCategory(with: contact)
        guard let first = physicsBodies.0.node as? SKSpriteNode, let second = physicsBodies.1.node as? SKSpriteNode else { return }

        if (physicsBodies.0.categoryBitMask & PhysicsCategory.Baby != 0) && (physicsBodies.1.categoryBitMask & PhysicsCategory.Bullet != 0) {
            didCollide(bullet: second, baby: first)
        }
    }

    private func sortPhysicsCategory(with contact: SKPhysicsContact) -> (SKPhysicsBody, SKPhysicsBody) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        return (firstBody, secondBody)
    }

    private func didCollide(bullet: SKSpriteNode, baby: SKSpriteNode) {
        print(">>> HIT: " + #function)
        bullet.removeFromParent()
        if let baby = self.baby {
            if baby.recover() {
                print(">>> CLEAR!!!")

            }
        }
    }
}
