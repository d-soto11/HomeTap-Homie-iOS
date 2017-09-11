//
//  Notification.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 10/09/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit

class Notification: HometapObject {
    
    public override init(dict: [String : AnyObject]) {
        super.init(dict: dict)
        
        if let type = dict["tipo"] {
            self.type = (type as? Int)
        }
    }
    
    var type: Int?

}
