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
        QuestionType.ENUM: "http://diadlo.dyndns.org:8888/quiz/",
        QuestionType.ACCURACY: "http://diadlo.dyndns.org:8888/quiz/"
    ]
    
    static let gameUrl = "http://diadlo.dyndns.org:8888/quiz/"
    static let mapUrl = "http://diadlo.dyndns.org:8888/map/"
    static let initUrl = "http://diadlo.dyndns.org:8888/"
    static var sessionId : String = ""
    
    static func attack(region: Int, onLoad : @escaping (_ question : Question) -> Void) {
        let param : Parameters = ["sessionid" : sessionId]
        let url = gameUrl + String(region)
        
        print(url + " : " + sessionId)
        Alamofire.request(url, parameters: param).responseJSON { response in
            switch (response.result) {
            case .success(let JSON):
                let data = JSON as! [String: Any]
                let question = Question(data)
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
            if (cookie.name == "sessionid") {
                return cookie.value
            }
        }
        
        return ""
    }
    
    static func sendAnswer(userAnswer : Int,
        onLoad : @escaping (_ correct : Int) -> Void) {

        let answerURL = gameUrl + String(userAnswer)
        let param : Parameters = ["sessionid" : sessionId]
        
        print(answerURL + " : " + sessionId)
        
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
    
    static func getMap(onLoad: @escaping (_ map: Map) -> Void) {
        let param : Parameters = ["sessionid" : sessionId]
        let url = sessionId == "" ? initUrl : mapUrl
        
        
        print(url + " : " + sessionId)
        Alamofire.request(url, parameters: param).responseJSON { response in
            let headerFields = response.response?.allHeaderFields as? [String: String]
            let url = response.request?.url
            if (headerFields != nil && url != nil) {
                let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields!, for: url!)
                sessionId = getSessionId(cookies: cookies)
            }
            
            switch (response.result) {
            case .success(let JSON):
                let data = JSON as! NSDictionary
                let map = Map(data)
                onLoad(map)
                break;
            case .failure(let error):
                print(error)
                break;
            }
        }
    }
}
