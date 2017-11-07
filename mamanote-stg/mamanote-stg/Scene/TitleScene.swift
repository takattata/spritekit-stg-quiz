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
    override init(size: CGSize) {
        super.init(size: size)

        scaleMode = .aspectFill
        backgroundColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        let babyTextures = [SKTexture(imageNamed: ImageConstants.babyClose), SKTexture(imageNamed: ImageConstants.babyOpen)]
        let babyNode = SKSpriteNode(texture: babyTextures.first)
        babyNode.position = CGPoint(x: frame.midX, y: frame.midY*1.2)
        babyNode.setScale(3.0)
        let animation = SKAction.animate(with: babyTextures, timePerFrame: 0.5)
        babyNode.run(SKAction.repeatForever(animation))
        addChild(babyNode)
        let label = SKLabelNode(text: "タップしてスタート！")
        label.fontColor = .red
        label.fontSize = 30.0
        label.position = CGPoint(x: frame.midX, y: frame.midY*0.5)
        addChild(label)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let scene = GameScene(size: frame.size)
        scene.scaleMode = .aspectFill
        view?.presentScene(scene, transition: .crossFade(withDuration: 0.5))
    }

    override func update(_ currentTime: TimeInterval) {
    }
}
