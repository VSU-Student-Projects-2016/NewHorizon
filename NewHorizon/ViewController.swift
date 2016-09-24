//
//  ViewController.swift
//  NewHorizon
//
//  Created by xcode on 24.09.16.
//  Copyright © 2016 NewHorizon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage(url: "http://diadlo.dyndns.org/NewHorizon/images/first.jpg")
    }

    func loadImage(url : String) {
        do {
            let urlData = URL(string: url)
            let data = try Data(contentsOf: urlData!)
            backImage.image = UIImage(data: data)
        } catch {
            print("Can't set image")
        }
    }

}

