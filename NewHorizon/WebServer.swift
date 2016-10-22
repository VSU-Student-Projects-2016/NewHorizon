//
//  WebServer.swift
//  NewHorizon
//
//  Created by xcode on 24.09.16.
//  Copyright © 2016 NewHorizon. All rights reserved.
//

import Alamofire

class WebServer {
    enum QuestionType {
        case ENUM, ACCURACY
    }
    
    static let URLs : [QuestionType: String] = [
        QuestionType.ENUM: "http://diadlo.dyndns.org:8888/HorizonQuiz",
        QuestionType.ACCURACY: "http://diadlo.dyndns.org:8888/HorizonQuiz/accuracyQuestion"
    ]
    
    static var sessionId : String = ""
    
    static func getQuestion(type: QuestionType, onLoad : @escaping (_ question : Question) -> Void) {
        let param : Parameters = ["sessionid" : sessionId]
        let url = URLs[type]
        
        Alamofire.request(url!, parameters: param).responseJSON { response in
            let headerFields = response.response?.allHeaderFields as? [String: String]
            let url = response.request?.url
            if (headerFields != nil && url != nil) {
                let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields!, for: url!)
                sessionId = getSessionId(cookies: cookies)
            }
            
            switch (response.result) {
            case .success(let JSON):
                let data = JSON as! NSDictionary
                let image = data["image"] as! String
                let text = data["text"] as! String
                let answers = data["answers"]
                var answersArray : Array<String>
                if (answers != nil) {
                    answersArray = data["answers"] as! Array<String>
                } else {
                    answersArray = [ ]
                }
                
                let question = Question(image: image, text: text, answers: answersArray)
                onLoad(question)
                break;
            case .failure(let error):
                print(error)
                break;
            }
        }
    }
    
    static func getSessionId(cookies : [HTTPCookie]) -> String {
        for cookie in cookies {
            if (cookie.name == "sesstionid") {
                return cookie.value
            }
        }
        
        return ""
    }
    
    static func sendAnswer(type: QuestionType, userAnswer : Int, onLoad : @escaping (_ result : Int) -> Void) {
        let url = URLs[type]
        let answerURL = url! + "/" + String(userAnswer)
        let param : Parameters = ["sessionid" : sessionId]
        
        Alamofire.request(answerURL, parameters: param).responseJSON { response in
            switch (response.result) {
            case .success(let JSON):
                let data = JSON as! NSDictionary
                var result : Int;
                if (data["correct"] == nil) {
                    result = data["delta"] as! Int
                } else {
                    result = data["correct"] as! Int
                }
                onLoad(result)
                break;
            case .failure(let error):
                print(error)
                break;
            }
        }
    }
}
