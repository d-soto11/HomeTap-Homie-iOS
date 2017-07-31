//
//  ChangeNameViewController.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 19/07/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit

class ChangeNameViewController: UIViewController {

    @IBOutlet weak var saveChangesBtt: UIButton!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var nameTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
           // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.saveChangesBtt.roundCorners(radius: K.UI.round_px)
    }
    
    @IBAction func dismis(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
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
