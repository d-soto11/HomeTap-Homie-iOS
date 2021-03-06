//
//  HistoryServiceSummaryViewController.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 11/08/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit
import Firebase
class HistoryServiceSummaryViewController: UIViewController {
    
    
    @IBOutlet weak var clientPhoto: UIImageView!
    
    @IBOutlet weak var serviceState: UILabel!
    
    @IBOutlet weak var serviceValue: UILabel!
    
    @IBOutlet weak var clientPicture: UIImageView!
    
    @IBOutlet weak var clientName: UILabel!
    
    @IBOutlet weak var serviceDate: UILabel!
    
    @IBOutlet weak var hourService: UILabel!
    
    @IBOutlet weak var adressService: UILabel!
    
    @IBOutlet weak var iconsStackView: UIStackView!
    
    @IBOutlet weak var servicesStackView: UIStackView!
    
    @IBOutlet weak var comentsService: UILabel!
    
    @IBOutlet weak var dateService: UILabel!
    
    var serviceBrief : Service?
    var service : Service?
    
    @IBOutlet weak var buttonCall: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func dismis(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.buttonCall.roundCorners(radius: K.UI.special_round_px)
        self.clientPhoto.circleImage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if  service != nil {
            
            if(service?.state == 2){
                serviceState.text = "Completado"
            }
            else
            {
                serviceState.text = "Cancelado"
                serviceState.textColor = K.UI.alert_color
            }
            clientName.text = serviceBrief?.briefName
            clientPhoto.downloadedFrom(link: (serviceBrief?.briefPhoto)!, contentMode: UIViewContentMode.scaleAspectFill)
            dateService.text = service?.date?.toString(format: Date.DateFormat.Short)
            
            hourService.text = service?.date?.toString(format: .Time
            )
            
            adressService.text = service?.place?.address
            
            
            
            serviceValue.text = String(Int((service?.price)!)) + "COP"
            self.comentsService.text = service?.comments
            
            if (service?.additionalServices()) != nil {
                for ser in  (self.service?.additionalServices())!{
                    
                    // image icon
                    let imageName = "iconServiceChecked.png"
                    let image = UIImage(named: imageName)
                    let imageView = UIImageView(image: image!)
                    let widthConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 15)
                    imageView.addConstraint(widthConstraint)
                    let heightConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 15)
                    
                    imageView.addConstraint(heightConstraint)
                    
                    self.iconsStackView.addArrangedSubview(imageView)
                    
                    // lable service
                    let label = UILabel()
                    label.text = ser.descriptionH
                    label.font = UIFont(name: "Rubik-Light", size: 13)
                    
                    self.servicesStackView.addArrangedSubview(label)
                }
            }
            
        }
        else
        {
            print("NO SERVICE")
        }
        
    }
    
    
    @IBAction func callHometapAction(_ sender: Any) {
        K.Database.ref().child("appContent").observe(DataEventType.value, with: { (snapshot) in
            if let dict = snapshot.value as? [String:AnyObject] {
                let url = URL(string: "tel://" + String(dict["tel"] as! Int))
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url! , options: [:] , completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url!)
                    // Fallback on earlier versions
                }
            }
            
        })
        
       
    }
}
