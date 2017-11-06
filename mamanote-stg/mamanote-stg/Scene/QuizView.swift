//
//  QuizView.swift
//  mamanote-stg
//
//  Created by Takashima on 2017/11/06.
//  Copyright © 2017年 takattata. All rights reserved.
//

import SpriteKit
import UIKit

struct Quiz {
    var text: String
    var answer: [String]
    var correct: String
}

class QuizView: SKNode {
    enum Result: Int {
        case Correct
        case Incorrect
        static let names = ["correct", "incorrect"]
    }
    enum Depth: CGFloat {
        case View = 100
        case Text = 101
        case Result = 102
    }

    private let buttonNum = 3

    private var delegate: GameView?
    private var view: SKShapeNode
    private var resultSprites: [SKSpriteNode] = []
    private var textLabel = SKLabelNode(text: "")
    private var buttons: [UIButton] = []
    private var quiz: [Quiz] = []
    private var nowQuiz: Quiz?
    private var unselectedQuizIndex: [Int] = []

    init(with scene: SKScene) {
        view = SKShapeNode(rect: CGRect(x: 0, y: 0, width: scene.size.width, height: scene.size.height))
        super.init()

        delegate = scene as? GameView
        load()
        for i in (0..<quiz.count) {
            unselectedQuizIndex.append(i)
        }
        view.fillColor = UIColor.black.withAlphaComponent(0.4)
        view.zPosition = Depth.View.rawValue
        addChild(view)
        let distance = view.frame.height/6
        ///FIXME: widthっぽいのでは無理だった. 
        textLabel.position = CGPoint(x: view.frame.midX, y: distance*5)
        textLabel.zPosition = Depth.Text.rawValue
        addChild(textLabel)
        Result.names.forEach { resultSprites.append(createResult(name: $0)) }
        for i in (0..<buttonNum) {
            buttons.append(createButton(on: scene, at: i))
        }
        setButtonStatus(enabled: false)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show() {
        let selectIndex = Int.random(range: 0..<unselectedQuizIndex.count)
        nowQuiz = quiz[unselectedQuizIndex[selectIndex]]
        textLabel.text = nowQuiz?.text
        for i in (0..<buttonNum) {
            buttons[i].setTitle(nowQuiz?.answer[i], for: .normal)
        }
        unselectedQuizIndex.remove(at: selectIndex)
        run(SKAction.fadeIn(withDuration: 0.25)) {
            self.setButtonStatus(enabled: true)
        }
    }

    func hide() {
        setButtonStatus(enabled: false)
        run(SKAction.fadeOut(withDuration: 0.25)) {
            self.delegate?.hideQuiz()
        }
    }

    private func createButton(on scene: SKScene, at index: Int) -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width*0.7, height: view.frame.height*0.1))
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.red, for: .highlighted)
        let distance = view.frame.height/6
        button.layer.position = CGPoint(x: view.frame.midX, y: view.frame.height-distance*(index+1))
        button.addTarget(self, action: #selector(QuizView.onTapButton), for: .touchUpInside)
        scene.view?.addSubview(button)
        return button
    }

    private func createResult(name: String) -> SKSpriteNode {
        let sprite = SKSpriteNode(imageNamed: name)
        sprite.position = CGPoint(x: view.frame.midX, y: view.frame.midY)
        sprite.zPosition = Depth.Result.rawValue
        return sprite
    }

    private func setButtonStatus(enabled: Bool) {
        buttons.forEach { button in
            button.isHidden = !enabled
            button.isEnabled = enabled
        }
    }

    @objc private func onTapButton(_ sender: UIButton) {
        let index = sender.title(for: .normal) == nowQuiz?.correct ? Result.Correct.rawValue : Result.Incorrect.rawValue
        let sprite = resultSprites[index]
        addChild(sprite)
        let action = SKAction.sequence([
                        SKAction.fadeIn(withDuration: 0.4),
                        SKAction.wait(forDuration: 0.7),
                        SKAction.run(self.hide),
                        SKAction.removeFromParent()
                      ])
        sprite.run(action)
    }

    private func load() {
        if let csvPath = Bundle.main.path(forResource: "quiz", ofType: "csv") {
            do {
                let csv = try String(contentsOfFile:csvPath, encoding:String.Encoding.utf8)
                let linesArray = csv.components(separatedBy: .newlines)
                linesArray.forEach { line in
                    if line.isEmpty { return }
                    let lineArray = line.components(separatedBy: CharacterSet(charactersIn: ","))
                    let answers = [lineArray[1], lineArray[2], lineArray[3]]
                    quiz.append(Quiz(text: lineArray[0], answer: answers, correct: lineArray[4]))
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}
