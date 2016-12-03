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
    
    @IBOutlet weak var answerField: UITextField!
    @IBOutlet weak var correctAnswer: UILabel!
    
    @IBOutlet weak var btnOneDigit: UIButton!
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
        let leadingConstraint = NSLayoutConstraint(item: btnOneDigit, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: leading)
        
        NSLayoutConstraint.activate([leadingConstraint]) 
        self.view.layoutIfNeeded()
        self.loadQuestion(question : question)
        self.placeholder.removeFromSuperview()
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

