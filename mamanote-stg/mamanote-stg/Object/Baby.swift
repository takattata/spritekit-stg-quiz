//
//  Baby.swift
//  mamanote-stg
//
//  Created by Takashima on 2017/11/03.
//  Copyright © 2017年 takattata. All rights reserved.
//

import SpriteKit

class Baby: SKSpriteNode {
    static let NAME = String(describing: Baby.self)
    private let MAX_HP = 200

    private var textures: [SKTexture] = []
    private var hp = 0

    init(x: CGFloat, y: CGFloat) {
        let initTexture = SKTexture(imageNamed: ImageConstants.baby(0))
        super.init(texture: initTexture, color: .white, size: initTexture.size())
        name = Baby.NAME
        ImageConstants.babies.forEach { imageName in
            textures.append(SKTexture(imageNamed: imageName))
        }
        setScale(0.5)
        position = CGPoint(x: x, y: y)

        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = true
        physicsBody?.categoryBitMask = PhysicsCategory.Baby
        physicsBody?.contactTestBitMask = PhysicsCategory.Bullet
        physicsBody?.collisionBitMask = PhysicsCategory.None
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // RETURN: clear?.
    func recover() -> Bool {
        let preStatus = currentStatus()
        hp += 1
        if hp >= MAX_HP {
            return true
        }

        let status = currentStatus()
        if preStatus != status {
            texture = textures[status]
        }
        return false
    }

    func hpPercentage() -> Double {
        print(">>> hpPercentage: hp[\(hp.description)], Double(\((Double(hp) / Double(MAX_HP)).description))")
        return Double(hp) / Double(MAX_HP) * 100.0
    }

    func currentStatus() -> Int {
        return hp / (MAX_HP / ImageConstants.babyCount)
    }
}
