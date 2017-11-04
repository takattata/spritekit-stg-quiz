//
//  GameScene.swift
//  mamanote-stg
//
//  Created by Takashima on 2017/11/03.
//  Copyright © 2017年 takattata. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    private var baby = Baby()
    private var myCharacter = MyCharacter()
    private var isTapping = false
    private var touchLocation = CGPoint()

    override func didMove(to view: SKView) {
        backgroundColor = .white
        baby.configure(x: frame.midX, y: frame.midY*1.6)
        addChild(baby.node!)
        myCharacter.configure(x: frame.midX, y: frame.midY*0.1)
        addChild(myCharacter.node!)
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
        if isTapping {
            myCharacter.moveX(to: touchLocation.x)
            addChild(myCharacter.attack(maxY: size.height))
        }
    }
}
