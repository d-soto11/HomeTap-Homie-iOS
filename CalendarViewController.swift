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
    
    var pocisiones: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var tagsssView: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gs = UITapGestureRecognizer(target: self , action: #selector(respondGesture(gesture:)))
        self.reservationArea.addGestureRecognizer(gs)
        
        paintBlocks( dateN: Date())
        
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
        
       drawInUi(x: CGFloat(currentPoint.x), y: CGFloat(currentPoint.y))
        
    
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
            
            print(gesture.location(in: self.reservationArea).y)
            if(gesture.location(in: self.reservationArea).y < 983 )
            {
            target.frame = CGRect(x: target.frame.origin.x , y: target.frame.origin.y , width: target.frame.width, height: gesture.location(in: self.reservationArea).y - target.frame.origin.y)
                print(gesture.location(in: self.reservationArea).y)
            }
            
            
            })
        
        
    }
    
    func paintBlocks( dateN: Date){
        
        
        
        if let blockUser = K.User.homie?.blocks(date: dateN)
        {
            for i in blockUser {
                
                for j in i.UiFirstBlock()...i.UiBlocks()
                {
                    self.pocisiones[j] = 1
                    self.tagsssView[j] = j + 100                            }
                
                let n = CGFloat(40 * (Double(i.UiFirstBlock())))
                let viewP = CustomView(frame: CGRect.init(x: CGFloat(0), y: n, width:CGFloat( self.reservationArea.frame.width) , height:CGFloat( i.UiBlocks()*40) ))
                viewP.blocks = 7
                viewP.startBlock = (i.UiFirstBlock() + 1)
                viewP.tag = 100 + i.UiFirstBlock()
                viewP.idBlockeDB = i.uid
                
                let gest = UIPanGestureRecognizer(target: self, action: #selector(self.dragBlock))
                gest.minimumNumberOfTouches = 1
                gest.maximumNumberOfTouches = 1
                viewP.addGestureRecognizer(gest)
                
                self.reservationArea.addSubview(viewP)
            }
        }
        
        
        
       
        
    
    }
    
    func drawInUi(x: CGFloat , y: CGFloat ){
        
        
        for index in 0...25 {
            if (y > CGFloat((Double(index) * 40)) && y < CGFloat((40 * (Double(index + 1)))))
            {
                if (index < 19)
                {
                    
                    print(index)
                    if(self.pocisiones[index] == 0 )
                    {
                        
                        if (index > 0){
                            if(self.pocisiones[index - 1] == 1){
                                
                                if index > 6 {
                                   
                                    let varia = self.reservationArea.viewWithTag(self.tagsssView[index - 1]) as! CustomView
                                    self.reservationArea.viewWithTag(self.tagsssView[index - 1])?.frame = CGRect.init(x: (varia.frame.origin.x), y: (varia.frame.origin.y), width: (varia.frame.width) , height:varia.frame.height + 280 )
                                    
                                    varia.blocks = varia.blocks + 7
                                    
                                    for i in 0...6
                                    {
                                        self.pocisiones[index + i] = 1
                                        self.tagsssView[index + i] = varia.tag
                                    }
                                    
                                    
                                    
                                }
                            }
                            else{
                                
                                for i in 0...6
                                {
                                    self.pocisiones[index + i] = 1
                                    self.tagsssView[index + i] = index + 100
                                }
                                
                                let n = CGFloat(40 * (Double(index)))
                                let viewP = CustomView(frame: CGRect.init(x: CGFloat(0), y: n, width:CGFloat( self.reservationArea.frame.width) , height:CGFloat( 280) ))
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
                        else{
                            
                            for i in 0...6
                            {
                                self.pocisiones[index + i] = 1
                                self.tagsssView[index + i] = index + 100                            }
                            
                            let n = CGFloat(40 * (Double(index)))
                            let viewP = CustomView(frame: CGRect.init(x: CGFloat(0), y: n, width:CGFloat( self.reservationArea.frame.width) , height:CGFloat( 280) ))
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
    
    
    func createBlock(blockStart: Int , blocks: Int , dateN: Date){
        
        let initialTime = (3600 * (7 + (blockStart/2)))
        print(initialTime)
        let finalTime = initialTime + ((blocks/2) * 3600)
        print(finalTime)
        let  date = dateN
    }
}
