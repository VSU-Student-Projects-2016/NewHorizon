//
//  WebServer.swift
//  NewHorizon
//
//  Created by xcode on 24.09.16.
//  Copyright © 2016 NewHorizon. All rights reserved.
//

import Alamofire

class WebServer {
    static let enumURL : String = "http://diadlo.dyndns.org:8888/HorizonQuiz"
    static var sessionId : String = ""
    
    static func getEnumQuestion(onLoad : @escaping (_ question : Question) -> Void) {
        let param : Parameters = ["sessionid" : sessionId]
        
        Alamofire.request(enumURL, parameters: param).responseJSON { response in
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
    
    static func getSessionId(cookies : [HTTPCookie]) -> String {
        for cookie in cookies {
            if (cookie.name == "sesstionid") {
                return cookie.value
            }
        }
        
        return ""
    }
    
    static func sendEnumAnswer(_ userAnswer : Int, onLoad : @escaping (_ right : Int) -> Void) {
        let answerURL = "\(enumURL)/\(userAnswer)"
        let param : Parameters = ["sessionid" : sessionId]
        
        Alamofire.request(answerURL, parameters: param).responseJSON { response in
            switch (response.result) {
            case .success(let JSON):
                let data = JSON as! NSDictionary
                let correct = data["correct"] as! Int
                onLoad(correct)
                break;
            case .failure(let error):
                print(error)
                break;
            }
        }
    }
}
