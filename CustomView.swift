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
    var idBlockeDB : String?
    var lableEstado: UILabel?
    
    
    
    
    
    
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
            
            
            
            
            self.lableEstado = UILabel()
            self.lableEstado?.textColor = UIColor.white
            self.lableEstado?.font = UIFont(name: "Rubik-Light", size: 13)
            self.lableEstado?.text = "Disponible"
            self.lableEstado?.textAlignment = .center
            
        self.lableEstado?.translatesAutoresizingMaskIntoConstraints = false
            
            self.addSubview(self.lableEstado!)
            
            
            
            let xConstraint = NSLayoutConstraint(item: self.lableEstado!, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
            
            let yConstraint = NSLayoutConstraint(item: self.lableEstado!, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
            
            
            NSLayoutConstraint.activate([ xConstraint, yConstraint])
        
        }
    
    
    
    func startDate() -> Date {
        
      return Date()
    }
    
    
    
    func endDate() -> Date {
        return Date()
    }
    
    
    
    
}
