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
    @IBOutlet weak var btnInst: UIButton!
    
    @IBAction func OnNewGameTouch(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "MapView", bundle: nil)
        let ctrl = storyboard.instantiateViewController(withIdentifier: "MAP_ID")
        self.present(ctrl, animated: true, completion: nil)
        
        return
        
//        let rand = arc4random() % 2
//        let name = rand == 0 ? "Question" : "Accuracy"
//        let id = rand == 0 ? "QUESTION_ID" : "ACCURACY_ID"
        
//        let storyboard = UIStoryboard(name: name, bundle: nil)
//        let ctrl = storyboard.instantiateViewController(withIdentifier: id)
//        self.present(ctrl, animated: true, completion: nil)
    }
    
    func controlValueChanged(_ value: Int)
    {
        print(value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: split on methods
        let music = BetterSegmentedControl(
            frame: CGRect(x: 232.0, y: 370.0, width: 90.0, height: 20.0),
            titles: ["НЕТ", "ДА"],
            index: 1,
            backgroundColor: UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.00),
            titleColor: .white,
            indicatorViewBackgroundColor: UIColor(red:0.00, green:0.00, blue:0.00, alpha:1.00),
            selectedTitleColor: .white)
        music.titleFont = UIFont(name: "HelveticaNeue", size: 20.0)!
        music.selectedTitleFont = UIFont(name: "HelveticaNeue-Medium", size: 20.0)!
        music.addTarget(self, action: #selector(ViewController.controlValueChanged(_:)), for: .valueChanged)
        view.addSubview(music)
        
        music.translatesAutoresizingMaskIntoConstraints = false

        let leadingConstraint = NSLayoutConstraint(item: labelMusic, attribute: .leading, relatedBy: .equal, toItem: music, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: music, attribute: .bottom, relatedBy: .equal, toItem: btnInst, attribute: .bottom, multiplier: 1.0, constant: 0.0)

        let widthConstraint = NSLayoutConstraint(item: music, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 90)
        let heightConstraint = NSLayoutConstraint(item: music, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)

        let verticalSpacingConstraint = NSLayoutConstraint(item: labelMusic, attribute: .bottom, relatedBy: .equal, toItem: music, attribute: .top, multiplier: 1.0, constant: -4.0)
        
        NSLayoutConstraint.activate([bottomConstraint, leadingConstraint, widthConstraint, heightConstraint, verticalSpacingConstraint])
        self.view.layoutIfNeeded()
    }
}

