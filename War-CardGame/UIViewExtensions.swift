//
//  UIViewExtensions.swift
//  Blackjack
//
//  Created by Roberto Despoiu on 11/29/15.
//  Copyright © 2015 Roberto Despoiu. All rights reserved.
//

import UIKit

extension UIView {
    func slideFromRight(duration: NSTimeInterval = 0.2, completionDelegate: AnyObject? = nil) {
        
        //CATransition Animation
        let slidefromRightTransition = CATransition()
        
        //Set callback delegate to the completionDelegate parameter (if any is provided)
        if let delegate: AnyObject = completionDelegate {
            slidefromRightTransition.delegate = delegate
        }
        
        //Customize animation properties
        slidefromRightTransition.type = kCATransitionPush
        slidefromRightTransition.subtype = kCATransitionFromRight
        slidefromRightTransition.duration = duration
        slidefromRightTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)//InEaseOut)
        slidefromRightTransition.fillMode = kCAFillModeRemoved
        
        //Add animation to View's layer
        self.layer.addAnimation(slidefromRightTransition, forKey: "slideFromRightTransition")
        
    }
    
    func slideFromLeft(duration: NSTimeInterval = 0.2, completionDelegate: AnyObject? = nil) {
        let slidefromLeftTransition = CATransition()
        
        if let delegate: AnyObject = completionDelegate {
            slidefromLeftTransition.delegate = delegate
        }
        
        slidefromLeftTransition.type = kCATransitionPush
        slidefromLeftTransition.subtype = kCATransitionFromLeft
        slidefromLeftTransition.duration = duration
        slidefromLeftTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        slidefromLeftTransition.fillMode = kCAFillModeRemoved
        
        self.layer.addAnimation(slidefromLeftTransition, forKey: "slideFromLeftTransition")
        
    }
    
    func slideToTop(duration: NSTimeInterval = 0.2, completionDelegate: AnyObject? = nil) {
        let slideToTopTransition = CATransition()
        
        if let delegate: AnyObject = completionDelegate {
            slideToTopTransition.delegate = delegate
        }
        
        slideToTopTransition.type = kCATransitionReveal
        slideToTopTransition.subtype = kCATransitionFromTop
        slideToTopTransition.duration = duration
        slideToTopTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        slideToTopTransition.fillMode = kCAFillModeRemoved
        
        self.layer.addAnimation(slideToTopTransition, forKey: "slideToTopTransition")
        
    }
    
    func messageSlider(duration: NSTimeInterval = 0.2, completionDelegate: AnyObject? = nil) {
        let messageSliderTransition = CATransition()
        
        if let delegate: AnyObject = completionDelegate {
            messageSliderTransition.delegate = delegate
        }
        
        messageSliderTransition.type = kCATransitionPush
        messageSliderTransition.subtype = kCATransitionFromRight
        messageSliderTransition.duration = duration
        messageSliderTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        messageSliderTransition.fillMode = kCAFillModeRemoved
        
        self.layer.addAnimation(messageSliderTransition, forKey: "messageSliderTransition")
    }
    
    func fadeIn(duration: NSTimeInterval = 0.15) {
        self.alpha = 0.0
        UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.alpha = 1.0
            }, completion: nil)
    }
    
    func fadeOut(duration: NSTimeInterval = 0.30, delay: NSTimeInterval = 0.3) {
        self.alpha = 1.0
        UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.alpha = 0.0
            }, completion: nil)
    }
    

}
