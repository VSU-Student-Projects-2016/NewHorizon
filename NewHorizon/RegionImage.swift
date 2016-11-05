//
//  RegionImage.swift
//  NewHorizon
//
//  Created by xcode on 05.11.16.
//  Copyright © 2016 NewHorizon. All rights reserved.
//

import Foundation
import UIKit

class RegionImage: UIButton {
    var touchDown: ((_ image: RegionImage) -> ())?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    init(image: UIImage) {
        let nonFrame = CGRect();
        super.init(frame: nonFrame)
        
        setImage(image, for: [.normal])
        adjustsImageWhenHighlighted = false;
        addTarget(self, action: #selector(RegionImage.touchDown(sender:)), for: [.touchDown, .touchDragEnter])
    }
    
    func touchDown(sender: RegionImage) {
        touchDown?(sender)
    }
}
