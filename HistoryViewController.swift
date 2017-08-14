//
//  HistoryViewController.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 15/07/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController , UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var nohistoryText: UITextView!
    
    
    @IBOutlet weak var configureSchedule: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var services : [Int] = [1,2,3,4]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "CustomHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomHistoryTableViewCell")
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomHistoryTableViewCell") as? CustomHistoryTableViewCell {
            /*
             let obj = objectCell(brief: services[indexPath.row])
             
             cell.idService = obj.idService
             cell.dayLable.text = String(obj.day)
             cell.monthLable.text = obj.month
             cell.hourLable.text = obj.hour
             cell.lastNameLable.text = obj.lastName
             cell.nameLable.text = obj.name
             //cell.userImageView.downloadedFrom(link: obj.imageClient, contentMode: .scaleAspectFill)
             cell.serviceValueLable.text = obj.price
             */
            
            cell.mainBackground.addHomeCellShadow()
            cell.mainBackground.roundCorners(radius: K.UI.light_round_px)
            
            return cell
        } else {
            let vc = UIViewController.init(nibName: "CustomHistoryTableViewCell", bundle: nil)
            if let cell = vc.view as? CustomHistoryTableViewCell{
                
                //cargar informacion al cell
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "HistoryServiceSummaryViewController") as! HistoryServiceSummaryViewController
        //controller.serviceBrief = services[indexPath.row]
        self.present(controller, animated: true, completion: nil)
    }
    
}
