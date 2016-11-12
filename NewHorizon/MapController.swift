//
//  MapController.swift
//  NewHorizon
//
//  Created by xcode on 29.10.16.
//  Copyright © 2016 NewHorizon. All rights reserved.
//

import UIKit

class MapController: UIViewController {
    var screenWidth : CGFloat = 0
    var screenHeight : CGFloat = 0
    var regionsViews : Array<RegionImage> = []
    let regionImages = [ UIImage(named: "none"), UIImage(named: "none"),
                         UIImage(named: "player"), UIImage(named: "playerCapital"),
                         UIImage(named: "enemy"), UIImage(named: "enemyCapital") ]
    
    override func viewDidLoad() {
        let screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height

        let backImage = RegionImage(image: UIImage(named: "background")!)
        view.addSubview(backImage)
        
        backImage.translatesAutoresizingMaskIntoConstraints = false
        setPosition(backImage, x: 0, y: 0)
        setSize(backImage, w: 1.0, h: 1.0)
        
        self.view.layoutIfNeeded()
        
        backImage.touchDown = { image in
            self.updateMap()
        }
        
        updateMap()
    }
    
    func updateMap() {
        for region in regionsViews {
            region.removeFromSuperview();
        }
        
        WebServer.getMap() { map in
            for region in map.regions {
                self.loadRegion(region)
            }
        }
    }
    
    func loadRegion(_ region : Map.Region) {
        let id = region.owner * 2 + region.type
        let image = regionImages[id]
        let imageView = RegionImage(image: image!)
        regionsViews.append(imageView)
        view.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false

        setPosition(imageView, x: region.pos.x, y: region.pos.y)
        setSize(imageView, w: region.width, h: region.height)

        imageView.touchDown = { image in
            WebServer.attack(region: region.ID, onLoad: { question in
                let name = question.isEnum() ? "Question" : "Accuracy"
                let id = question.isEnum() ? "QUESTION_ID" : "ACCURACY_ID"

                let storyboard = UIStoryboard(name: name, bundle: nil)
                let ctrl = storyboard.instantiateViewController(withIdentifier: id)

                // TODO: Add interface for QuestiuonController
                if question.isEnum() {
                    let enumCtrl = ctrl as! QuestionController
                    enumCtrl.question = question
                    enumCtrl.onQuestuionEnd = self.updateMap
                } else {
                    let enumCtrl = ctrl as! AccuracyController
                    enumCtrl.question = question
                    enumCtrl.onQuestuionEnd = self.updateMap
                }
                self.present(ctrl, animated: true, completion: nil)
            })
        }

        self.view.layoutIfNeeded()
    }
    
    func setPosition(_ image : Any, x : Double, y : Double) {
        let _x = CGFloat(x) * screenWidth
        let _y = CGFloat(y) * screenHeight
        
        let xConst = NSLayoutConstraint(item: image, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: _x)
        let yConst = NSLayoutConstraint(item: image, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: _y)
        
        NSLayoutConstraint.activate([xConst, yConst])
    }
    
    func setSize(_ image : Any, w : Double, h : Double) {
        let _w = CGFloat(w) * screenWidth
        let _h = CGFloat(h) * screenHeight
        
        let width = NSLayoutConstraint(item: image, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: _w)
        let height = NSLayoutConstraint(item: image, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: _h)
        
        NSLayoutConstraint.activate([width, height])
    }
}
