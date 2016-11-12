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
            onQuestuionEnd!();
            self.dismiss(animated: true)
        }
    }
}

