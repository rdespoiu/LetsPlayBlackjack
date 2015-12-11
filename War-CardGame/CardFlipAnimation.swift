//
//  CardFlipAnimation.swift
//  Blackjack
//
//  Created by Roberto Despoiu on 11/27/15.
//  Copyright © 2015 Roberto Despoiu. All rights reserved.
//

import Foundation
import UIKit

class CardFlipAnimation: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func playFlipAnimation(imageArray: Array<UIImage>) {
        /*
        self.image = UIImage(named: "cardback2.png")
        self.animationImages = nil
        
        var imgArray = [UIImage]()
        
        for var x = 1; x<=8/*x <= 12*/; x++ {
            let img = UIImage(named: "img\(x).png")
            imgArray.append(img!)
        }*/
        
        self.animationImages = imageArray
        self.animationDuration = 0.2
        self.animationRepeatCount = 1
        self.startAnimating()
        
        
    }

}
