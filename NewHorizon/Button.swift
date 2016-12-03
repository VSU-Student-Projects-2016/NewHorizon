//
//  Button.swift
//  NewHorizon
//
//  Created by xcode on 26.11.16.
//  Copyright © 2016 NewHorizon. All rights reserved.
//

import Foundation
import UIKit

class Button: UIButton {
    var touchDown: ((_ image: Button) -> ())?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:)")
    }
    
    init() {
        let nonFrame = CGRect(x: 0, y: 0, width: 10, height: 10);
        super.init(frame: nonFrame)
        
        adjustsImageWhenHighlighted = false;
        addTarget(self, action: #selector(Button.touchDown(sender:)), for: [.touchDown, .touchDragEnter])
    }
    
    func touchDown(sender: Button) {
        touchDown?(sender)
    }
}
