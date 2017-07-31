//
//  CustomTableViewCell.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 28/07/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var nameLable: UILabel!
    
    @IBOutlet weak var lastNameLable: UILabel!
    
    @IBOutlet weak var serviceValueLable: UILabel!
    
    @IBOutlet weak var dateView: UIView!
    
    @IBOutlet weak var monthLable: UILabel!
    
    @IBOutlet weak var dayLable: UILabel!
    
    @IBOutlet weak var hourLable: UILabel!
    
    var idService: String = ""
    
   
    /*
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
 */
    
}
