//
//  ViewControllerComents.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 8/09/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit
import Cosmos
import MBProgressHUD

class ViewControllerComents: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var cosmosView: CosmosView!
    
    var buttonsDescription: [Int] = [0,0,0,0]
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var heightView: NSLayoutConstraint!
    
    @IBOutlet weak var fastButton: UIButton!
    
    @IBOutlet weak var onTimeButton: UIButton!
    
    @IBOutlet weak var cleanButton: UIButton!
    
    @IBOutlet weak var friendlyButton: UIButton!
    
    @IBOutlet weak var comentText: UITextView!
    
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var badRatingLable: UILabel!
    
    @IBOutlet weak var buttonCallHometap: UIButton!
    
    @IBOutlet weak var mainViewComents: UIView!
    
    private var compliments: [String:Bool] = [:]
    
    var service : Service?
    
    var briefService : Service?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.comentText.delegate = self
        
        
        self.heightView.constant = 395
        self.buttonCallHometap.alpha = 0
        self.buttonCallHometap.isEnabled = false
        self.badRatingLable.alpha = 0
        doneButton.isEnabled = false
        
        cosmosView.didFinishTouchingCosmos = { rating in
            if (rating < 3)
            {
                self.showCall()
                
            }
            else{
                self.hiddeCall()
                
            }
        }
        
        cosmosView.didTouchCosmos = { rating in
            if (rating < 3)
            {
                self.showCall()
                self.doneButton.isEnabled = true
                
            }
            else{
                self.hiddeCall()
                self.doneButton.isEnabled = true
                
            }
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            self.topConstraint.constant = 20
            UIView.animate(withDuration: 0.4, delay: 0.1, animations: {
                self.view.layoutIfNeeded()
                
                
            })
            return false
        }
        return true
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
        self.fastButton.bordered(color: UIColor.gray)
        
        self.cleanButton.layer.borderWidth = 1
        self.cleanButton.roundCorners(radius: K.UI.coment_round_px)
        self.cleanButton.bordered(color: UIColor.gray)
        
        self.friendlyButton.layer.borderWidth = 1
        self.friendlyButton.roundCorners(radius: K.UI.coment_round_px)
        self.friendlyButton.bordered(color: UIColor.gray)
        
        self.onTimeButton.layer.borderWidth = 1
        self.onTimeButton.roundCorners(radius: K.UI.coment_round_px)
        self.onTimeButton.bordered(color: UIColor.gray)
        
        self.doneButton.roundCorners(radius: K.UI.special_round_px)
        self.buttonCallHometap.roundCorners(radius: K.UI.special_round_px)
        self.mainViewComents.bordered(color: UIColor.gray)
        
        self.comentText.layer.borderWidth = 1
        self.comentText.layer.borderColor =  UIColor.gray.cgColor
        self.mainViewComents.roundCorners(radius: K.UI.special_round_px)
        
        
        
        
        
    }
    
    
    @IBAction func descriptionButtons(_ sender: UIButton) {
        
        let index = sender.tag
        print("indice button: " + String(index))
        switch  index {
        case 0:
            
            if(buttonsDescription[0] == 0){
                self.fastButton.bordered(color: .clear)
                fastButton.layer.borderWidth = 1
                self.fastButton.backgroundColor = K.UI.main_color
                self.fastButton.setTitleColor(UIColor.white , for: .normal)
                self.fastButton.roundCorners(radius: K.UI.coment_round_px)
                buttonsDescription[0] = 1
            }
            else{
                
                self.fastButton.bordered(color: UIColor.gray)
                self.fastButton.layer.borderWidth = 1
                self.fastButton.backgroundColor = UIColor.white
                self.fastButton.setTitleColor(UIColor.gray , for: .normal)
                self.fastButton.roundCorners(radius: K.UI.coment_round_px)
                
                buttonsDescription[0] = 0
            }
            
        case 1:
            
            if(buttonsDescription[1] == 0){
                
                self.onTimeButton.bordered(color: .clear)
                self.onTimeButton.backgroundColor = K.UI.main_color
                self.onTimeButton.setTitleColor(UIColor.white , for: .normal)
                self.onTimeButton.roundCorners(radius: K.UI.coment_round_px)
                buttonsDescription[1] = 1
            }
            else{
                self.onTimeButton.bordered(color: UIColor.gray)
                self.onTimeButton.backgroundColor = UIColor.white
                self.onTimeButton.setTitleColor(UIColor.gray , for: .normal)
                self.onTimeButton.roundCorners(radius: K.UI.coment_round_px)
                buttonsDescription[1] = 0
            }
            
        case 2:
            if(buttonsDescription[2] == 0){
                
                self.cleanButton.bordered(color: .clear)
                self.cleanButton.backgroundColor = K.UI.main_color
                self.cleanButton.setTitleColor(UIColor.white , for: .normal)
                self.cleanButton.roundCorners(radius: K.UI.coment_round_px)
                buttonsDescription[2] = 1
            }
            else{
                self.cleanButton.bordered(color: UIColor.gray)
                self.cleanButton.backgroundColor = UIColor.white
                self.cleanButton.setTitleColor(UIColor.gray , for: .normal)
                self.cleanButton.roundCorners(radius: K.UI.coment_round_px)
                buttonsDescription[2] = 0
            }
            
        case 3:
            
            if(buttonsDescription[3] == 0){
                
                self.friendlyButton.bordered(color: .clear)
                self.friendlyButton.backgroundColor = K.UI.main_color
                self.friendlyButton.setTitleColor(UIColor.white , for: .normal)
                self.friendlyButton.roundCorners(radius: K.UI.coment_round_px)
                buttonsDescription[3] = 1
                
            }
            else{
                
                self.friendlyButton.bordered(color: UIColor.gray)
                self.friendlyButton.backgroundColor = UIColor.white
                self.friendlyButton.setTitleColor(UIColor.gray , for: .normal)
                self.friendlyButton.roundCorners(radius: K.UI.coment_round_px)
                buttonsDescription[3] = 0
            }
        default:
            return
        }
        
        
    }
    
    
    func showCall() {
        
        self.heightView.constant = 486
        
        UIView.animate(withDuration: 0.8, delay: 0.2, animations: {
            self.view.layoutIfNeeded()
            
            self.buttonCallHometap.alpha = 1
            self.buttonCallHometap.isEnabled = true
            self.badRatingLable.alpha = 1
            
            
            
        })
        
        
        // Save rating here
    }
    func hiddeCall() {
        
        
        self.heightView.constant = 395
        
        UIView.animate(withDuration: 0.8, delay: 0.2, animations: {
            self.view.layoutIfNeeded()
            
            self.buttonCallHometap.alpha = 0
            self.buttonCallHometap.isEnabled = false
            self.badRatingLable.alpha = 0
            
            
            
        })
    }
    
    
    @IBAction func submitinfomation(_ sender: Any) {
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        for i in 0...3 {
            
            if (buttonsDescription[i]==1)
            {
                self.compliments["\(i)"] = true
            }
        }
        
        let comment = Comment(dict: [:])
        comment.body = self.comentText.text
        comment.homieID = K.User.homie?.uid
        comment.homieName = K.User.homie?.name
        comment.date = Date()
        
        comment.clientID = service?.clientID
        comment.clientName = briefService?.briefName
        comment.rating = self.cosmosView.rating
        comment.original_dictionary["tags"] = self.compliments as AnyObject
        comment.original_dictionary["tipo"] = 1 as AnyObject
        comment.save()
        MBProgressHUD.hide(for: self.view, animated: true)
        
        
        
        
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func callHomeTap(_ sender: Any) {
        
        let url = URL(string: "tel://3100000000")
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url!)
        } else {
            // Fallback on earlier versions
            UIApplication.shared.openURL(url!)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        self.topConstraint.constant = -70
        UIView.animate(withDuration: 0.4, delay: 0.1, animations: {
            self.view.layoutIfNeeded()
            
            
        })
        
        
    }
    
    
    
    
}
