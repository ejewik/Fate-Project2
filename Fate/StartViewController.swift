//
//  StartViewController.swift
//  Fate
//
//  Created by Emily Jewik on 8/27/18.
//  Copyright © 2018 Emily Jewik. All rights reserved.
//

import Foundation
import UIKit

class StartViewController : UIViewController {
    
    @IBOutlet weak var newGameButton: UIButton!
    
    override func viewDidLoad() {
        
        self.newGameButton.layer.cornerRadius = 20.0
        self.navigationController?.navigationBar.barTintColor = UIColorFromRGB(rgbValue: 0x535353)
        
       // self.navigationController?.isNavigationBarHidden = true 
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
