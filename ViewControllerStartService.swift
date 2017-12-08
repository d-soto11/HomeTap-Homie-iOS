//
//  ViewControllerStartService.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 8/09/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase

class ViewControllerStartService: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var clientName: UILabel!
    
    @IBOutlet weak var clientPhoto: UIImageView!
    
    @IBOutlet weak var serviceAdress: UILabel!
    
    @IBOutlet weak var serviceHour: UILabel!
    
    @IBOutlet weak var startServiceButton: UIButton!
    
    
    @IBOutlet weak var cancelServiceButton: UIButton!
    var locationManager = CLLocationManager()
    
    var service: Service?
    var briefService : Service?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     override func viewDidAppear(_ animated: Bool) {
    
        clientPhoto.downloadedFrom(link: (briefService?.briefPhoto)! , contentMode: .scaleAspectFill)
        clientName.text = briefService?.briefName
        serviceAdress.text = service?.place?.address
        serviceHour.text = service?.date?.toString(format: .Time)
 
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.isOpaque = false
        
        self.startServiceButton.roundCorners(radius: K.UI.special_round_px)
        self.cancelServiceButton.roundCorners(radius: K.UI.light_round_px_10)
        self.clientPhoto.circleImage()
        
    }
    
    @IBAction func startService(_ sender: Any) {
      
        
        let locValue:CLLocationCoordinate2D = locationManager.location!.coordinate
        let serviceValue:CLLocationCoordinate2D = CLLocationCoordinate2DMake((service?.place?.lat)!, (service?.place?.long)!)
        let from = CLLocation(latitude: serviceValue.latitude, longitude: serviceValue.longitude)
        let to = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        
        let dif  = from.distance(from: to)
        
        if ( dif < 500){
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier:"ViewControllerEndService") as! ViewControllerEndService
            controller.briefService = self.briefService!
            controller.service = self.service
            self.service?.state = 1
            self.service?.save()
            self.present(controller, animated: true, completion: nil)
        }
        else{
            
            let alertController = UIAlertController(title: "Alerta", message: "No te encuentras en el lugar del servicio para iniciarlo.", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "ok", style: .cancel) { (action:UIAlertAction!) in
            }
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion:nil)
            
        }
        
       
        
        
    }

    
 
    @IBAction func cancelService(_ sender: Any) {
        
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
