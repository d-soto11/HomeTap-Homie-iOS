//
//  Calendar.swift
//  Hometap
//
//  Created by Daniel Soto on 7/14/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import Foundation

class HTCBlock: HometapObject {
    public override init(dict: [String : AnyObject]) {
        super.init(dict: dict)
        
        print("Diccionario del bloque :" + dict.description
        )
        if let startHour = dict["initialTime"] {
            self.startHour = Date(fromString: startHour as! String, withFormat: .Custom("HH:mm"))
        }
        if let endHour = dict["finalTime"] {
            self.endHour = Date(fromString: endHour as! String, withFormat: .Custom("HH:mm"))
        }
        if let date = dict["date"] {
            self.date = Date(fromString: date as! String, withFormat: .Custom("yyyy-MM-dd"))
        }
        if let serviceID = dict["serviceID"] {
            self.serviceID = (serviceID as? String)
        }
        if let homie = dict["homieID"] {
            self.homieID = homie as? String
        }
        if let id = dict["id"] {
            self.uid = id as? String
        }
    }
    
    public func prepareForSave() -> [String:AnyObject] {
        if self.startHour != nil {
            original_dictionary["initialTime"] = self.startHour!.toString(format: .Custom("HH:mm")) as AnyObject
        }
        if self.endHour != nil {
            original_dictionary["finalTime"] = self.endHour!.toString(format: .Custom("HH:mm")) as AnyObject
        }
        if self.date != nil {
            original_dictionary["date"] = self.date!.toString(format: .Custom("yyyy-MM-dd")) as AnyObject
        }
        if self.serviceID != nil {
            original_dictionary["serviceID"] = self.serviceID as AnyObject
        }
        if self.homieID != nil {
            original_dictionary["homieID"] = self.homieID as AnyObject
        }
        if self.uid != nil {
            original_dictionary["id"] = self.uid as AnyObject
        }
        
        return original_dictionary
    }
    
    var startHour: Date?
    var endHour: Date?
    var date: Date?
    var serviceID : String?
    var homieID : String?
    
    public func service(callback: @escaping (_:Service?)->Void) -> Bool{
        if let id_service = original_dictionary["serviceID"] as? String {
            Service.withID(id: id_service, callback: {(service) in
                callback(service)
            })
            return true
        }
        
        return false
    }
    
    public func UiBlocks()-> Int{
        
        let time  = endHour?.timeIntervalSince((startHour)!)
        
        return Int(time!/(3600*0.5))
        
    }
    
    public func UiFirstBlock()-> Int{
        
        let time = startHour?.timeIntervalSince(Date(fromString: "07:00" , withFormat: .Custom("HH:mm"))!)
        return Int(time!/(3600*0.5))
    }
    
}

class HTCInventory: HometapObject {
    public override init(dict: [String : AnyObject]) {
        super.init(dict: dict)
        
        if let blue = dict["blue"] {
            self.blue = (blue as? Double)
        }
        if let pink = dict["pink"] {
            self.pink = (pink as? Double)
        }
        if let yellow = dict["yellow"] {
            self.yellow = (yellow as? Double)
        }
        
    }
    
    
    var blue: Double?
    var pink: Double?
    var yellow: Double?
    
    
}
