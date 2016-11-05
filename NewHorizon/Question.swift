//
//  Question.swift
//  NewHorizon
//
//  Created by xcode on 24.09.16.
//  Copyright © 2016 NewHorizon. All rights reserved.
//

import Foundation

class Question {
    var image : String = ""
    var text : String = ""
    var answers : Array<String> = []
    
    public init() {
        
    }
    
    public init(image : String, text : String, answers : Array<String>) {
        self.image = image
        self.text = text
        self.answers = answers
    }
    
    public init(_ data: [String: Any]) {
        image = data["image"] as! String
        text = data["text"] as! String
        let answersData = data["answers"]
        if (answersData != nil) {
            answers = data["answers"] as! Array<String>
        } else {
            answers = []
        }
    }
    
    public func isEnum() -> Bool {
        return !answers.isEmpty
    }
}
