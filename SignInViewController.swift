//
//  SignInViewController.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 19/07/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseAuth

class SignInViewController:UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate , UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
    @IBOutlet weak var buttonContinue: UIButton!
    
    @IBOutlet weak var userNameTxt: UITextField!
    
    @IBOutlet weak var userPhoneTxt: UITextField!
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userDateTxt: UITextField!
    
    @IBOutlet weak var userSexTxt: UITextField!
    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var termsLb: UILabel!
    
    @IBOutlet weak var upConst: NSLayoutConstraint!
    
    @IBOutlet weak var downConst: NSLayoutConstraint!
    
    let datePicker = UIDatePicker()
    
    var sex = ["Hombre", "Mujer","Otro" ]
    
    let sexPicker = UIPickerView()
    
    var userImageSelected = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SignInViewController.tapFunction))
        termsLb.isUserInteractionEnabled = true
        termsLb.addGestureRecognizer(tap)
        
        buttonContinue.isEnabled = false
        self.userPhoneTxt.delegate = self
        self.userNameTxt.delegate = self
        self.emailTxt.delegate = self
        
        userImage.layer.borderWidth = 1
        userImage.layer.masksToBounds = false
        userImage.layer.borderColor = UIColor.black.cgColor
        userImage.layer.cornerRadius = userImage.frame.height/2
        userImage.clipsToBounds = true
        
        userDateTxt.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        userSexTxt.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        userNameTxt.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        userPhoneTxt.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        emailTxt.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
        self.userImage.layer.borderWidth = 1
        self.userImage.layer.masksToBounds = false
        self.userImage.layer.borderColor = UIColor(red:186/255.0, green:208/255.0, blue:65/255.0, alpha: 1.0).cgColor
        self.userImage.layer.cornerRadius = self.userImage.frame.height/2
        self.userImage.clipsToBounds = true
        
        sexPicker.delegate = self
        sexPicker.dataSource = self
        sexPicker.backgroundColor = .white
        userSexTxt.inputView = sexPicker
        
        createDatePicker()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        
        buttonContinue.roundCorners(radius: K.UI.special_round_px)
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        userImage.image=image
        userImageSelected=true
        picker.dismiss(animated: true, completion: nil )
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: "Photo source", message: "Seleccionar una imagen", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camara", style: .default, handler: { (action:UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                
                imagePickerController.sourceType = .camera
                self.present(imagePickerController , animated: true, completion: nil)
            }else{
                print("Camera not avaliable")
            }
            
        } ))
        actionSheet.addAction(UIAlertAction(title: "Almacenamiento", style: .default, handler: { (action:UIAlertAction) in
            
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController , animated: true, completion: nil)
            
        } ))
        actionSheet.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler:nil ))
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func endRegistration(_ sender: UIButton) {
        
        
        if(userImageSelected){
            
            K.User.homie = Homie(user: Auth.auth().currentUser!)
            K.User.homie?.name = userNameTxt.text
            K.User.homie?.phone = userPhoneTxt.text
            K.User.homie?.email = emailTxt.text
            if (userDateTxt.text == nil)
            {
                K.User.homie?.birth = Date()
            }else{
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = ("YYYY/mm/dd")
                let date = dateFormatter.date(from: self.userDateTxt.text! )
                 K.User.homie?.birth = date
            }
            K.User.homie?.joined = Date()
            if userSexTxt.text == "Hombre"{
                K.User.homie?.gender = 0
            }
            if userSexTxt.text == "Otro"{
                K.User.homie?.gender = 2
            }
            if  userSexTxt.text == "Mujer"
            {
                K.User.homie?.gender = 1
            }
            
            K.User.homie?.email = getCurrentUserMail()
            K.User.homie?.rating = 5.0
            K.User.homie?.votes = 0
            K.User.homie?.uid = getCurrentUserUid()
            K.User.homie?.blocked = true
            let inv = HTCInventory(dict:[:])
            inv.blue = 0
            inv.pink = 0
            inv.yellow = 0
            K.User.homie?.saveInventory(inventory: inv)
            
            //add image to storage
            let storage = Storage.storage()
            let storageRef = storage.reference()
            var data = NSData()
            data = UIImageJPEGRepresentation(userImage.image!, 0.8)! as NSData
            // set upload path
            let filePath = "homies/\(getCurrentUserUid() ?? "" )/\("pp.png")"
            
            let metaData = StorageMetadata()
            metaData.contentType = "image/png"
            storageRef.child(filePath).putData(data as Data, metadata: metaData){(metaData,error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }else{
                    //store downloadURL
                    let downloadURL = metaData!.downloadURL()!.absoluteString
                    K.User.homie?.photo = downloadURL
                    K.User.homie?.save()
                }
                
            }
            
            
            self.dismiss(animated: true, completion: nil)
            
        }
        else
        {
            let alertController = UIAlertController(title: "Alerta", message: "Debes seleccionar una foto de perfil para continuar.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "ok", style: .cancel) { (action:UIAlertAction!) in
            }
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion:nil)
        }
    }
    
    
    func createDatePicker()
    {
        //Format for picker
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
        
        //toolbar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        //bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed) )
        toolBar.setItems([doneButton], animated:false)
        
        userDateTxt.inputAccessoryView = toolBar
        
        //assigningdate picker to textField
        userDateTxt.inputView = datePicker
        
    }
    
    @objc func donePressed(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        userDateTxt.text = dateFormatter.string(from: datePicker.date)
        
        self.view.endEditing(true)
    }
    
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return sex.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return sex[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        userSexTxt.text =  sex[row]
        editingChanged(userSexTxt)
        self.view.endEditing(false)
        
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        if textField.text?.characters.count == 1 {
            if textField.text?.characters.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let phone = userPhoneTxt.text, !phone.isEmpty,
            let name = userNameTxt.text, !name.isEmpty,
            let e = emailTxt.text, !e.isEmpty
            else {
                
                buttonContinue.isEnabled = false
                return
                
            }
        buttonContinue.isEnabled = true
        
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if (textField.tag == 89 ){
            
            self.downConst.constant = 70
            self.upConst.constant = 0
            
            UIView.animate(withDuration: 0.4, delay: 0.1, animations: {
                self.view.layoutIfNeeded()
                
                
            })
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 89:
            self.downConst.constant = 40
            self.upConst.constant = 30
            
            UIView.animate(withDuration: 0.4, delay: 0.1, animations: {
                self.view.layoutIfNeeded()
                
                
            })
            
        default: break
        }
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        
        guard let url = URL(string: "https://hometap.com.co/terms.pdf") else {
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    
}
