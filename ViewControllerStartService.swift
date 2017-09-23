//
//  ViewControllerStartService.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 8/09/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit
import CoreLocation

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
        self.cancelServiceButton.roundCorners(radius: K.UI.light_round_px)
        self.clientPhoto.circleImage()
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
    }
    
    

    @IBAction func startService(_ sender: Any) {
      
        
        let locValue:CLLocationCoordinate2D = locationManager.location!.coordinate
        let serviceValue:CLLocationCoordinate2D = CLLocationCoordinate2DMake((service?.place?.lat)!, (service?.place?.long)!)
        
        print("serlocations = \(serviceValue.latitude) \(serviceValue.longitude)")
        
        print("mylocations = \(locValue.latitude) \(locValue.longitude)")
        
        let from = CLLocation(latitude: serviceValue.latitude, longitude: serviceValue.longitude)
        let to = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        
        let dif  = from.distance(from: to)
        print(dif)
        
        if ( dif < 30){
            
        }
        else{
            
            let alertController = UIAlertController(title: "Alerta", message: "No te encuentras en el lugar del servicio para iniciarlo.", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "ok", style: .cancel) { (action:UIAlertAction!) in
            }
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion:nil)
            
        }
        
        /*
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier:"ViewControllerEndService") as! ViewControllerEndService
        controller.briefService = self.briefService!
        controller.service = self.service
        self.present(controller, animated: true, completion: nil)
        
    */
        
    }

    
 
    @IBAction func cancelService(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
