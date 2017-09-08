//
//  ViewControllerStartService.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 8/09/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit

class ViewControllerStartService: UIViewController {

    
    @IBOutlet weak var clientName: UILabel!
    
    @IBOutlet weak var clientPhoto: UIImageView!
    
    @IBOutlet weak var serviceAdress: UILabel!
    
    @IBOutlet weak var serviceHour: UILabel!
    
    @IBOutlet weak var startServiceButton: UIButton!
    
    
    @IBOutlet weak var cancelServiceButton: UIButton!
    
    var service: Service?
    var briefService : Service?
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        self.startServiceButton.roundCorners(radius: K.UI.special_round_px)
        self.cancelServiceButton.roundCorners(radius: K.UI.light_round_px)
        self.clientPhoto.circleImage()
        
    }
    

    @IBAction func startService(_ sender: Any) {
        
        
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "ViewControllerEndService") as! ViewControllerEndService
            controller.briefService = self.briefService!
            controller.service = self.service
            self.present(controller, animated: true, completion: nil)
        
    
        
    }

    
 
    @IBAction func cancelService(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
