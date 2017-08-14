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
    
    
    
    
    @IBOutlet weak var fbLogin: FBSDKLoginButton!
    
    @IBOutlet weak var GoogleLogin: GIDSignInButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        fbLogin.delegate = self
        
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
        
    }
    
    
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.showAlert(title: "Lo sentimos", message: String(format: "Ha ocurrido un error desconocido: %@", error.localizedDescription), closeButtonTitle: "Ok")
            return
        }
        
        let authentication = user.authentication
        let credential = GoogleAuthProvider.credential(withIDToken: (authentication?.idToken)!,
                                                       accessToken: (authentication?.accessToken)!)
        
        print("entro a google")
        
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
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user:GIDGoogleUser!,
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
        
        
        print("entro a facebook")
        
        Auth.auth().signIn(with: credential) { (user, error) in
            
            if error != nil{
                self.showAlert(title: "Lo sentimos", message: String(format: "Ha ocurrido un error inesperado: %@", (error?.localizedDescription)!), closeButtonTitle: "Ok")
            }
            else {
                
                self.dismiss(animated: true, completion: nil)
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
    
    
    
    
}
