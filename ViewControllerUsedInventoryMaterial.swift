//
//  ViewControllerUsedInventoryMaterial.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 8/09/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit
import MBProgressHUD

class ViewControllerUsedInventoryMaterial: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var intCupsYellow: UILabel!
    @IBOutlet  var decimalCupsYellow: UILabel!
    @IBOutlet weak var plusYellow: UIButton!
    @IBOutlet weak var minusYellow: UIButton!
    @IBOutlet weak var viewPlusYellos: UIView!
    @IBOutlet weak var viewMinusYellos: UIView!
    
    @IBOutlet weak var intCupsBlue: UILabel!
    @IBOutlet  var decimalCupsBlue: UILabel!
    @IBOutlet weak var plusBlue: UIButton!
    @IBOutlet weak var minusBlue: UIButton!
    @IBOutlet weak var viewPlusBlue: UIView!
    @IBOutlet weak var viewMinusBlue: UIView!
    
    @IBOutlet weak var intCupsPink: UILabel!
    @IBOutlet var decimalCupsPink: UILabel!
    @IBOutlet weak var plusPink: UIButton!
    @IBOutlet weak var minusPink: UIButton!
    @IBOutlet weak var viewPlusPink: UIView!
    @IBOutlet weak var viewMinusPink: UIView!
    
    var blue: Double = 0
    
    var pink: Double = 0
    
    var yellow: Double = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.decimalCupsBlue.alpha = 0
        self.decimalCupsYellow.alpha = 0
        self.decimalCupsPink.alpha = 0
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        
        
        super.viewDidLayoutSubviews()
        self.doneButton.roundCorners(radius: K.UI.special_round_px)
        self.mainView.roundCorners(radius: K.UI.special_round_px)
        self.plusBlue.roundCorners(radius: K.UI.round_to_circle_21)
        self.viewPlusYellos.roundCorners(radius: K.UI.round_to_circle_21)
        self.viewMinusYellos.roundCorners(radius: K.UI.round_to_circle_21)
        self.viewPlusYellos.addInventoryShadow()
        self.viewMinusYellos.addInventoryShadow()
        
        self.plusYellow.roundCorners(radius: K.UI.round_to_circle_21)
        self.plusPink.roundCorners(radius: K.UI.round_to_circle_21)
        self.minusBlue.roundCorners(radius: K.UI.round_to_circle_21)
        self.viewPlusBlue.roundCorners(radius: K.UI.round_to_circle_21)
        self.viewMinusBlue.roundCorners(radius: K.UI.round_to_circle_21)
        self.viewPlusBlue.addInventoryShadow()
        self.viewMinusBlue.addInventoryShadow()
        
        self.minusYellow.roundCorners(radius: K.UI.round_to_circle_21)
        self.minusPink.roundCorners(radius: K.UI.round_to_circle_21)
        
        self.viewPlusPink.roundCorners(radius: K.UI.round_to_circle_21)
        self.viewMinusPink.roundCorners(radius: K.UI.round_to_circle_21)
        self.viewPlusPink.addInventoryShadow()
        self.viewMinusPink.addInventoryShadow()
        
       
        
        
        
        
        
        
    }
    
    @IBAction func plusInventory(_ sender: UIButton) {
        
        
        let tagObj = sender.tag
        
        switch tagObj {
        case 0:
            
            
            yellow = yellow + 0.5
            
            if(yellow.truncatingRemainder(dividingBy: 1) == 0.5){
                
                decimalCupsYellow.alpha = 1
                intCupsYellow.text = String(Int(yellow))
                
                
            }else
            {
                decimalCupsYellow.alpha = 0
                intCupsYellow.text = String(Int(yellow))
                
            }
            
           
            
        case 1:
            
            blue = blue + 0.5
            
            if(blue.truncatingRemainder(dividingBy: 1) == 0.5){
                decimalCupsBlue.alpha = 1
                intCupsBlue.text = String(Int(blue))
                
                
            }else
            {
                decimalCupsBlue.alpha = 0
                intCupsBlue.text = String(Int(blue))
                
            }
            
            
        case 2:
            pink = pink + 0.5
            
            if(pink.truncatingRemainder(dividingBy: 1) == 0.5){
                decimalCupsPink.alpha = 1
                intCupsPink.text = String(Int(pink))
                
                
            }else
            {
                decimalCupsPink.alpha = 0
                intCupsPink.text = String(Int(pink))
                
            }
            
        default:
            return
        }
    }
    
    @IBAction func minusInventory(_ sender: UIButton) {
        
        let tagObj = sender.tag
        
        switch tagObj {
        case 0:
            
            if( yellow >= 0.5){
                yellow = yellow - 0.5
                
                if(yellow.truncatingRemainder(dividingBy: 1) == 0.5){
                    
                    decimalCupsYellow.alpha = 1
                    
                    
                    intCupsYellow.text = String(Int(yellow))
                    
                    
                }else
                {
                    decimalCupsYellow.alpha = 0
                    intCupsYellow.text = String(Int(yellow))
                    
                }
            }
            
        case 1:
            if( blue >= 0.5){
                blue = blue - 0.5
                
                if(blue.truncatingRemainder(dividingBy: 1) == 0.5){
                    decimalCupsBlue.alpha = 1
                    intCupsBlue.text = String(Int(blue))
                    
                    
                }else
                {
                    decimalCupsBlue.alpha = 0
                    intCupsBlue.text = String(Int(blue))
                    
                }
            }
        case 2:
            if( pink >= 0.5){
                pink = pink - 0.5
                
                if(pink.truncatingRemainder(dividingBy: 1) == 0.5){
                    decimalCupsPink.alpha = 1
                    intCupsPink.text = String(Int(pink))
                    
                    
                }else
                {
                    decimalCupsPink.alpha = 0
                    intCupsPink.text = String(Int(pink))
                    
                }
            }
        default:
            return
        }
        
    }
    
    
    @IBAction func submitInventory(_ sender: UIButton) {
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let invent = K.User.homie?.inventory()
        
        invent?.blue = (invent?.blue)! - self.blue
        invent?.pink = (invent?.pink)! - self.pink
        invent?.yellow = (invent?.yellow)! - self.yellow
        
        K.User.homie?.saveInventory(inventory: invent!)
        K.User.homie?.save()
        MBProgressHUD.hide(for: self.view, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier:"TapBarViewController") as! MaterialTapBarViewController
                self.present(controller, animated: true, completion: nil)

        
        
        
        
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
