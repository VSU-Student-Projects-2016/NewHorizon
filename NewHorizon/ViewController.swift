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
    
    func controlValueChanged(_ value: Int)
    {
        print(value)
    }
    
    @IBAction func OnNewGameTouch(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "MapView", bundle: nil)
        let ctrl = storyboard.instantiateViewController(withIdentifier: "MAP_ID")
        self.present(ctrl, animated: true, completion: nil)
        
        return
    }
    
    @IBAction func btnSlideMenu(_ sender: AnyObject) {
        //view.addSubview(SettingsViewController.vi)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add switch
        let music = BetterSegmentedControl(
         frame: CGRect(x: 232.0, y: 390.0, width: 100.0, height: 30.0),
         titles: ["НЕТ", "ДА"],
         index: 1,
         backgroundColor: UIColor(red:0.00, green:0.00, blue:0.00, alpha:1.00),
         titleColor: .black,
         indicatorViewBackgroundColor: UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.00),
         selectedTitleColor: .black)
         
         music.titleFont = UIFont(name: "HelveticaNeue", size: 20.0)!
         music.selectedTitleFont = UIFont(name: "HelveticaNeue-Medium", size: 20.0)!
         music.addTarget(self, action: #selector(controlValueChanged(_:)), for: .valueChanged)
         view.addSubview(music)
         
         music.translatesAutoresizingMaskIntoConstraints = false
         
         // add constraints for switch
         let trailingConstraint = NSLayoutConstraint(item: music, attribute: .trailing, relatedBy: .equal, toItem: btnInst, attribute: .trailing, multiplier: 1.0, constant: 0.0)
         let topConstraint = NSLayoutConstraint(item: music, attribute: .top, relatedBy: .equal, toItem: labelMusic, attribute: .top, multiplier: 1.0, constant: 0.0)
         
         let widthConstraint = NSLayoutConstraint(item: music, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
         let heightConstraint = NSLayoutConstraint(item: music, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
         
         //let verticalSpacingConstraint = NSLayoutConstraint(item: labelMusic, attribute: .bottom, relatedBy: .equal, toItem: music, attribute: .top, multiplier: 1.0, constant: -4.0)
         
         NSLayoutConstraint.activate([topConstraint, trailingConstraint, widthConstraint, heightConstraint]) 
         self.view.layoutIfNeeded()
    }
}

