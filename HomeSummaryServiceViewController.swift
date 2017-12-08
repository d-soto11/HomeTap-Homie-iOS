//
//  HomeSummaryServiceViewController.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 10/08/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase
class HomeSummaryServiceViewController: UIViewController {

    
    @IBOutlet weak var clientPhoto: UIImageView!
    
    
    @IBOutlet weak var clientName: UILabel!
    
    
    @IBOutlet weak var dateService: UILabel!
    
    
    @IBOutlet weak var hourService: UILabel!
    
    
    @IBOutlet weak var adressService: UILabel!
    
    
    @IBOutlet weak var comentsService: UILabel!
    
    
    @IBOutlet weak var extraServicesValue: UILabel!
    
    
    @IBOutlet weak var buttonHowToGo: UIButton!
    
    @IBOutlet weak var baseprice: UILabel!
    
    @IBOutlet weak var buttonCancelService: UIButton!
    
    @IBOutlet weak var stackViewIcons: UIStackView!
    
    @IBOutlet weak var stackViewServices: UIStackView!
    
    @IBOutlet weak var buttonInformationServ: UIButton!
    
    
    var serviceBrief: Service?
    var service : Service?
    var bP : HTCBasic?
    var basePrice = 0.0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
        if  service != nil {
     //       print(K.User.base?.price)
    
            
            self.clientName.text = serviceBrief?.briefName
            self.clientPhoto.downloadedFrom(link: (serviceBrief?.briefPhoto)!, contentMode: UIViewContentMode.scaleAspectFill)
            self.dateService.text = service?.date?.toString(format: Date.DateFormat.Short)
           
            self.hourService.text = service?.date?.toString(format: .Time
            )
            
            self.adressService.text = service?.place?.address
            
            
            
            
            K.Database.ref().child("appContent").child("services").child("basic").observe(DataEventType.value, with: { (snapshot) in
                if let dict = snapshot.value as? [String:AnyObject] {
                    if let prices = dict["price"] {
                        print("entro")
                        
                        self.basePrice = (prices as? Double)!
                        let val = ((self.service?.price)!-Double(self.basePrice))
                        let formatter = NumberFormatter()
                        formatter.locale = Locale.current // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
                        formatter.numberStyle = .currency
                        formatter.minimumFractionDigits = 0
                        formatter.maximumFractionDigits = 0
                        
                        if var formattedTipAmount = formatter.string(from: val as NSNumber) {
                            
                            formattedTipAmount.remove(at: formattedTipAmount.startIndex)
                            
                            self.extraServicesValue.text = formattedTipAmount + " COP"
                            
                        }
                        
                        if var formattedTipAmount = formatter.string(from: self.basePrice as NSNumber) {
                            
                            formattedTipAmount.remove(at: formattedTipAmount.startIndex)
                            
                            self.baseprice.text  = formattedTipAmount + " COP"
                            
                        }
                    }
                   
                } else {
                    
                }
            })
            
            
            
        
            self.comentsService.text = service?.comments
            
            if (service?.additionalServices()) != nil {

            
            for ser in  (service?.additionalServices())!{
                
                // image icon
                let imageName = "iconServiceChecked.png"
                let image = UIImage(named: imageName)
                let imageView = UIImageView(image: image!)
                let widthConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 15)
                imageView.addConstraint(widthConstraint)
                let heightConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 15)
                
                imageView.addConstraint(heightConstraint)
                
                stackViewIcons.addArrangedSubview(imageView)
                
                // lable service
                let label = UILabel()
                label.text = ser.descriptionH
                label.font = UIFont(name: "Rubik-Light", size: 13)
                
                stackViewServices.addArrangedSubview(label)
            }
            
            
            }
            
            
            
            

            
        }
        else
        {
            print("el nil")
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.buttonCancelService.roundCorners(radius: K.UI.special_round_px)
        self.buttonHowToGo.roundCorners(radius: K.UI.special_round_px)
        self.clientPhoto.circleImage()
        self.buttonInformationServ.roundCorners(radius: K.UI.round_to_circle)
    }

    
    @IBAction func dismis(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func whereGo(_ sender: Any) {
       
        
        let lat = service?.place?.lat
        let lon = service?.place?.long
        
        if (UIApplication.shared.canOpenURL(URL(string:"https://maps.google.com")!))
        {
            UIApplication.shared.openURL(NSURL(string:
                "https://maps.google.com//?saddr=&daddr=\(Float(lat!)),\(Float(lon!))&directionsmode=driving")! as URL)
        } else
        {
            NSLog("Can't use com.google.maps://");
        }
 
    }
                
        

   
}
