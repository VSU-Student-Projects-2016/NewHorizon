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
    
    @IBOutlet weak var backImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WebServer.getEnumQuestion() { question in
            self.loadImage(url: question.image)
            self.loadQuestion(question : question)
        }
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
    
}

