//
//  AuthViewController.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 18/07/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn
import FirebaseAuth
import MBProgressHUD


class AuthViewController: UIViewController, FBSDKLoginButtonDelegate, GIDSignInUIDelegate, GIDSignInDelegate, UITextFieldDelegate  {
    
    
    @IBOutlet weak var userTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var fbLogin: FBSDKLoginButton!
    
    @IBOutlet weak var GoogleLogin: GIDSignInButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signInLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        self.userTxt.delegate = self
        self.passwordTxt.delegate = self

        
        let tap = UITapGestureRecognizer(target: self, action: #selector(AuthViewController.tapFunction))
        signInLabel.isUserInteractionEnabled = true
        signInLabel.addGestureRecognizer(tap)
        
        loginButton.isEnabled = false
        passwordTxt.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        userTxt.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
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
        
        self.loginButton.roundCorners(radius: K.UI.round_px)
    }
    
    
    func hideKeyboard() {
        view.endEditing(true)
    }
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.showAlert(title: "Lo sentimos", message: String(format: "Ha ocurrido un error desconocido: %@", error.localizedDescription), closeButtonTitle: "Ok")
            return
        }
        
        let authentication = user.authentication
        let credential = GoogleAuthProvider.credential(withIDToken: (authentication?.idToken)!,
                                                          accessToken: (authentication?.accessToken)!)
        
        Auth.auth().signIn(with: credential) { (user, error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if (error != nil){
                self.showAlert(title: "Lo sentimos", message: String(format:"Ha ocurrido un error inesperado: %@", error!.localizedDescription), closeButtonTitle: "Ok")
            }
            else{
                
                self.dismiss(animated: true, completion: nil)
            }
           
        }
    
    }
    
    public func sign(_ signIn: GIDSignIn!, didDisconnectWith user:GIDGoogleUser!,
                     withError error: Error?) {
        // Perform any operations when the user disconnects from app here.
        // ...
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if let error = error {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.showAlert(title: "Lo sentimos", message: String(format: "Ha ocurrido un error inesperado: %@", error.localizedDescription), closeButtonTitle: "Ok")
            return
        }
        
        
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        
        Auth.auth().signIn(with: credential) { (user, error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            
            if (error != nil){
                self.showAlert(title: "Lo sentimos", message: String(format:"Ha ocurrido un error inesperado: %@", error!.localizedDescription), closeButtonTitle: "Ok")
            }
            else{
                
                self.dismiss(animated: true, completion: nil)
                print("success WHIT FB!")
            }
           
        }
        
        
        
        
    }
    
    
    /**
     Sent to the delegate when the button was used to logout.
     - Parameter loginButton: The button that was clicked.
     */
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    
    
    //Action to label
    
    func tapFunction(sender:UITapGestureRecognizer) {
        
        print("hace logOut")
        do{
            try Auth.auth().signOut()
        }catch{
            print("Error while signing out!")
        }
        
        //self.performSegue(withIdentifier: "SigninSeg", sender: self)
        
    }
    
    
    @IBAction func login(_ sender: Any) {
        
        if let email = userTxt.text, let password = passwordTxt.text{
            Auth.auth().signIn(withEmail: email, password: password
                , completion: {(user, error ) in
                    MBProgressHUD.hide(for: self.view, animated: true)
                    
                    if  (error != nil) {
                        
                        self.showAlert(title: "Lo sentimos", message: String(format:"Ha ocurrido un error inesperado: %@", error!.localizedDescription), closeButtonTitle: "Ok")
                
                        return
                    }
                    else{
                        self.dismiss(animated: true, completion: nil)
                        print("success WHIT MAIL!")
                    }
                    
                    
                    
                    
            })
            
        }

    }
    
    func editingChanged(_ textField: UITextField) {
        if textField.text?.characters.count == 1 {
            if textField.text?.characters.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let email = userTxt.text, !email.isEmpty,
            let password = passwordTxt.text, !password.isEmpty
            else {
                loginButton.isEnabled = false
                return
        }
        loginButton.isEnabled = true
    }
    
}
