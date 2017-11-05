//
//  QuizView.swift
//  mamanote-stg
//
//  Created by Takashima on 2017/11/06.
//  Copyright © 2017年 takattata. All rights reserved.
//

import SpriteKit

class QuizView: SKNode {
    private let depth: CGFloat = 100.0
    private var view: SKShapeNode

    init(size: CGSize) {
        view = SKShapeNode(rect: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        super.init()

        view.fillColor = UIColor.black.withAlphaComponent(0.4)
        view.zPosition = depth
        addChild(view)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show() {
        run(SKAction.fadeIn(withDuration: 0.25))
    }

    func hide(completion: @escaping ()->Void) {
        run(SKAction.fadeOut(withDuration: 0.25)) {
            completion()
        }
    }
    //    override init(size: CGSize) {
//        super.init(size: size)
//
//        anchorPoint = CGPoint(x: 0.5, y: 0.5)
//        scaleMode = .resizeFill
//        backgroundColor = UIColor.blue.withAlphaComponent(0.4)
//        overlay.backgroundNode.run(SKAction.fadeIn(withDuration: 0.25))
//        oldValue?.backgroundNode.run(SKAction.fadeOut(withDuration: 0.25)) {
//            oldValue?.backgroundNode.removeFromParent()
//        }
//    }
}
