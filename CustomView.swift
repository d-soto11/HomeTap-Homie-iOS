//
//  CustomView.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 16/08/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
 

    var btnClos: UIButton?
    var blocks = 0
    var startBlock = 0
    var idService: String?
    
    
    
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.addCustomView()
        }
   
        required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)!
            fatalError("init(coder:) has not been implemented")
        }
        
        func addCustomView() {
           
            self.btnClos = UIButton()
            self.btnClos?.frame=CGRect(x: (self.frame.width-30), y: 2, width: 20, height: 20)
            self.btnClos?.setTitle("x", for: UIControlState.normal)
            self.btnClos?.addTarget(CalendarViewController(), action: #selector(CalendarViewController.deleteReserv(sender:)), for: .touchUpInside)
            self.addSubview(self.btnClos!)
            self.backgroundColor = K.UI.main_color
            self.roundCorners(radius: K.UI.special_round_px)
        
        }
    
    
    
    func startDate() -> Date {
      return Date()
    }
    
    
    
    func endDate() -> Date {
        return Date()
    }
    
    
    
    
}
