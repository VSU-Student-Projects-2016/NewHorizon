//
//  SettingsViewController.swift
//  NewHorizon
//
//  Created by xcode on 29.10.16.
//  Copyright © 2016 NewHorizon. All rights reserved.
//

import UIKit
import BetterSegmentedControl

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var labelMusic: UILabel!
    @IBOutlet weak var btnInst: UIButton!
    
    func controlValueChanged(_ value: Int)
    {
        print(value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add switch
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
        music.addTarget(self, action: #selector(controlValueChanged(_:)), for: .valueChanged)
        view.addSubview(music)
        
        music.translatesAutoresizingMaskIntoConstraints = false
        
        // add constraints for switch
        let leadingConstraint = NSLayoutConstraint(item: labelMusic, attribute: .leading, relatedBy: .equal, toItem: music, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: music, attribute: .bottom, relatedBy: .equal, toItem: btnInst, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        let widthConstraint = NSLayoutConstraint(item: music, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 90)
        let heightConstraint = NSLayoutConstraint(item: music, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
        
        let verticalSpacingConstraint = NSLayoutConstraint(item: labelMusic, attribute: .bottom, relatedBy: .equal, toItem: music, attribute: .top, multiplier: 1.0, constant: -4.0)
        
        NSLayoutConstraint.activate([bottomConstraint, leadingConstraint, widthConstraint, heightConstraint, verticalSpacingConstraint])
        self.view.layoutIfNeeded()
    }
}
