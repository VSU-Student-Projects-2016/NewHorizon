//
//  ViewController.swift
//  NewHorizon
//
//  Created by xcode on 24.09.16.
//  Copyright © 2016 NewHorizon. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBAction func OnNewGameTouch(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Question", bundle: nil)
        let ctrl = storyboard.instantiateViewController(withIdentifier: "QUESTION_ID")
        self.present(ctrl, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

