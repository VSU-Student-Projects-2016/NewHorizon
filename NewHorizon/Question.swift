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
    var answers : Array<String> = [""]
    
    public init(image : String, text : String, answers : Array<String>) {
        self.image = image
        self.text = text
        self.answers = answers
    }
}
