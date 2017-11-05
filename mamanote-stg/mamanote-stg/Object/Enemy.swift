//
//  Enemy.swift
//  mamanote-stg
//
//  Created by Takashima on 2017/11/03.
//  Copyright © 2017年 takattata. All rights reserved.
//

import SpriteKit

class Enemy {
    static let NAME = String(describing: Enemy.self)

    private(set) var node: SKSpriteNode
    private var direction: CGPoint
    private var speed: CGFloat

    init(at position: CGPoint, to direction: CGPoint, speed: CGFloat) {
        node = SKSpriteNode(imageNamed: ImageConstants.enemy)
        node.name = Enemy.NAME
        node.position = position
        self.direction = direction
        self.speed = speed
    }

    ///FIXME: 毎フレEnemyだけ探索して移動させる のと 範囲用のSquare周りに4つ置いて当たり判定で反転させるのとどっちが良い?.
    func move(area: CGRect) {
        let velocity: CGPoint = direction * speed
        node.position += velocity
        if node.position.x <= area.minX || node.position.x >= area.maxX {
            direction.x *= -1
        }
        if node.position.y <= area.minY || node.position.y >= area.maxY {
            direction.y *= -1
        }
    }
}
