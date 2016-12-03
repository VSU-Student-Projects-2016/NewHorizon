//
//  QuestionController.swift
//  NewHorizon
//
//  Created by xcode on 19.11.16.
//  Copyright © 2016 NewHorizon. All rights reserved.
//

import Foundation
import UIKit

protocol QuestionController {
    var onQuestuionEnd : (() -> Void) { get set }
    var question : Question { get set }
    
    func loadQuestion(question : Question)
}
