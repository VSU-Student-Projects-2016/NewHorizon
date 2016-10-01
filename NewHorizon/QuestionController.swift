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
    
    @IBOutlet weak var backImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WebServer.getQuestion() { question in
            self.loadImage(url: question.image)
        }
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

