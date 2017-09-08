//
//  ViewControllerEndService.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 8/09/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit

class ViewControllerEndService: UIViewController {

    @IBOutlet weak var endServiceButton: UIButton!
    
    @IBOutlet weak var iconsStackView: UIStackView!
    
    @IBOutlet weak var callhomeTapButton: UIButton!
    
    @IBOutlet weak var servicesStackView: UIStackView!
    
    
    var service : Service?
    
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
        
        
        
        // image icon
        let imageName = "iconServiceChecked.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        let widthConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 20 )
        imageView.addConstraint(widthConstraint)
        let heightConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 20)
        
        imageView.addConstraint(heightConstraint)
        
        iconsStackView.addArrangedSubview(imageView)
        
        // lable service
        let label = UILabel()
        label.text = "Limpiar las cortinas"
        label.font = UIFont(name: "Rubik-Medium", size: 21)
        label.textColor = UIColor.white
        
        servicesStackView.addArrangedSubview(label)

        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.isOpaque = false
        
        self.endServiceButton.roundCorners(radius: K.UI.special_round_px)
        self.callhomeTapButton.roundCorners(radius: K.UI.light_round_px)
        
    }
    
    
    @IBAction func endService(_ sender: Any) {
        
        performSegue(withIdentifier: "endServiceSeg", sender:self)
        
    }

    
    @IBAction func callHomeTap(_ sender: Any) {
        
        let url = URL(string: "tel://3100000000")
        UIApplication.shared.open(url! , options: [:] , completionHandler: nil)
    }
    
}
