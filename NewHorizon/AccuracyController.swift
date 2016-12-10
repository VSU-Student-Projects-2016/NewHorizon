//
//  EnumController.swift
//  NewHorizon
//
//  Created by xcode on 01.10.16.
//  Copyright © 2016 NewHorizon. All rights reserved.
//

import Foundation
import Alamofire

let HIGH_USE_INTERVAL : TimeInterval = 1/60
let TIME_FOR_QUESTION = 5.0

class AccuracyController: UIViewController, QuestionController {

    @IBOutlet weak var questionText: UILabel!
    
    @IBOutlet weak var placeholder: UIView!
    @IBOutlet weak var backImage: UIImageView!
    
    @IBOutlet weak var correctAnswer: UILabel!
    
    @IBOutlet weak var btn1: Button!
    @IBOutlet weak var btn2: Button!
    @IBOutlet weak var btn3: Button!
    @IBOutlet weak var btn4: Button!
    @IBOutlet weak var btn5: Button!
    @IBOutlet weak var btn6: Button!
    @IBOutlet weak var btn7: Button!
    @IBOutlet weak var btn8: Button!
    @IBOutlet weak var btn9: Button!
    @IBOutlet weak var btn0: Button!
    @IBOutlet weak var answerField: UILabel!
    
    @IBAction func btnDelClick(_ sender: AnyObject) {
        let text = self.answerField.text
        if !(text!.isEmpty) {
            self.answerField.text = text?.substring(to: (text!.index(before: (text!.endIndex))))
            if (text?.characters.count == 1) {
                let startIndex = text?.startIndex
                let firstLetter = text?.characters[startIndex!]
                if (firstLetter == "-") {
                    self.answerField.text = ""
                }
            }
        }
    }
    
    @IBAction func btnMinusClick(_ sender: AnyObject) {
        let text = self.answerField.text
        if !(text!.isEmpty) {
            let startIndex = text?.startIndex
            let firstLetter = text?.characters[startIndex!]
            if (firstLetter != "-") {
                self.answerField.text?.insert("-", at: startIndex!)
            }
            else {
                self.answerField.text?.remove(at: startIndex!)
            }
        }
        else {
            self.answerField.text = "-"
        }
    }
    
    @IBOutlet weak var constraintDistBetweenButtons: NSLayoutConstraint!
    @IBOutlet weak var constraintButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var labelQuestion: UILabel!
    
    @IBOutlet weak var progviewTimer: UIProgressView!
    
    let type = WebServer.QuestionType.ACCURACY
    var answer : Int = 0
    var done : Bool = false
    public var question : Question = Question()

    var questuionEnd : (() -> Void)?
    var onQuestuionEnd : (() -> Void) {
        get {
            return questuionEnd!
        }
        
        set(value) {
            questuionEnd = value
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leading = (UIScreen.main.bounds.width - self.constraintButtonWidth.constant * 6 - self.constraintDistBetweenButtons.constant * 5) / 2
        let leadingConstraint = NSLayoutConstraint(item: btn1, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: leading)
        
        NSLayoutConstraint.activate([leadingConstraint]) 
        self.view.layoutIfNeeded()
        self.loadQuestion(question : question)
        self.placeholder.removeFromSuperview()
        
        let buttons = [btn0, btn1, btn2, btn3, btn4, btn5, btn6, btn7, btn8, btn9]
        
        for i in 0...9 {
            buttons[i]?.touchDown = { button in
                let text = self.answerField.text
                if (text?.characters.count)! < 10 {
                    self.answerField.text = text! + String(i)
                }
            }
        }
    }
    
    var time = 0.0
    var timer: Timer!
    
    func tick() {
        timer = Timer.scheduledTimer(timeInterval: HIGH_USE_INTERVAL, target: self, selector: #selector(AccuracyController.setProgress), userInfo: nil, repeats: true)
    }
    
    func setProgress() {
        time += HIGH_USE_INTERVAL
        self.progviewTimer.progress = Float(time / TIME_FOR_QUESTION)
        if time >= TIME_FOR_QUESTION {
            timer.invalidate()
        }
    }
    
    func loadQuestion(question : Question) {
        questionText.text = question.text
        tick()
    }
    
    @IBAction func onAnswerTouch(_ sender: UIButton) {
        answer = Int(answerField.text!)!
        WebServer.sendAnswer(userAnswer: answer) { correct in
            self.didAnswerSend(correct)
        }
    }
    
    func didAnswerSend(_ correct : Int) {
        correctAnswer.text = String(correct)
        done = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (done) {
            onQuestuionEnd();
            self.dismiss(animated: true)
        }
    }
}

