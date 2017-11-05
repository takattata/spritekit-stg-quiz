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
    private let vx = 8.0

    init(x: CGFloat, y: CGFloat) {
        let initTexture = SKTexture(imageNamed: ImageConstants.myCharacter)
        super.init(texture: initTexture, color: .white, size: initTexture.size())
        name = MyCharacter.NAME
        position = CGPoint(x: x, y: y)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func moveX(to destination: CGFloat) {
        let distance = CGFloat(position.x < destination ? vx : -1*vx)
        position.x += distance
    }

    func attack(maxY: CGFloat) -> SKSpriteNode {
        return Bullet(at: position, maxY: maxY)
    }
}
