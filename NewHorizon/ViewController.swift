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
        let name = "Accuracy"//arc4random() % 2 == 0 ? "Question" : "Accuracy"
        let id = "ACCURACY_ID"//arc4random() % 2 == 0 ? "QUESTION_ID" : "ACCURACY_ID"
        
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let ctrl = storyboard.instantiateViewController(withIdentifier: id)
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
        
        let _constraintLeading = NSLayoutConstraint(item: labelMusic, attribute: .leading, relatedBy: .equal, toItem: _switch, attribute: .leading, multiplier: 1.0, constant: 0.0)
        //let _margins = view.layoutMarginsGuide
        //_switch.bottomAnchor.constraint(equalTo: _margins.bottomAnchor).activate = true;
        
        let _constraintBottom = NSLayoutConstraint(item: _switch, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 8.0)
        //let _constraintBottom = NSLayoutConstraint(item: _switch, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 8)
        self.view!.addConstraints([_constraintLeading, _constraintBottom])
    }
}

