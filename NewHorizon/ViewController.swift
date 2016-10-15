//
//  ViewController.swift
//  NewHorizon
//
//  Created by xcode on 24.09.16.
//  Copyright © 2016 NewHorizon. All rights reserved.
//

import UIKit
import Alamofire
import BetterSegmentedControl

class ViewController: UIViewController {

    @IBOutlet weak var labelMusic: UILabel!
    
    @IBAction func OnNewGameTouch(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Question", bundle: nil)
        let ctrl = storyboard.instantiateViewController(withIdentifier: "QUESTION_ID")
        self.present(ctrl, animated: true, completion: nil)
    }
    
    func controlValueChanged(_ value: Int)
    {
        print(value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let _switch = BetterSegmentedControl(
            frame: CGRect(x: 232.0, y: 370.0, width: 90.0, height: 33.0),
            titles: ["НЕТ", "ДА"],
            index: 1,
            backgroundColor: UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.00),
            titleColor: .white,
            indicatorViewBackgroundColor: UIColor(red:0.00, green:0.00, blue:0.00, alpha:1.00),
            selectedTitleColor: .white)
        _switch.titleFont = UIFont(name: "HelveticaNeue", size: 20.0)!
        _switch.selectedTitleFont = UIFont(name: "HelveticaNeue-Medium", size: 20.0)!
        _switch.addTarget(self, action: #selector(ViewController.controlValueChanged(_:)), for: .valueChanged)
        view.addSubview(_switch)
        
        //labelMusic.addConstraint(<#T##constraint: NSLayoutConstraint##NSLayoutConstraint#>)
    }
}

