//
//  QuestionController.swift
//  NewHorizon
//
//  Created by xcode on 01.10.16.
//  Copyright © 2016 NewHorizon. All rights reserved.
//

import Foundation
import Alamofire

class QuestionController: UIViewController {

    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var placeholder: UIView!
    @IBOutlet weak var backImage: UIImageView!
    
    let type = WebServer.QuestionType.ENUM
    var answer : Int = 0
    var done : Bool = false
    public var question : Question = Question()
    public var onQuestuionEnd : (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadImage(url: question.image)
        self.loadQuestion(question : question)
        self.placeholder.removeFromSuperview()
    }

    func loadQuestion(question : Question) {
        questionText.text = question.text
        button0.setTitle(question.answers[0], for: UIControlState.normal)
        button1.setTitle(question.answers[1], for: UIControlState.normal)
        button2.setTitle(question.answers[2], for: UIControlState.normal)
        button3.setTitle(question.answers[3], for: UIControlState.normal)
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
            onQuestuionEnd!()
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

