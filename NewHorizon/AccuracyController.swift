//
//  QuestionController.swift
//  NewHorizon
//
//  Created by xcode on 01.10.16.
//  Copyright © 2016 NewHorizon. All rights reserved.
//

import Foundation
import Alamofire

class AccuracyController: UIViewController {

    @IBOutlet weak var questionText: UILabel!
    
    @IBOutlet weak var placeholder: UIView!
    @IBOutlet weak var backImage: UIImageView!
    
    @IBOutlet weak var answerField: UITextField!
    @IBOutlet weak var correctAnswer: UILabel!
    
    let type = WebServer.QuestionType.ACCURACY
    var answer : Int = 0
    var done : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WebServer.getQuestion(type: type) { question in
            self.loadImage(url: question.image)
            self.loadQuestion(question : question)
            self.placeholder.removeFromSuperview()
        }
    }
    
    func loadQuestion(question : Question) {
        questionText.text = question.text
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
    
    @IBAction func onAnswerChanged(_ sender: UITextField) {
        answer = Int(answerField.text!)!
        WebServer.sendAnswer(type: type, userAnswer: answer) { correct in
            self.didAnswerSend(correct)
        }
    }
    
    
    @IBAction func onAnswerTouch(_ sender: UIButton) {
        answer = Int(answerField.text!)!
        WebServer.sendAnswer(type: type, userAnswer: answer) { correct in
            self.didAnswerSend(correct)
        }
    }
    
    func didAnswerSend(_ correct : Int) {
        correctAnswer.text = String(correct)
        //buttons[answer - 1]?.backgroundColor = .red
        //buttons[correct - 1]?.backgroundColor = .green
        done = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (done) {
            self.dismiss(animated: true)
        }
    }
}

