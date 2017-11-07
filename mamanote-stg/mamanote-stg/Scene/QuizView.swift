//
//  QuizView.swift
//  mamanote-stg
//
//  Created by Takashima on 2017/11/06.
//  Copyright © 2017年 takattata. All rights reserved.
//

import SpriteKit

struct Quiz {
    var text: String
    var answer: [String]
    var correct: Int
}

class QuizView: SKNode {
    enum Result: Int {
        case Correct
        case Incorrect
        static let names = ["correct", "incorrect"]
    }
    enum Depth: CGFloat {
        case View = 10
        case Text = 11
        case Button = 12
        case Result = 13
    }

    private let buttonNum = 3

    var delegate: GameView?
    private var view: SKShapeNode
    private var resultSprites: [SKSpriteNode] = []
    private var textLabel = SKLabelNode(text: "")
    private var buttons: [Button] = []
    private var quiz: [Quiz] = []
    private var nowQuiz: Quiz?
    private var unselectedQuizIndex: [Int] = []
    private var validInput = true

    init(size: CGSize) {
        view = SKShapeNode(rect: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        super.init()

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
            buttons.append(createButton(at: i))
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show() {
        let selectIndex = Int.random(range: 0..<unselectedQuizIndex.count)
        let target = quiz[unselectedQuizIndex[selectIndex]]
        textLabel.text = target.text
        for i in (0..<buttonNum) {
            buttons[i].setText(target.answer[i])
        }
        nowQuiz = target
        unselectedQuizIndex.remove(at: selectIndex)
        run(SKAction.fadeIn(withDuration: 0.25))
    }

    func hide() {
        run(SKAction.fadeOut(withDuration: 0.25)) {
            self.validInput = true
            self.delegate?.hideQuiz()
        }
    }

    private func createButton(at index: Int) -> Button {
        let distance = view.frame.height/6
        let button = Button(at: CGPoint(x: view.frame.midX, y: distance*(index+1)), name: index.description, size: CGSize(width: view.frame.width*0.7, height: view.frame.height*0.1))
        button.zPosition = Depth.Button.rawValue
        button.tappedDelegate = self
        addChild(button)
        return button
    }

    private func createResult(name: String) -> SKSpriteNode {
        let sprite = SKSpriteNode(imageNamed: name)
        sprite.position = CGPoint(x: view.frame.midX, y: view.frame.midY)
        sprite.zPosition = Depth.Result.rawValue
        return sprite
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
                    var correctIndex = -1
                    for (i, answer) in answers.enumerated() {
                        if answer == lineArray[4] {
                            correctIndex = i
                        }
                    }
                    quiz.append(Quiz(text: lineArray[0], answer: answers, correct: correctIndex))
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}

extension QuizView: ButtonTappedDelegate {
    func tapped(_ name: String) {
        guard validInput else { return }
        let index = name == nowQuiz?.correct.description ? Result.Correct.rawValue : Result.Incorrect.rawValue
        let sprite = resultSprites[index]
        addChild(sprite)
        let action = SKAction.sequence([
            SKAction.fadeIn(withDuration: 0.2),
            SKAction.wait(forDuration: 0.5),
            SKAction.run(self.hide),
            SKAction.removeFromParent()
            ])
        validInput = false
        sprite.run(action)
    }
}
