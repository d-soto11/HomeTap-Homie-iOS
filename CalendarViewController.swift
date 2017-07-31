//
//  CalendarViewController.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 15/07/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var viewExample: InventoryLevel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
        
        self.viewExample.layer.borderWidth = 2
        self.viewExample.layer.borderColor = UIColor(red:252/255.0, green:225/255.0, blue:150/255.0, alpha: 1.0).cgColor
        self.viewExample.layer.cornerRadius = 20
        
        self.viewExample.colorInventory = "Pink"
        self.viewExample.amount = 88
        
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
