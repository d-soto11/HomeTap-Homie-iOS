//
//  HistoryServiceSummaryViewController.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 11/08/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit

class HistoryServiceSummaryViewController: UIViewController {

    
    @IBOutlet weak var clientPhoto: UIImageView!
    
    var serviceBrief : Service?
    var servie : Service?
    
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


}
