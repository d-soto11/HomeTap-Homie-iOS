//
//  CustomHistoryTableViewCell.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 1/08/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit

class CustomHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var shadowLayer: UIView!
    
    @IBOutlet weak var mainBackground: UIView!
    
    @IBOutlet weak var clientImage: UIImageView!
    
    @IBOutlet weak var nameLable: UILabel!
    
    @IBOutlet weak var dateLable: UILabel!
    
    @IBOutlet weak var hourLable: UILabel!
    
    @IBOutlet weak var stateLable: UILabel!
    
    @IBOutlet weak var payedLable: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // shadowLayer mainBackground
}
