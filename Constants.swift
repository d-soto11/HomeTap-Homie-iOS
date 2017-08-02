//
//  Constants.swift
//  Hometap
//
//  Created by Daniel Soto on 7/12/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import Foundation
import Firebase

struct K {
    struct Test {
        static var test_val:Bool = true
        
        static func test_func() {
            _ = false
        }
        
    }
    
    struct Helper {
        static let fb_date_format:String = "yyyy-MM-dd'T'HH:mmZZZZZ"
        static let fb_date_medium_format:String = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        static let fb_long_date_format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        static let fb_time_format: String = "hh:mm a"
    }
    
    struct Database {
        static var ref: DatabaseReference? = nil
    }
    
    
    
    struct UI {
        static let main_color: UIColor = UIColor(netHex: 0xbad041)
        static let alert_color: UIColor = UIColor(netHex: 0xf94f4f)
        static let second_color: UIColor = UIColor(netHex: 0xffda29)
        static let tab_color: UIColor = UIColor(netHex: 0xcccccc)
        static let history_color: UIColor = UIColor(netHex: 0x808080)
        static let booking_color: UIColor = UIColor(netHex: 0xb8b8b8)
        static let form_color: UIColor = UIColor(netHex: 0x8d8d8d)
        static let select_box_color: UIColor = UIColor(netHex: 0xe5e5e5)
        static let round_px: CGFloat = 25.0
        static let special_round_px: CGFloat = 20.0
        static let light_round_px: CGFloat = 5.0

    }
    
    struct  User {
        static var current:Homie?
    }
    
    
}

func getCurrentUserUid()->String?{
    return Auth.auth().currentUser?.uid
}

func getCurrenUserEmail()->String?{
    return Auth.auth().currentUser?.email
}


func setCurrentUser(){
    
    K.Database.ref?.child("homies").child(getCurrentUserUid()!).observeSingleEvent(of: .value, with: { (snapshot) in
        // Get user value
        let value = snapshot.value as? NSDictionary
        
        let homie = Homie.init(dict: value as! [String : AnyObject])
        
        K.User.current = homie
        
        
    }) { (error) in
        print(error.localizedDescription)
    }
}





