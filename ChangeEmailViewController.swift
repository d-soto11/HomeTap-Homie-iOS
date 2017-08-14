//
//  ChangeEmailViewController.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 20/07/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class ChangeEmailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var saveChangesBtt: UIButton!
   
    
    @IBOutlet weak var mailTxt: UITextField!
    var email = ""
    var password = ""
    var passTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mailTxt.delegate = self
        mailTxt.text = K.User.homie?.email
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

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    @IBAction func saveChanges(_ sender: Any) {
        
        let alertController = UIAlertController( title : "Autenticacion", message : nil, preferredStyle : .alert)
        
        alertController.addTextField(configurationHandler: passTextField)
        let okAction  = UIAlertAction(title: "Ok", style: .default, handler: self.okHandler)
        
        let cancelAction  = UIAlertAction(title: "Cancel", style: .cancel , handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController , animated: true)
        
        
    }
    
    func passTextField (textField: UITextField  ){
        passTextField = textField
        passTextField?.placeholder = "Contraseña"
        passTextField?.isSecureTextEntry = true
        
    }
    
    func okHandler( alert: UIAlertAction! )
    {
        password = passTextField.text!
        email = getCurrentUserMail()!
        
        let user = Auth.auth().currentUser
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        
        user?.reauthenticate(with: credential) { error in
            if error != nil {
                self.showAlert(title: "Lo sentimos", message: String(format:"Ha ocurrido un error inesperado: %@", error!.localizedDescription), closeButtonTitle: "Ok")
            } else {
                // User re-authenticated.
                user?.updateEmail(to: self.mailTxt.text!) { error in
                    if let error = error {
                        print(error)
                        
                    } else {
                        K.Database.ref().child("homies").child(getCurrentUserUid()!).updateChildValues(["email": self.mailTxt.text!])
                        self.showAlert(title: "Aviso", message: String(format:"El correo se ha cambiado"), closeButtonTitle: "Ok")
                        
                    }
                }
            }
        }
       
        
        self.dismiss(animated: true, completion: nil)
    }

}



