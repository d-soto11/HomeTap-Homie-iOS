//
//  HomeServicesViewController.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 28/07/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit
import FirebaseAuth
class HomeServicesViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var ilustrationNoBooking: UIImageView!
    
    @IBOutlet weak var textNoBooking: UITextView!
    
    @IBOutlet weak var configureScheduleButton: UIButton!
    
    @IBOutlet weak var textBookings: UILabel!
    
    var services:[Service] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        
        Auth.auth().addStateDidChangeListener(){auth, user in
            if user != nil {
                Homie.withID(id: (user?.uid)!, callback: {(homie) in
                    if homie == nil {
                        
                        self.performSegue(withIdentifier: "FillDataSeg", sender: self)
                    }
                    else{
                        K.User.homie = homie
                        K.User.inventory()
                        
                        if (K.User.homie?.services_brief()) != nil {
                            
                            K.User.homie = homie
                            self.services = (K.User.homie?.services_brief())!
                            self.tableView.reloadData()
                           
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let controller = storyboard.instantiateViewController(withIdentifier: "ViewControllerStartService") as! ViewControllerStartService
                            controller.briefService = self.services[0]
                            
                            Service.withID(id: self.services[0].uid!) { (service) in
                                controller.service = service
                            }
                            self.present(controller, animated: true, completion: nil)
                            
                            
                            
                        }
                        else
                        {
                            self.tableView.alpha = 0
                            self.textBookings.alpha = 0
                            self.textNoBooking.alpha = 1
                            self.ilustrationNoBooking.alpha = 1
                            self.configureScheduleButton.alpha = 1
                            self.configureScheduleButton.isEnabled = true
                            
                        }
                        
                    }
                    
                })
            }else{
            
                self.performSegue(withIdentifier: "AuthSeg", sender: self)
            }
            
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        self.configureScheduleButton.roundCorners(radius: K.UI.special_round_px)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as? CustomTableViewCell {
            
            let obj = objectCell(brief: services[indexPath.row])
            
           
            cell.dayLable.text = String(obj.day)
            cell.monthLable.text = obj.month
            cell.hourLable.text = obj.hour
            cell.lastNameLable.text = obj.lastName
            cell.nameLable.text = obj.name
            cell.userImageView.circleImage()
            cell.userImageView.downloadedFrom(link: obj.imageClient , contentMode: .scaleAspectFill)
            cell.serviceValueLable.text = obj.price
            
            cell.mainBackground.addHomeCellShadow()
            cell.mainBackground.roundCorners(radius: K.UI.light_round_px)
            
            
            return cell
        } else {
            let vc = UIViewController.init(nibName: "CustomTableViewCell", bundle: nil)
            if let cell = vc.view as? CustomTableViewCell{
                
                
                let obj = objectCell(brief: services[indexPath.row])
                
                
                cell.dayLable.text = String(obj.day)
                cell.monthLable.text = obj.month
                cell.hourLable.text = obj.hour
                cell.lastNameLable.text = obj.lastName
                cell.nameLable.text = obj.name
                cell.userImageView.circleImage()
                cell.userImageView.downloadedFrom(link: obj.imageClient , contentMode: .scaleAspectFill)
                cell.serviceValueLable.text = obj.price
                cell.mainBackground.addHomeCellShadow()
                cell.mainBackground.roundCorners(radius: K.UI.light_round_px)
                
                
                return cell
            }
            else
            {
                return UITableViewCell()
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0
    }
    
    @IBAction func goToCalendar(_ sender: Any) {
        
        configureScheduleButton.tag = 1
        
        K.MaterialTapBar.TapBar?.tabBarTap( configureScheduleButton)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "HomeSummaryServiceViewController") as! HomeSummaryServiceViewController
        controller.serviceBrief = services[indexPath.row]
        
        Service.withID(id: services[indexPath.row].uid!) { (service) in
            controller.service = service
        }
        self.present(controller, animated: true, completion: nil)
    }

    
    
}
