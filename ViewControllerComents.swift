//
//  ViewControllerComents.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 8/09/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit
import Cosmos
class ViewControllerComents: UIViewController {
    
    
    
    var buttonsDescription: [Int] = [0,0,0,0]
    
    @IBOutlet weak var fastButton: UIButton!
    
    @IBOutlet weak var onTimeButton: UIButton!
    
    @IBOutlet weak var cleanButton: UIButton!
    
    @IBOutlet weak var friendlyButton: UIButton!
    
    @IBOutlet weak var comentText: UITextView!
    
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var badRatingLable: UILabel!
    
    @IBOutlet weak var buttonCallHometap: UIButton!
    
    @IBOutlet weak var mainViewComents: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        
        
        super.viewDidLayoutSubviews()
        view.isOpaque = false
        
        self.fastButton.layer.borderWidth = 1
        self.fastButton.roundCorners(radius: K.UI.coment_round_px)
        self.fastButton.layer.borderColor = UIColor.gray.cgColor
        
        self.cleanButton.layer.borderWidth = 1
        self.cleanButton.roundCorners(radius: K.UI.coment_round_px)
        self.cleanButton.layer.borderColor = UIColor.gray.cgColor
        
        self.friendlyButton.layer.borderWidth = 1
        self.friendlyButton.roundCorners(radius: K.UI.coment_round_px)
        self.friendlyButton.layer.borderColor = UIColor.gray.cgColor
        
        self.onTimeButton.layer.borderWidth = 1
        self.onTimeButton.roundCorners(radius: K.UI.coment_round_px)
        self.onTimeButton.layer.borderColor = UIColor.gray.cgColor
        
        self.doneButton.roundCorners(radius: K.UI.special_round_px)
        self.buttonCallHometap.roundCorners(radius: K.UI.light_round_px)
        self.mainViewComents.roundCorners(radius: K.UI.special_round_px)
        
        self.comentText.layer.borderWidth = 1
        self.comentText.layer.borderColor =  UIColor.gray.cgColor
        
        
    }
    
    
    @IBAction func descriptionButtons(_ sender: UIButton) {
        
        let index = sender.tag
        print("indice button: " + String(index))
        switch  index {
        case 0:
            
            if(buttonsDescription[0] == 0){
                self.fastButton.backgroundColor = K.UI.main_color
                self.fastButton.titleLabel?.textColor = UIColor.white
                self.fastButton.roundCorners(radius: K.UI.coment_round_px)
                self.fastButton.bordered(color: K.UI.main_color)
                buttonsDescription[0] = 1
            }
            else{
                self.fastButton.backgroundColor = UIColor.white
                self.fastButton.titleLabel?.textColor = UIColor.gray
                self.fastButton.roundCorners(radius: K.UI.coment_round_px)
                self.fastButton.bordered(color: UIColor.gray)
                buttonsDescription[0] = 0
            }
            
        case 1:
            
            if(buttonsDescription[1] == 0){
                
                self.onTimeButton.backgroundColor = K.UI.main_color
                self.onTimeButton.titleLabel?.textColor = UIColor.white
                self.onTimeButton.roundCorners(radius: K.UI.coment_round_px)
                self.onTimeButton.bordered(color: K.UI.main_color)
                buttonsDescription[1] = 1
            }
            else{
                
                self.onTimeButton.backgroundColor = UIColor.white
                self.onTimeButton.titleLabel?.textColor = UIColor.gray
                self.onTimeButton.roundCorners(radius: K.UI.coment_round_px)
                self.onTimeButton.bordered(color: UIColor.gray)
                buttonsDescription[1] = 0
            }
            
        case 2:
            if(buttonsDescription[2] == 0){
                
                self.cleanButton.backgroundColor = K.UI.main_color
                self.cleanButton.titleLabel?.textColor = UIColor.white
                self.cleanButton.roundCorners(radius: K.UI.coment_round_px)
                self.cleanButton.bordered(color: K.UI.main_color)
                buttonsDescription[2] = 1
            }
            else{
                
                self.cleanButton.backgroundColor = UIColor.white
                self.cleanButton.titleLabel?.textColor = UIColor.gray
                self.cleanButton.roundCorners(radius: K.UI.coment_round_px)
                self.cleanButton.bordered(color: UIColor.gray)
                buttonsDescription[2] = 0
            }
            
        case 3:
            
            if(buttonsDescription[3] == 0){
                
                self.friendlyButton.backgroundColor = K.UI.main_color
                self.friendlyButton.titleLabel?.textColor = UIColor.white
                self.friendlyButton.roundCorners(radius: K.UI.coment_round_px)
                self.friendlyButton.bordered(color: K.UI.main_color)
                buttonsDescription[3] = 1
                
            }
            else{
                
                self.friendlyButton.backgroundColor = UIColor.white
                self.friendlyButton.titleLabel?.textColor = UIColor.gray
                self.friendlyButton.roundCorners(radius: K.UI.coment_round_px)
                self.friendlyButton.bordered(color: UIColor.gray)
                buttonsDescription[3] = 0
            }
        default:
            return
        }
        
        
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
