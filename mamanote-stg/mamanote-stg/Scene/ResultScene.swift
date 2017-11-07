//
//  ResultScene.swift
//  mamanote-stg
//
//  Created by Takashima on 2017/11/07.
//  Copyright © 2017年 takattata. All rights reserved.
//

import SpriteKit

class ResultScene: SKScene {
    private let baby: SKSpriteNode
    private let message: SKLabelNode
    private let label = SKLabelNode(text: "タイトルに戻る")

    private let texts = [
        "fo",
        "foo",
        "fooo",
        "foooo",
        "fooooo",
    ]

    init(size: CGSize, babyIndex: Int) {
        baby = SKSpriteNode(imageNamed: ImageConstants.baby(babyIndex))
        message = SKLabelNode(text: "")
        super.init(size: size)

        message.text = texts[babyIndex]
        message.fontColor = .red
        label.fontColor = .red
        addChild(baby)
        addChild(message)
        addChild(label)
        scaleMode = .aspectFill
        backgroundColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        baby.setScale(0.5)
        baby.position = CGPoint(x: frame.midX, y: frame.midY)
        message.position = CGPoint(x: frame.midX, y: size.height*0.8)
        label.position = CGPoint(x: frame.midX, y: size.height*0.2)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let scene = TitleScene(size: size)
        scene.scaleMode = .aspectFill
        view?.presentScene(scene, transition: .flipVertical(withDuration: 0.5))
    }
}
