//
//  WebServer.swift
//  NewHorizon
//
//  Created by xcode on 24.09.16.
//  Copyright © 2016 NewHorizon. All rights reserved.
//

import Alamofire

class WebServer {
    static func getQuestion(question : Int, onLoad : @escaping (_ question : Question) -> Void) {
        let urlString = "http://diadlo.dyndns.org/NewHorizon/question.php?q=" + String(question)
        Alamofire.request(urlString).responseJSON { response in
            switch (response.result) {
            case .success(let JSON):
                let data = JSON as! NSDictionary
                let image = data["image"] as! String
                let text = data["text"] as! String
                let answers = data["answers"] as! Array<String>
                let question = Question(image: image, text: text, answers: answers)
                onLoad(question)
                break;
            case .failure(let error):
                print(error)
                break;
            }
        }
    }
}
