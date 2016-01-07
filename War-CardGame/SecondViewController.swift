//
//  SecondViewController.swift
//  Blackjack
//
//  Created by Roberto Despoiu on 12/17/15.
//  Copyright © 2015 Roberto Despoiu. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPressed(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    

}