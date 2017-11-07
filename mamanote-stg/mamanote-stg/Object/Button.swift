//
//  Button.swift
//  mamanote-stg
//
//  Created by Takashima on 2017/11/07.
//  Copyright © 2017年 takattata. All rights reserved.
//

import SpriteKit

protocol ButtonTappedDelegate : class {
    func tapped(_ name: String)
}

class Button: SKNode {
    weak var tappedDelegate: ButtonTappedDelegate?

    private var shape: SKShapeNode
    private var shapeOver: SKShapeNode
    private var label: SKLabelNode

    init(at position: CGPoint, name: String, size: CGSize) {
        shape = SKShapeNode(rectOf: size)
        shapeOver = SKShapeNode(rectOf: size)
        label = SKLabelNode(text: "")
        super.init()

        self.name = name
        self.position = position
        shape.fillColor = .white
        shapeOver.fillColor = UIColor.blue.withAlphaComponent(0.3)
        shapeOver.isHidden = true
        label.fontColor = .black
        isUserInteractionEnabled = true
        addChild(shape)
        addChild(shapeOver)
        addChild(label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setText(_ text: String) {
        label.text = text
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        shapeOver.isHidden = false
        tappedDelegate?.tapped(name!)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        shapeOver.isHidden = true
    }
}
