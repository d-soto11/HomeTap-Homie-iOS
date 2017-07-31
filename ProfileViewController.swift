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
    @IBOutlet weak var passwordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //add gesture to labels
        let tap = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.goName))
        nameLabel.isUserInteractionEnabled = true
        nameLabel.addGestureRecognizer(tap)
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.goPhone))
        phoneLabel.isUserInteractionEnabled = true
        phoneLabel.addGestureRecognizer(tap1)
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.goMail))
        eMailLabel.isUserInteractionEnabled = true
        eMailLabel.addGestureRecognizer(tap2)
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.goPassword))
        passwordLabel.isUserInteractionEnabled = true
        passwordLabel.addGestureRecognizer(tap3)
        
        //configuration profile picture
        
        self.profilePicture.layer.borderWidth = 1
        self.profilePicture.layer.masksToBounds = false
        self.profilePicture.layer.borderColor = UIColor(red:186/255.0, green:208/255.0, blue:65/255.0, alpha: 1.0).cgColor
        self.profilePicture.layer.cornerRadius = self.profilePicture.frame.height/2
        self.profilePicture.clipsToBounds = true
        
        // Do any additional setup after loading the view.
        self.infoView.isHidden = true
        self.profilePicture.isHidden=true
        
        
            self.nameLabel.text = K.User.current?.name
            self.phoneLabel.text = K.User.current?.phone
            self.eMailLabel.text = K.User.current?.email
            self.passwordLabel.text = "******"
            
        //cargar imagen
            
        self.cargarImagen(url: (K.User.current?.photo)!)
        
        self.infoView.isHidden = false
        self.profilePicture.isHidden = false
        
        
    }

    func cargarImagen(url: String){
        
        let catPictureURL = URL(string: url)!
        
        // Creating a session object with the default configuration.
        // You can read more about it here https://developer.apple.com/reference/foundation/urlsessionconfiguration
        let session = URLSession(configuration: .default)
        
        // Define a download task. The download task will download the contents of the URL as a Data object and then you can do what you wish with that data.
        let downloadPicTask = session.dataTask(with: catPictureURL) { (data, response, error) in
            // The download has finished.
            if let e = error {
                print("Error downloading cat picture: \(e)")
            } else {
                // No errors found.
                // It would be weird if we didn't have a response, so check for that too.
                if let res = response as? HTTPURLResponse {
                    print("Downloaded cat picture with response code \(res.statusCode)")
                    if let imageData = data {
                        // Finally convert that Data into an image and do what you wish with it.
                        let image = UIImage(data: imageData)
                        
                        self.profilePicture.image = image
                        // Do something with your image.
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
        }
        
        downloadPicTask.resume()

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
            self.performSegue(withIdentifier: "LogOutSeg", sender: self)
            
        }catch{
            print("Error while signing out!")
        }
    }
    
    func goPassword(sender:UITapGestureRecognizer) {
        
        self.performSegue(withIdentifier: "PasswordSeg", sender: self)
        
    }
    
    func goName(sender:UITapGestureRecognizer) {
        
        self.performSegue(withIdentifier: "NameSeg", sender: self)
        
    }
    func goPhone(sender:UITapGestureRecognizer) {
        
        self.performSegue(withIdentifier: "PhoneSeg", sender: self)
        
    }
    func goMail(sender:UITapGestureRecognizer) {
        
        self.performSegue(withIdentifier: "MailSeg", sender: self)
        
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
