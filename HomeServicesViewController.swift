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
    
    var services:[Service] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        
        Auth.auth().addStateDidChangeListener(){auth, user in
            if user != nil {
                Homie.withID(id: getCurrentUserUid()!, callback: {(homie) in
                    if homie == nil {
                        
                        self.performSegue(withIdentifier: "FillDataSeg", sender: self)
                    }
                    else{
                        K.User.current = homie
                        self.services = (K.User.current?.services_brief())!
                        self.tableView.reloadData()
                    }
                
                })
            }else{
                self.performSegue(withIdentifier: "AuthSeg", sender: self)
            }
        
        }
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

            cell.idService = obj.idService
            cell.dayLable.text = String(obj.day)
            cell.monthLable.text = obj.month
            cell.hourLable.text = obj.hour
            cell.lastNameLable.text = obj.lastName
            cell.nameLable.text = obj.name
            //cell.userImageView.downloadedFrom(link: obj.imageClient, contentMode: .scaleAspectFill)
            cell.serviceValueLable.text = obj.price
            
            
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
            let vc = UIViewController.init(nibName: "CustomTableViewCell", bundle: nil)
            if let cell = vc.view as? CustomTableViewCell{
                
                print("entro aca b")
                let obj = objectCell(brief: services[indexPath.row])
                
                cell.idService = obj.idService
                cell.dayLable.text = String(obj.day)
                cell.monthLable.text = obj.month
                cell.hourLable.text = obj.hour
                cell.lastNameLable.text = obj.lastName
                cell.nameLable.text = obj.name
                //cell.userImageView.image = obj.cargarImagen(url: obj.imageClient)
                cell.serviceValueLable.text = obj.price
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
    
    //func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //performSegueWithIdentifier("WebSegue", sender: indexPath)
        //tableView.deselectRowAtIndexPath(indexPath, animated: true)
    //}
    
    
}
