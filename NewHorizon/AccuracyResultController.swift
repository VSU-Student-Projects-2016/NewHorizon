//
//  AccuracyResultController.swift
//  NewHorizon
//
//  Created by xcode on 10.12.16.
//  Copyright © 2016 NewHorizon. All rights reserved.
//

import Foundation
import UIKit

class AccuracyResultController: UIViewController {
    
    @IBOutlet weak var labelMyResult: UILabel!
    @IBOutlet weak var labelEnemyResult: UILabel!
    @IBOutlet weak var labelCorrectAnswer: UILabel!
    
    @IBOutlet weak var constraintMyResLeading: NSLayoutConstraint!
    @IBOutlet weak var constraintEnemyResLeading: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
