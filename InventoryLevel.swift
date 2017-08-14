//
//  InventoryLevel.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 24/07/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit

class InventoryLevel: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var amount = 88
    var colorInventory = "Blue"
    
    
    
    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
       
        
        
        if (amount <= 99 && amount >= 1) {
            drawPathTo(context: context!, boundedBy: rect, color: colorInventory,percentaje: Int32(amount))
            print("llego")
            
        }
        

        
    }
    
    func drawPathTo(context: CGContext, boundedBy rect: CGRect, color: String , percentaje: Int32) {
        
        
            
        context.setFillColor(UIColor(red:252/255.0, green:225/255.0, blue:150/255.0, alpha: 1.0).cgColor)
        
        
        context.move(to: CGPoint(x:0  , y: rect.height / 2))
        
        context.addLine(to: CGPoint(x: rect.width * 19/20, y: rect.height))
        context.addLine(to: CGPoint(x: rect.width, y: 0))
        context.addLine(to: CGPoint(x: 0, y: 0))
        context.addLine(to: CGPoint(x: 0, y: rect.width / 2))
        context.fillPath()
        
        
        
        
    }
    
    

}
