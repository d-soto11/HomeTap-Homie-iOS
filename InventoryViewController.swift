//
//  InventoryViewController.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 15/07/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit

class InventoryViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var yellowMaterialView: UIView!
    
    @IBOutlet weak var blueMaterialView: UIView!
    
    @IBOutlet weak var pinkMaterialView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
        
        self.yellowMaterialView.layer.borderWidth = 2
        self.yellowMaterialView.layer.borderColor = UIColor(red:252/255.0, green:225/255.0, blue:150/255.0, alpha: 1.0).cgColor
        self.yellowMaterialView.layer.cornerRadius = 20
        self.blueMaterialView.layer.borderWidth = 2
        self.blueMaterialView.layer.borderColor = UIColor(red:112/255.0, green:148/255.0, blue:232/255.0, alpha: 1.0).cgColor
         self.blueMaterialView.layer.cornerRadius = 20
        self.pinkMaterialView.layer.borderWidth = 2
        self.pinkMaterialView.layer.borderColor = UIColor(red:230/255.0, green:101/255.0, blue:162/255.0, alpha: 1.0).cgColor
         self.pinkMaterialView.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
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
