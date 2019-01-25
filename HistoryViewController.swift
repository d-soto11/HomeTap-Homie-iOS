//
//  HistoryViewController.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 15/07/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit
import FirebaseAuth

class HistoryViewController: UIViewController , UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var nohistoryText: UITextView!
    
    
    @IBOutlet weak var configureSchedule: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
     var services:[Service] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "CustomHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomHistoryTableViewCell")
        
        Auth.auth().addStateDidChangeListener(){auth, user in
            if user != nil {
                Homie.withID(id: (user?.uid)!, callback: {(homie) in
                    if homie == nil {
                        
                        self.performSegue(withIdentifier: "FillDataSeg", sender: self)
                    }
                    else{
                        
                        K.User.homie = homie
                        if (K.User.homie?.history_brief()) != nil {
                            
                            K.User.homie = homie
                            self.services = (K.User.homie?.history_brief())!
                            self.tableView.reloadData()
                            
                        }
                        else
                        {
                            self.tableView.alpha = 0
                            self.nohistoryText.alpha = 1
                            self.configureSchedule.alpha = 1
                            self.configureSchedule.isEnabled = true
                            
                            
                        }
                        
                    }
                    
                })
            }else{
                
                self.performSegue(withIdentifier: "AuthSeg", sender: self)
            }
            
        }

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
     self.configureSchedule.roundCorners(radius: K.UI.special_round_px)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goToCalendar(_ sender: Any) {
        
        configureSchedule.tag = 1
        
        K.MaterialTapBar.TapBar?.tabBarTap( configureSchedule)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomHistoryTableViewCell") as? CustomHistoryTableViewCell {
            
            
            let obj = objectCell(brief: services[indexPath.row])
            
            if(obj.state == -1){
                
                cell.stateLable.text = "Cancelado"
                cell.stateLable.textColor = K.UI.alert_color
                
            }
            
            cell.hourLable.text = obj.hour
            cell.nameLable.text = obj.name + " " + obj.lastName
            cell.dateLable.text = obj.date?.toString(format: .Short)
            cell.clientImage.circleImage()
            cell.clientImage.downloadedFrom(link: obj.imageClient , contentMode: .scaleAspectFill)
            cell.payedLable.text = obj.price
            cell.mainBackground.addHomeCellShadow()
            cell.mainBackground.roundCorners(radius: K.UI.light_round_px)
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor.clear
            cell.selectedBackgroundView = backgroundView
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            return cell
        } else {
            let vc = UIViewController.init(nibName: "CustomHistoryTableViewCell", bundle: nil)
            if let cell = vc.view as? CustomHistoryTableViewCell{
                
                //cargar informacion al cell
                 let obj = objectCell(brief: services[indexPath.row])
                
                cell.hourLable.text = obj.hour
                cell.nameLable.text = obj.name + obj.lastName
                cell.dateLable.text = obj.date?.toString(format: .Short)
                cell.clientImage.circleImage()
                cell.clientImage.downloadedFrom(link: obj.imageClient , contentMode: .scaleAspectFill)
                cell.payedLable.text = obj.price
                
                cell.mainBackground.addHomeCellShadow()
                cell.mainBackground.roundCorners(radius: K.UI.light_round_px)
                let backgroundView = UIView()
                backgroundView.backgroundColor = UIColor.clear
                cell.selectedBackgroundView = backgroundView
                cell.selectionStyle = UITableViewCellSelectionStyle.none
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
        return 120.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "HistoryServiceSummaryViewController") as! HistoryServiceSummaryViewController
        controller.serviceBrief = services[indexPath.row]
        Service.withID(id: services[indexPath.row].uid!) { (service) in
            controller.service = service
        }

        self.present(controller, animated: true, completion: nil)
    }
    
    
    
}
