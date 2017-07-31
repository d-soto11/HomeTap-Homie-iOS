//
//  MaterialTabBarViewController.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 17/07/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class MaterialTabBarViewController: UIViewController {

    
    @IBOutlet weak var tabBarBackground: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet var buttons: [UIButton]!
    
    var viewControllers: [UIViewController]!
    var selectedIndex: Int = 2
    
    var inventoryViewController : UIViewController!
    var calendarViewController: UIViewController!
    var homeViewController: UIViewController!
    var historyViewController: UIViewController!
    var profileViewController: UIViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        inventoryViewController = storyboard.instantiateViewController(withIdentifier: "InventoryView")
        
        calendarViewController = storyboard.instantiateViewController(withIdentifier: "CalendarView")
        
         homeViewController = storyboard.instantiateViewController(withIdentifier: "Home2View")
        
         historyViewController = storyboard.instantiateViewController(withIdentifier: "HistoryView")
        
         profileViewController = storyboard.instantiateViewController(withIdentifier: "ProfileView")
        
        viewControllers = [inventoryViewController, calendarViewController,homeViewController,historyViewController,profileViewController]
        
        buttons[selectedIndex].isSelected = true
        didPressTab(buttons[selectedIndex])
        
        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressTab(_ sender: UIButton) {
        
        K.Database.ref = Database.database().reference()
        
        let previousIndex = selectedIndex
        
        selectedIndex = sender.tag
        
        buttons[previousIndex].isSelected = false
        
        let previousVC = viewControllers[previousIndex]
        
        previousVC.willMove(toParentViewController: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParentViewController()
        
        sender.isSelected = true
        let vc = viewControllers[selectedIndex]
        addChildViewController(vc)
        vc.view.frame = mainView.bounds
        mainView.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        if Auth.auth().currentUser != nil {
            
            K.Database.ref!.child("homies").observeSingleEvent(of: .value, with: { (snapshot) in
                
                if snapshot.hasChild(getCurrentUserUid()!){
                    
                    print("the homie has information")
                    setCurrentUser()
                    
                }else{
                    
                    self.performSegue(withIdentifier: "FillDataSeg", sender: self)
                }
                
                
            }){ (error) in
                print(error.localizedDescription)
            }
            
        } else {
            
            self.performSegue(withIdentifier: "AuthSeg", sender: self)
            
        }
        
    }
    

    

}
