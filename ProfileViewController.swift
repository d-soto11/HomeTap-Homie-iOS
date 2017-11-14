//
//  ProfileViewController.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 15/07/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit
import FirebaseAuth
import MBProgressHUD

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var infoView: UIStackView!
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var eMailLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configuration profile picture
        
        self.profilePicture.layer.borderWidth = 1
        self.profilePicture.layer.masksToBounds = false
        self.profilePicture.layer.borderColor = UIColor(red:186/255.0, green:208/255.0, blue:65/255.0, alpha: 1.0).cgColor
        self.profilePicture.layer.cornerRadius = self.profilePicture.frame.height/2
        self.profilePicture.clipsToBounds = true
        
        // Do any additional setup after loading the view.
        self.infoView.isHidden = true
        self.profilePicture.isHidden=true
        
        //cargar imagen
        
        
        
        self.infoView.isHidden = false
        self.profilePicture.isHidden = false
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.nameLabel.text = K.User.homie?.name
        self.phoneLabel.text = K.User.homie?.phone
        self.eMailLabel.text = K.User.homie?.email
        if ( K.User.homie?.photo != nil ){
            self.profilePicture.downloadedFrom(link:  (K.User.homie?.photo)!)
        }
        
        
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.logOutButton.roundCorners(radius: K.UI.light_round_px)
    }
    
    
    @IBAction func logOut(_ sender: Any) {
        
        do{
            try Auth.auth().signOut()
            URLCache.shared.removeAllCachedResponses()
            
            if let cookies = HTTPCookieStorage.shared.cookies {
                for cookie in cookies {
                    HTTPCookieStorage.shared.deleteCookie(cookie)
                }
            }
            
            self.performSegue(withIdentifier: "LogOutSeg", sender: self)
            
        }catch{
            print("Error while signing out!")
        }
    }
    
    }
  
