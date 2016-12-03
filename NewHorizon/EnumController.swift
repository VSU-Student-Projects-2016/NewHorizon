//
//  EnumController.swift
//  NewHorizon
//
//  Created by xcode on 01.10.16.
//  Copyright © 2016 NewHorizon. All rights reserved.
//

import Foundation
import Alamofire

class EnumController: UIViewController, QuestionController {

    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var button0: Button!
    @IBOutlet weak var button1: Button!
    @IBOutlet weak var button2: Button!
    @IBOutlet weak var button3: Button!
    
    @IBOutlet weak var placeholder: UIView!
    @IBOutlet weak var backImage: UIImageView!
    
    @IBOutlet weak var progviewTimer: UIProgressView!
    
    let type = WebServer.QuestionType.ENUM
    var answer : Int = 0
    var done : Bool = false
    
    var _question : Question?
    var question : Question {
        get {
            return _question!;
        }
        
        set(value) {
            _question = value
        }
    }
    
    var questuionEnd : (() -> Void)?
    var onQuestuionEnd : (() -> Void) {
        get {
            return questuionEnd!
        }
        
        set(value) {
            questuionEnd = value
        }
    }
    
    func loadQuestion(question : Question) {
        questionText.text = question.text
        let buttons = [button0, button1, button2, button3]
        for i in 0...3 {
            buttons[i]?.setTitle(question.answers[i], for: UIControlState.normal)
            buttons[i]?.touchDown = { button in
                WebServer.sendAnswer(userAnswer: i) { correct in
                    self.didAnswerSend(correct)
                }
            }
        }
        tick()
    }
    
    var time = 0.0
    var timer: Timer!
    
    func tick()
    {
        timer = Timer.scheduledTimer(timeInterval: HIGH_USE_INTERVAL, target: self, selector: #selector(AccuracyController.setProgress), userInfo: nil, repeats: true)
    }
    
    func setProgress() {
        time += HIGH_USE_INTERVAL
        self.progviewTimer.progress = Float(time / 3.0)
        if time >= 3 {
            timer.invalidate()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadImage(url: question.image)
        self.loadQuestion(question : question)
        self.placeholder.removeFromSuperview()
    }
    
    func loadImage(url : String) {
        do {
            let urlData = URL(string: url)
            let data = try Data(contentsOf: urlData!)
            let image = UIImage(data: data)
            backImage.image = image
        } catch {
            print("Can't set image")
        }
    }
    
    func didAnswerSend(_ correct : Int) {
        let buttons = [button0, button1, button2, button3]
        buttons[answer - 1]?.backgroundColor = .red
        buttons[correct - 1]?.backgroundColor = .green
        done = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (done) {
            onQuestuionEnd()
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func answer1Touched(_ sender: UIButton) {
        answer = 1
        WebServer.sendAnswer(userAnswer: answer) { correct in
            self.didAnswerSend(correct)
        }
    }
    
    @IBAction func answer2Touched(_ sender: UIButton) {
        answer = 2
        WebServer.sendAnswer(userAnswer: answer) { correct in
            self.didAnswerSend(correct)
        }
    }
    
    @IBAction func answer3Touched(_ sender: UIButton) {
        answer = 3
        WebServer.sendAnswer(userAnswer: answer) { correct in
            self.didAnswerSend(correct)
        }
    }
    
    @IBAction func answer4Touched(_ sender: UIButton) {
        answer = 4
        WebServer.sendAnswer(userAnswer: answer) { correct in
            self.didAnswerSend(correct)
        }
    }
}

