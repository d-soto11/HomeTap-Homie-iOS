//
//  Homie.swift
//  Hometap
//
//  Created by Daniel Soto on 7/14/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import Foundation
import Firebase

class Homie: User {
    
    public override init(dict: [String: AnyObject]){
        super.init(dict: dict)
        
        if let preferences = dict["preferences"] {
            self.preferences = (preferences as? NSDictionary)
        }
        if let folder = dict["folder"] {
            self.folder = (folder as? String)
        }
    }
    
    class func withID(id: String, callback: @escaping (_ s: Homie?)->Void){
        K.Database.ref().child("homies").child(id).observe(DataEventType.value, with: { (snapshot) in
            if let dict = snapshot.value as? [String:AnyObject] {
                callback(Homie(dict: dict))
            } else {
                callback(nil)
            }
        })
    }
    
    class func globalInventory( callback: @escaping (_ s: HTCInventory?)->Void){
        K.Database.ref().child("appContent").child("inventory").observe(DataEventType.value, with: { (snapshot) in
            if let dict = snapshot.value as? [String:AnyObject] {
                callback(HTCInventory(dict: dict))
            } else {
                callback(nil)
            }
        })
    }
    
   
    
    public func save() {
        if self.preferences != nil {
            original_dictionary["preferences"] = self.preferences as AnyObject
        }
        if self.folder != nil {
            original_dictionary["folder"] = self.folder as AnyObject
        }
        
        super.save(route: "homies")
    }
    
    var preferences: NSDictionary?
    var folder: String?
    
    public func blocks(date:Date) -> [HTCBlock] {
        var blocks:[HTCBlock] = []
        if let block = original_dictionary["blocks"] {
            if let blockDict = block as? [String:AnyObject] {
                for (_, blo) in blockDict {
                    if let bloDict = blo as? [String:AnyObject] {
                        
                        let b = HTCBlock(dict: bloDict)
                       
                        if(b.date?.toString(format: .Custom("yyyy-MM-dd")) == date.toString(format: .Custom("yyyy-MM-dd"))){
                        blocks.append(b)
                        }
                        
                    }
                }
                return blocks
            }
            
        }
        
        return blocks
    }
    
    public func inventory() -> HTCInventory? {
        
        if let prod = original_dictionary["products"] {
            
            if let prodDict = prod as? [String:AnyObject] {
               
                return HTCInventory(dict: prodDict)
            }
            
        }
        
        return HTCInventory(dict: [:])
    }

    public func saveBlock(block: HTCBlock) -> String{
        if block.uid == nil {
            block.uid = K.Database.ref().child("homies").child(self.uid!).child("blocks").childByAutoId().key
        }
        let blo_dict = block.prepareForSave()
        var org_blocks_dict:[String:[String:AnyObject]] = original_dictionary["blocks"] as? [String:[String:AnyObject]] ?? [:]
        org_blocks_dict[block.uid!] = blo_dict
        original_dictionary["blocks"] = org_blocks_dict as AnyObject
        
        return block.uid!
    }
    
    public func deleteBlock(uid: String) {
        
        K.Database.ref().child("homies").child(self.uid!).child("blocks").child(uid).removeValue()
        var org_blocks_dict:[String:[String:AnyObject]] = original_dictionary["blocks"] as? [String:[String:AnyObject]] ?? [:]
        org_blocks_dict.removeValue(forKey: uid)
        original_dictionary["blocks"] = org_blocks_dict as AnyObject
       
        
    }
    
}

/*
 public func products() -> [HTCBlock] {
 
 return nil
 }
 */


