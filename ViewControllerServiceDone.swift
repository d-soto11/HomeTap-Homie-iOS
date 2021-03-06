//
//  ViewControllerServiceDone.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 8/09/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit

class ViewControllerServiceDone: UIViewController {

    var service: Service?
    var briefService: Service?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "ViewControllerComentsController") as! ViewControllerComents
            controller.briefService = self.briefService!
            controller.service = self.service
            self.present(controller, animated: true, completion: nil)

        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
