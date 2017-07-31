//
//  SignInViewController.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 19/07/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit
import FirebaseStorage

class SignInViewController:UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate , UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
    @IBOutlet weak var buttonContinue: UIButton!
    
    @IBOutlet weak var userNameTxt: UITextField!
    
    @IBOutlet weak var userPhoneTxt: UITextField!
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userDateTxt: UITextField!
    
    @IBOutlet weak var userSexTxt: UITextField!
    
    let datePicker = UIDatePicker()
    
    var sex = ["Hombre", "Mujer"]
    
    let sexPicker = UIPickerView()
    
    var userImageSelected = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        buttonContinue.isEnabled = false
        self.userPhoneTxt.delegate = self
        self.userNameTxt.delegate = self
        
        userImage.layer.borderWidth = 1
        userImage.layer.masksToBounds = false
        userImage.layer.borderColor = UIColor.black.cgColor
        userImage.layer.cornerRadius = userImage.frame.height/2
        userImage.clipsToBounds = true
        
        userDateTxt.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        userSexTxt.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        userNameTxt.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        userPhoneTxt.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
        
        
        sexPicker.delegate = self
        sexPicker.dataSource = self
        userSexTxt.inputView = sexPicker
        
        createDatePicker()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        userImage.image=image
        userImageSelected=true
        dismiss(animated: true, completion: nil )
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
        
        //preguntarle al pez sobre el date
        
        let h = Homie(dict: [ :])
        h.name = userNameTxt.text
        h.phone = userPhoneTxt.text
        h.birth =  Date()
        h.joined = Date()
        if userSexTxt.text == "Hombre"{
            h.gender = 0
        }
        else
        {
            h.gender = 1
        }
        h.photo = " "
        h.email = getCurrenUserEmail()
        h.rating = 0.0
        h.votes = 0
        h.uid = getCurrentUserUid()
        
        
        h.save(route: "homies")
        
        //add image to storage
        let storage = Storage.storage()
        let storageRef = storage.reference()
        var data = NSData()
        data = UIImageJPEGRepresentation(userImage.image!, 0.8)! as NSData
        // set upload path
        let filePath = "homies/\(getCurrentUserUid() ?? "" )/\("userPhoto")"
        print(filePath)
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        storageRef.child(filePath).putData(data as Data, metadata: metaData){(metaData,error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }else{
                //store downloadURL
                let downloadURL = metaData!.downloadURL()!.absoluteString
                //store downloadURL at database
                K.Database.ref!.child("homies").child(getCurrentUserUid()!).updateChildValues(["photo": downloadURL])
            }
            
        }

        
        self.dismiss(animated: true, completion: nil)
    }
    
   
    func createDatePicker()
    {
        //Format for picker
        datePicker.datePickerMode = .date
        
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
    
    func donePressed(){
        
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
        self.view.endEditing(false)
        
    }
    
    func editingChanged(_ textField: UITextField) {
        if textField.text?.characters.count == 1 {
            if textField.text?.characters.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let phone = userPhoneTxt.text, !phone.isEmpty,
            let name = userNameTxt.text, !name.isEmpty,
            let date = userDateTxt.text, !date.isEmpty,
            let sex = userSexTxt.text, !sex.isEmpty
            else {
                if(userImageSelected){
                    buttonContinue.isEnabled = true
                    return
                }
            buttonContinue.isEnabled = false
            return
        }
        buttonContinue.isEnabled = false
    }
    
    
    
    
}
