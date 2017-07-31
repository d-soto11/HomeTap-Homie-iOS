//
//  HomeServicesViewController.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 28/07/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit

class HomeServicesViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    var services:[Service] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        services = (K.User.current?.services_brief())!
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as! CustomTableViewCell
        
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
    
    
    //func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //performSegueWithIdentifier("WebSegue", sender: indexPath)
        //tableView.deselectRowAtIndexPath(indexPath, animated: true)
    //}
    
    
}
