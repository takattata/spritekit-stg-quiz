//
//  TitleScene.swift
//  mamanote-stg
//
//  Created by Takashima on 2017/11/03.
//  Copyright © 2017年 takattata. All rights reserved.
//

import SpriteKit
import UIKit

class TitleScene: SKScene {
    private var label: SKLabelNode = SKLabelNode(text: "タップしてスタート！")

    override func didMove(to view: SKView) {
        backgroundColor = .white
        let babyTextures = [SKTexture(imageNamed: ImageConstants.babyClose), SKTexture(imageNamed: ImageConstants.babyOpen)]
        let babyNode = SKSpriteNode(texture: babyTextures.first)
        babyNode.position = CGPoint(x: frame.midX, y: frame.midY*1.2)
        babyNode.setScale(3.0)
        let animation = SKAction.animate(with: babyTextures, timePerFrame: 0.5)
        babyNode.run(SKAction.repeatForever(animation))
        addChild(babyNode)

        label.fontColor = .red
        label.fontSize = 30.0
        label.position = CGPoint(x: frame.midX, y: frame.midY*0.5)
        addChild(label)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let scene = SKScene(fileNamed: "GameScene") {
            scene.scaleMode = .aspectFill
            view?.presentScene(scene)
        }
    }

    override func update(_ currentTime: TimeInterval) {
    }
}
