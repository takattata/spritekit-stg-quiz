//
//  Enemy.swift
//  mamanote-stg
//
//  Created by Takashima on 2017/11/03.
//  Copyright © 2017年 takattata. All rights reserved.
//

import SpriteKit

class Enemy: SKSpriteNode {
    static let NAME = String(describing: Enemy.self)

    private var velocity: CGPoint

    init(at position: CGPoint, to direction: CGPoint, speed: CGFloat) {
        velocity = direction * speed
        let initTexture = SKTexture(imageNamed: ImageConstants.enemy)
        super.init(texture: initTexture, color: .white, size: initTexture.size())
        name = Enemy.NAME
        self.position = position
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    ///FIXME: 毎フレEnemyだけ探索して移動させる のと 範囲用のSquare周りに4つ置いて当たり判定で反転させるのとどっちが良い?.
    func move(area: CGRect) {
        position += velocity
        if position.x <= area.minX || position.x >= area.maxX {
            velocity.x *= -1
        }
        if position.y <= area.minY || position.y >= area.maxY {
            velocity.y *= -1
        }
    }
}
