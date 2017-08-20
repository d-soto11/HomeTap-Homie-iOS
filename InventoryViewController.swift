//
//  InventoryViewController.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 15/07/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit

class InventoryViewController: UIViewController {

    
    @IBOutlet weak var yellowMaterialView: UIView!
    
    @IBOutlet weak var blueMaterialView: UIView!
    
    @IBOutlet weak var pinkMaterialView: UIView!
    
    
    @IBOutlet weak var yellowSecond: UIView!
    
    
    @IBOutlet weak var blueSecond: UIView!
    
    
    @IBOutlet weak var pinkSecond: UIView!
    
    
    @IBOutlet weak var heightYellow: NSLayoutConstraint!
    
    
    @IBOutlet weak var heightBlue: NSLayoutConstraint!
    
    
    @IBOutlet weak var heightPink: NSLayoutConstraint!
    
    var blue = 50
    var pink = 50
    var yellow = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        AnimateHeight()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.yellowMaterialView.layer.borderWidth = 2
        self.yellowMaterialView.layer.borderColor = UIColor(red:252/255.0, green:225/255.0, blue:150/255.0, alpha: 1.0).cgColor
        self.yellowMaterialView.layer.cornerRadius = 20
        self.blueMaterialView.layer.borderWidth = 2
        self.blueMaterialView.layer.borderColor = UIColor(red:112/255.0, green:148/255.0, blue:232/255.0, alpha: 1.0).cgColor
        self.blueMaterialView.layer.cornerRadius = 20
        self.pinkMaterialView.layer.borderWidth = 2
        self.pinkMaterialView.layer.borderColor = UIColor(red:230/255.0, green:101/255.0, blue:162/255.0, alpha: 1.0).cgColor
        self.pinkMaterialView.layer.cornerRadius = 20
        
        self.yellowSecond.layer.borderWidth = 2
        self.yellowSecond.layer.borderColor = UIColor(red:252/255.0, green:225/255.0, blue:150/255.0, alpha: 1.0).cgColor
        self.yellowSecond.backgroundColor = UIColor(red:252/255.0, green:225/255.0, blue:150/255.0, alpha: 1.0)
        self.yellowSecond.layer.cornerRadius = 20
        
        self.blueSecond.layer.borderWidth = 2
        self.blueSecond.layer.borderColor = UIColor(red:112/255.0, green:148/255.0, blue:232/255.0, alpha: 1.0).cgColor
        self.blueSecond.backgroundColor = UIColor(red:112/255.0, green:148/255.0, blue:232/255.0, alpha: 1.0)
        self.blueSecond.layer.cornerRadius = 20
        
        self.pinkSecond.layer.borderWidth = 2
        self.pinkSecond.layer.borderColor = UIColor(red:230/255.0, green:101/255.0, blue:162/255.0, alpha: 1.0).cgColor
        self.pinkSecond.backgroundColor = UIColor(red:230/255.0, green:101/255.0, blue:162/255.0, alpha: 1.0)
        self.pinkSecond.layer.cornerRadius = 20
        
        
        
           }

    
    func AnimateHeight() {
        
        UIView.animate(withDuration: 2, animations: {
            self.heightYellow.constant = self.yellowMaterialView.frame.size.height*0.7
            
           self.heightBlue.constant = self.yellowMaterialView.frame.size.height*0.6
            
            self.heightPink.constant = self.yellowMaterialView.frame.size.height*0.4
            
            
            self.view.updateConstraints()
        })
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
