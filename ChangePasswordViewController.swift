//
//  ChangePasswordViewController.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 20/07/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit
import FirebaseAuth

class ChangePasswordViewController: UIViewController {

    @IBOutlet var saveChangesBtt: UIButton!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var newPasswordTxt: UITextField!
    
    @IBOutlet weak var confirmationNewPasswordTxt: UITextField!
    
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
        
        self.saveChangesBtt.roundCorners(radius: K.UI.round_px)
    }
    @IBAction func dismis(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }


    @IBAction func saveChanges(_ sender: Any) {
       
        
        if(newPasswordTxt.text == confirmationNewPasswordTxt.text )
        {
            
        
        let user = Auth.auth().currentUser
        
        //pedir info
        
        let credential = EmailAuthProvider.credential(withEmail: getCurrenUserEmail()!, password: passwordTxt.text!)
        
        user?.reauthenticate(with: credential) { error in
            if error != nil {
                // An error happened.
            } else {
                // User re-authenticated.
                user?.updatePassword(to: self.newPasswordTxt.text!) { error in
                    if let error = error {
                        print(error)
                        
                    } else {
                        self.showAlert(title: "Aviso", message: String(format: "Se ha cambiado la contraseña."), closeButtonTitle: "Ok")
                        
                    }
                }
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        
        }
        else
        {
            self.showAlert(title: "Lo sentimos", message: String(format: "La nueva contraseña no coincide."), closeButtonTitle: "Ok")
        }
        
        
        
        
       
    }
}
