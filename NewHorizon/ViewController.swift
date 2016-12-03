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

public extension CGPoint {
    public static func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}

public extension CGRect {
    public static func +(lhs: CGRect, rhs: CGPoint) -> CGRect {
        return CGRect(origin: lhs.origin + rhs, size: lhs.size)
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var btnInst: UIButton!
    @IBOutlet weak var labelMusic: UILabel!
    @IBOutlet weak var btnSlideDown: UIButton!
    @IBOutlet weak var settingView: UIView!
    @IBOutlet weak var viewNewHorizon: UIImageView!
    @IBOutlet weak var btnCountOfGames: UIButton!
    @IBOutlet weak var btnNewGame: UIButton!
    @IBOutlet weak var constraintLeading: NSLayoutConstraint!
    @IBOutlet weak var constraintBottomSlide: NSLayoutConstraint!
    
    var settingsPresent = false;
    
    @IBAction func btnSlideDownMenu(_ sender: AnyObject) {
        UIView.animate(withDuration: 0.5, animations: {
            
            self.btnCountOfGames.isHidden = false;
            // Направление перемещения
            let direction : CGFloat = self.settingsPresent ? 1.0 : -1.0;

            let btnMovingValue = self.settingView.frame.height - self.constraintBottomSlide.constant
            let viewMovingValue = self.settingView.frame.height
            
            self.btnSlideDown.frame = self.btnSlideDown.frame + CGPoint(x: 0, y: direction * btnMovingValue)
            self.settingView.frame = self.settingView.frame + CGPoint(x: 0, y: direction * viewMovingValue)
            self.btnSlideDown.transform = CGAffineTransform(scaleX: 1.0, y: direction)

            self.settingsPresent = !self.settingsPresent;
            
        }) { (result: Bool) in
            if result {
                if self.settingsPresent {
                    self.btnCountOfGames.isHidden = true;
                }
            }
        }
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // width of switch
        let width = 2 * self.btnInst.frame.width + self.constraintLeading.constant

        // add switch
        let music = BetterSegmentedControl(
            frame: CGRect(x: 232.0, y: 390.0, width: width, height: 30.0),
            titles: ["НЕТ", "ДА"],
            index: 1,
            backgroundColor: UIColor.black,
            titleColor: .black,
            indicatorViewBackgroundColor: UIColor.white,
            selectedTitleColor: .black
        )
         
        music.titleFont = UIFont(name: "HelveticaNeue", size: 20.0)!
        music.selectedTitleFont = UIFont(name: "HelveticaNeue-Medium", size: 20.0)!
        music.addTarget(self, action: #selector(controlValueChanged(_:)), for: .valueChanged)
        self.settingView.addSubview(music)
         
        music.translatesAutoresizingMaskIntoConstraints = false
        
        // add constraints for switch
        let trailingConstraint = NSLayoutConstraint(item: music, attribute: .trailing, relatedBy: .equal, toItem: btnInst, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(item: music, attribute: .top, relatedBy: .equal, toItem: labelMusic, attribute: .top, multiplier: 1.0, constant: 0.0)
         
        let widthConstraint = NSLayoutConstraint(item: music, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width)
        let heightConstraint = NSLayoutConstraint(item: music, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
         
        NSLayoutConstraint.activate([topConstraint, trailingConstraint, widthConstraint, heightConstraint])
        self.settingView.layoutIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // add constraints for settingsView
        let height = self.view.frame.size.height - self.viewNewHorizon.frame.size.height
            - self.btnSlideDown.frame.size.height //+ self.constraintBottomSlide.constant
    
        let viewHeightConstraint = NSLayoutConstraint(item: settingView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: height)
        let viewBottomConstraint = NSLayoutConstraint(item: settingView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: height)
        //let viewTopConstraint = NSLayoutConstraint(item: settingView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: height)
        
        NSLayoutConstraint.activate([viewHeightConstraint, viewBottomConstraint]) 
    }
}

