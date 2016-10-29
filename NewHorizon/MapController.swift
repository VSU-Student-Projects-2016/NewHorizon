//
//  MapController.swift
//  NewHorizon
//
//  Created by xcode on 29.10.16.
//  Copyright © 2016 NewHorizon. All rights reserved.
//

import UIKit

class MapController: UIViewController {
    @IBOutlet weak var backImage: UIImageView!
    
    let screenWidth = 667.0
    let screenHeight = 375.0
    
    override func viewDidLoad() {
        WebServer.getMap() { map in
            self.loadImage(url: map.backgroundUrl)
            for region in map.regions {
                self.loadRegion(region)
            }
        }
    }
    
    func loadImage(url : String) {
        do {
            let urlData = URL(string: url)
            let data = try Data(contentsOf: urlData!)
            let image = UIImage(data: data)
            backImage.image = image
        } catch {
            print("Can't set image")
        }
    }
    
    func loadRegion(_ region : Map.Region) {
        do {
            let urlData = URL(string: region.imageUrl)
            let data = try Data(contentsOf: urlData!)
            let image = UIImage(data: data)
            let imageView = UIImageView(image: image)
            view.addSubview(imageView)
    
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            setPosition(imageView, x: region.pos.x, y: region.pos.y)
            setSize(imageView, w: region.width, h: region.height)
            
            self.view.layoutIfNeeded()
        } catch {
            print("Can't set image")
        }
    }
    
    func setPosition(_ image : UIImageView, x : Double, y : Double) {
        let _x = x * screenWidth
        let _y = y * screenHeight
        
        let xConst = NSLayoutConstraint(item: image, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: CGFloat(_x))
        let yConst = NSLayoutConstraint(item: image, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: CGFloat(_y))
        
        NSLayoutConstraint.activate([xConst, yConst])
    }
    
    func setSize(_ image : UIImageView, w : Double, h : Double) {
        let _w = w * screenWidth
        let _h = h * screenHeight
        
        let width = NSLayoutConstraint(item: image, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: CGFloat(_w))
        let height = NSLayoutConstraint(item: image, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: CGFloat(_h))
        
        NSLayoutConstraint.activate([width, height])
    }
}
