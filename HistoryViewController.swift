//
//  HistoryViewController.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 15/07/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController , UITableViewDataSource, UITableViewDelegate  {
   
    
    @IBOutlet weak var tableView: UITableView!
    
    var history : [Int] = [1,2,3,4]

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
            
            cell.mainBackground.layer.cornerRadius = 8
            cell.mainBackground.layer.masksToBounds = true
            
            cell.shadowLayer.layer.masksToBounds = false
            cell.shadowLayer.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell.shadowLayer.layer.shadowColor = UIColor.black.cgColor
            cell.shadowLayer.layer.shadowOpacity = 0.23
            cell.shadowLayer.layer.shadowRadius = 4
            
            cell.shadowLayer.layer.shadowPath = UIBezierPath(roundedRect: cell.shadowLayer.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
            cell.shadowLayer.layer.shouldRasterize = true
            cell.shadowLayer.layer.rasterizationScale = UIScreen.main.scale
            
            print("entro aca a")
            return cell
        } else {
            let vc = UIViewController.init(nibName: "CustomHistoryTableViewCell", bundle: nil)
            if let cell = vc.view as? CustomHistoryTableViewCell{
                
                print("entro aca b")
                //cargar informacion al cell
                
                return cell
            }
            else
            {
                
                print("entro aca c")
                return UITableViewCell()
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ResumeServiceSeg", sender: indexPath)
    }

}
