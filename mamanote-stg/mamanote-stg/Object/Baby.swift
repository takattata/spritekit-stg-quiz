//
//  Baby.swift
//  mamanote-stg
//
//  Created by Takashima on 2017/11/03.
//  Copyright © 2017年 takattata. All rights reserved.
//

import SpriteKit

class Baby {
    static let NAME = String(describing: Baby.self)
    private let MAX_HP = 200

    private(set) var node: SKSpriteNode
    private var textures: [SKTexture] = []
    private var hp = 0

    init(x: CGFloat, y: CGFloat) {
        ///FIXME: ...
        node = SKSpriteNode(imageNamed: ImageConstants.baby(0))
        node.name = Baby.NAME
        ImageConstants.babies.forEach { imageName in
            textures.append(SKTexture(imageNamed: imageName))
        }
        node.setScale(0.5)
        node.position = CGPoint(x: x, y: y)

        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.isDynamic = true
        node.physicsBody?.categoryBitMask = PhysicsCategory.Baby
        node.physicsBody?.contactTestBitMask = PhysicsCategory.Bullet
        node.physicsBody?.collisionBitMask = PhysicsCategory.None
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
            node.texture = textures[status]
        }
        return false
    }

    private func babyStatus() -> Int {
        return hp / (MAX_HP / ImageConstants.babyCount)
    }
}
