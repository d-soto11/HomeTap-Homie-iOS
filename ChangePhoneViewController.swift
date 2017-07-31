//
//  ChangePhoneViewController.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 20/07/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit

class ChangePhoneViewController: UIViewController , UITextFieldDelegate{

    @IBOutlet weak var saveChangesBtt: UIButton!

    
    @IBOutlet weak var phoneTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.saveChangesBtt.isEnabled = false
        self.phoneTxt.delegate = self
        //phoneTxt.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        phoneTxt.text = K.User.current?.phone
        // Do any additional setup after loading the view.
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.saveChangesBtt.roundCorners(radius: K.UI.round_px)
    }
    
    @IBAction func dismis(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func changeInfo(_ sender: Any) {
        
        K.Database.ref!.child("homies").child(getCurrentUserUid()!).updateChildValues(["phone": phoneTxt.text!])
        self.dismiss(animated: true, completion: nil)
        
    }

}
