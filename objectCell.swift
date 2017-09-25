//
//  objectCell.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 29/07/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit

class objectCell: NSObject {
    
    
    var hour : String = " "
    var month : String = " "
    var day : Int = 0
    var name :String = " "
    var lastName : String = " "
    var imageClient : String = ""
    var price : String = " "
    var idService : String = " "
    var holdName : String = " "
    var date: Date?
    var state: Int?
    
    public init(brief: Service){
        
        price = String(Int(brief.price!)) + "COP"
        
        date = brief.date!
        let calendar = Calendar.current
        
        let monthTemp = calendar.component(.month, from: brief.date!)
        let dayTemp = calendar.component(.day, from: brief.date!)
        
        if monthTemp == 1{
            month = "JAN"
        }
        if monthTemp == 2{
            month = "FEB"
        }
        if monthTemp == 3{
            month = "MAR"
        }
        if monthTemp == 4{
            month = "APR"
        }
        if monthTemp == 5{
            month = "MAY"
        }
        if monthTemp == 6{
            month = "JUN"
        }
        if monthTemp == 7{
            month = "JUL"
        }
        if monthTemp == 8{
            month = "AUG"
        }
        if monthTemp == 9{
            month = "SEP"
        }
        if monthTemp == 10{
            month = "OCT"
        }
        if monthTemp == 11{
            month = "NOV"
        }
        if monthTemp == 12{
            month = "DIC"
        }
        
        day = dayTemp
        
        hour = (brief.date?.toString(format: .Time))!
        
        let nameTemp = brief.briefName
        
        var fullNameArr = nameTemp?.components(separatedBy: " ")
        
        if fullNameArr?.count == 4 {
            name = (fullNameArr?[0])! + " " + (fullNameArr?[1])!
            lastName = (fullNameArr?[2])! + " " + (fullNameArr?[3])!
        }
        if fullNameArr?.count == 3 {
            name = (fullNameArr?[0])!
            lastName = (fullNameArr?[1])! + " " + (fullNameArr?[2])!
            
        }
        if fullNameArr?.count == 2 {
            name = (fullNameArr?[0])!
            lastName = (fullNameArr?[1])!
            
        }
        
        imageClient = brief.briefPhoto!
        
        idService = brief.uid!
        
        if let s = brief.state {
        state = s
        }
        
        
        
    }
    
    
    
}
