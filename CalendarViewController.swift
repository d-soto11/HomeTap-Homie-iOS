//
//  CalendarViewController.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 15/07/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate , FSCalendarDataSource{
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var dateLable: UILabel!
    
    
    @IBOutlet weak var reservationArea: UIView!
    
    var pocisiones: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gs = UITapGestureRecognizer(target: self , action: #selector(respondGesture(gesture:)))
        self.reservationArea.addGestureRecognizer(gs)
        
        print ( String(describing: K.User.homie?.blocks()))
        //self.dayViewSchedule.addGestureRecognizer(gs)
        // Do any additional setup after loading the view.
        // customView.customViewHeight = customViewHeight
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        calendar.clipsToBounds = true
        self.calendar.appearance.headerMinimumDissolvedAlpha = 0.0;
        calendar.scrollDirection = .horizontal
        calendar.placeholderType = .none
        calendar.today = nil
        
        container.addHomeCellShadow()
        container.roundCorners(radius: K.UI.light_round_px)
        
        dateLable.text = Date().toCalendar()
        
       
        
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        dateLable.text = date.toCalendar()
    }
    
    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews();
        

    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    func respondGesture(gesture: UITapGestureRecognizer)
    {
        let currentPoint = gesture.location(in: reservationArea)
        
        print(String(describing: currentPoint.x) + " --- " + String(describing: currentPoint.y))
        
        
        for index in 0...25 {
            if (currentPoint.y > CGFloat((Double(index) * 40)) && currentPoint.y < CGFloat((40 * (Double(index + 1)))))
            {
                if (index < 19)
                {
                    
                    print(index)
                    if(self.pocisiones[index] == 0 )
                    {
                        
                        if (index > 0){
                            if(self.pocisiones[index - 1] == 1){
                                
                                if index > 6 {
                                    
                                    
                                    let varia = self.reservationArea.viewWithTag(index + 100 - 7) as! CustomView
                                    self.reservationArea.viewWithTag(index +  100 - 7)?.frame = CGRect.init(x: (varia.frame.origin.x), y: (varia.frame.origin.y), width: (varia.frame.width) , height:CGFloat(540) )
                                    
                                    ((self.reservationArea.viewWithTag(index + 100  - 7))as! CustomView ).blocks = 14
                                    
                                    for i in 0...6
                                    {
                                        self.pocisiones[index + i] = 1
                                    }
                                    
                                    
                                }
                            }
                            else{
                                
                                for i in 0...6
                                {
                                    self.pocisiones[index + i] = 1
                                }
                                
                                let n = CGFloat(40 * (Double(index)))
                                let viewP = CustomView(frame: CGRect.init(x: CGFloat(0), y: n, width:CGFloat( self.reservationArea.frame.width) , height:CGFloat( 278) ))
                                viewP.blocks = 7
                                viewP.startBlock = (index + 1)
                                viewP.tag = 100 + index
                                let gest1 = UIPanGestureRecognizer(target: self, action: #selector(self.dragBlock))
                                gest1.minimumNumberOfTouches = 1
                                gest1.maximumNumberOfTouches = 1
                                viewP.addGestureRecognizer(gest1)
                                self.reservationArea.addSubview(viewP)
                                
                               
                            }
                            
                            
                        }
                        else{
                            
                            for i in 0...6
                            {
                                self.pocisiones[index + i] = 1
                            }
                            
                            let n = CGFloat(40 * (Double(index)))
                            let viewP = CustomView(frame: CGRect.init(x: CGFloat(0), y: n, width:CGFloat( self.reservationArea.frame.width) , height:CGFloat( 278) ))
                                viewP.blocks = 7
                                viewP.startBlock = (index + 1)
                                viewP.tag = 100 + index
                            
                            let gest = UIPanGestureRecognizer(target: self, action: #selector(self.dragBlock))
                            gest.minimumNumberOfTouches = 1
                            gest.maximumNumberOfTouches = 1
                            viewP.addGestureRecognizer(gest)
                            
                            self.reservationArea.addSubview(viewP)
                        }
                    }
                }
            }
            
        }
        
    
    }
    
    func deleteReserv(sender:UIButton){
        //print("llego a eliminar")
        sender.superview?.removeFromSuperview()
        let bStart = ((sender.superview)as! CustomView).startBlock - 1
        let bTotal = ((sender.superview)as! CustomView).blocks - 1
        
        //print("inicio: " + String(bStart) + " termina: " + String(bTotal))
        for i in 0...bTotal
        {
            self.pocisiones[bStart + i] = 0
            //print(String(self.pocisiones[bStart + i]))
        }
        
    }
    
    
    
    func getBlocksInView(view: UIView) -> [CustomView] {
        var results = [CustomView]()
        for subview in view.subviews as [UIView] {
            if let blockView = subview as? CustomView {
                results += [blockView]
            } else {
                results += getBlocksInView(view: subview)
            }
        }
        return results
    }
    
    func dragBlock( gesture: UIPanGestureRecognizer){
        let target = gesture.view!
        
        UIView.animate(withDuration: 0, animations: {
            
            target.frame = CGRect(x: target.frame.origin.x , y: target.frame.origin.y , width: target.frame.width, height: gesture.location(in: self.reservationArea).y)
            })
        
        
    }
}
