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
    static let Enemy: UInt32 = 0b10
    static let Bullet: UInt32 = 0b100
    static let MyCharacter: UInt32 = 0b1000
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    private var baby: Baby?
    private var myCharacter: MyCharacter?
    private var touchLocation: CGPoint?
    private var enemyMoveArea: CGRect?

    override func didMove(to view: SKView) {
        backgroundColor = .white
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self

        baby = Baby(x: frame.midX, y: frame.midY*1.6)
        addChild(baby!)
        myCharacter = MyCharacter(x: frame.midX, y: frame.midY*0.1)
        addChild(myCharacter!)
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(addEnemy),
                SKAction.wait(forDuration: 3.0)
                ])),
            withKey: Enemy.ADD_ENEMY_ACTION)
        ///FIXME: 視認用.
        let enemyMoveAreaTop = (baby?.size.height)!
        let enemyMoveAreaHeight = size.height-enemyMoveAreaTop
        enemyMoveArea = CGRect(x: 0, y: 0, width: size.width, height: enemyMoveAreaHeight)
        let shapeNode = SKShapeNode(rect: enemyMoveArea!)
        shapeNode.fillColor = UIColor.blue.withAlphaComponent(0.3)
        addChild(shapeNode)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        touchLocation = touch.location(in: self)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        touchLocation = touch.location(in: self)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchLocation = nil
    }

    override func update(_ currentTime: TimeInterval) {
        ///NOTE: touchesMovedだと止まったままタップしている時に途中で認識されなくなった.
//        if let myCharacter = myCharacter, isTapping {
//            attackLimitCounter += 1
//            myCharacter.moveX(to: touchLocation.x)
//            if attackLimitCounter >= ATTACK_LIMIT {
//                addChild(myCharacter.attack(maxY: size.height))
//                attackLimitCounter = 0
//            }
//        }
        if let myCharacter = myCharacter {
            myCharacter.update(with: self, tap: touchLocation)
        }

        let enemies = findNodes(with: Enemy.NAME)
        enemies?.forEach { enemy in
            if let enemy = enemy as? Enemy {
                enemy.move(area: enemyMoveArea!)
            }
        }
    }

    func didBegin(_ contact: SKPhysicsContact) {
        let physicsBodies = sortPhysicsCategory(with: contact)
        guard let first = physicsBodies.0.node as? SKSpriteNode, let second = physicsBodies.1.node as? SKSpriteNode else { return }

        if (physicsBodies.0.categoryBitMask & PhysicsCategory.Baby != 0) && (physicsBodies.1.categoryBitMask & PhysicsCategory.Bullet != 0) {
            didCollide(bullet: second, baby: first)
        }
        if (physicsBodies.0.categoryBitMask & PhysicsCategory.Enemy != 0) && (physicsBodies.1.categoryBitMask & PhysicsCategory.Bullet != 0) {
            didCollide(bullet: second, enemy: first)
        }
        if (physicsBodies.0.categoryBitMask & PhysicsCategory.Enemy != 0) && (physicsBodies.1.categoryBitMask & PhysicsCategory.MyCharacter != 0) {
            didCollide(myCharacter: second, enemy: first)
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
        bullet.removeFromParent()
        if let baby = self.baby {
            if baby.recover() {
                print(">>> CLEAR!!!")
            }
        }
    }

    private func didCollide(bullet: SKSpriteNode, enemy: SKSpriteNode) {
        print(">>> HIT: " + #function)
        bullet.removeFromParent()
        enemy.removeFromParent()
    }

    private func didCollide(myCharacter: SKSpriteNode, enemy: SKSpriteNode) {
        print(">>> HIT: " + #function)
        self.myCharacter?.damage()
        enemy.removeFromParent()
    }

    private func addEnemy() {
        guard let enemyMoveArea = enemyMoveArea else { return }
        let direction = CGPoint.random(min: CGPoint(x: -1.0, y: -1.0), max: CGPoint(x: 1.0, y: 1.0))
        ///FIXME: -enemyWidth*0.5, +.
        let respawnX = direction.x < 0 ? 0 : size.width
        let respawnAt = CGPoint(x: respawnX, y: CGFloat.random(min: 0, max: enemyMoveArea.size.height))
        let enemy = Enemy(at: respawnAt, to: direction, speed: CGFloat.random(min: 1.0, max: 4.0))
        addChild(enemy)
    }
}
