//
//  CalendarViewController.swift
//  HomeTapHomie
//
//  Created by juan esteban chaparro on 15/07/17.
//  Copyright © 2017 Tres Astronautas. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate , FSCalendarDataSource , FSCalendarDelegateAppearance{
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var dateLable: UILabel!
    
    
    var dateTemp: Date = Date()
    
    @IBOutlet weak var reservationArea: UIView!
    
    var pocisiones: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var tagsssView: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gs = UITapGestureRecognizer(target: self , action: #selector(respondGesture(gesture:)))
        self.reservationArea.addGestureRecognizer(gs)
        
        calendar.select(calendar.today)
        
        paintBlocks( dateN: dateTemp)
        
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
        
        dateLable.text = dateTemp.toCalendar()
        
       
        
        
        
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        
        var cal = NSCalendar.current
        cal.timeZone = NSTimeZone(abbreviation: "UTC")! as TimeZone
        let dat = cal.startOfDay(for: Date())
        
        if (date <= dat)
        {
            return false
        }
        else
        {
            return true
        }
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        var cal = NSCalendar.current
        cal.timeZone = NSTimeZone(abbreviation: "UTC")! as TimeZone
        let dat = cal.startOfDay(for: Date())
        
        if (date <= dat)

        {
            return UIColor.red
            
        }
        else
        {
            return UIColor.black
        }
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        dateLable.text = date.toCalendar()
        dateTemp = date
        for vi in reservationArea.subviews {
            vi.removeFromSuperview()
        }
        
        
        pocisiones = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        tagsssView = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        
        paintBlocks( dateN: date)
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
        let actual = sender.superview as! CustomView
        
        K.User.homie?.deleteBlock(uid: actual.idBlockeDB!)
        K.User.homie?.save()
        sender.superview?.removeFromSuperview()
        let bStart = ((sender.superview)as! CustomView).startBlock - 1
        let bTotal = ((sender.superview)as! CustomView).blocks - 1
        
        for i in 0...bTotal
        {
            self.pocisiones[bStart + i] = 0
            self.tagsssView[bStart + i] = 0
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
        
        
        print("estado inicial: pociciones :" +  self.pocisiones.description + " tags: " + self.tagsssView.description)
        let target = gesture.view! as! CustomView
        
        print("bloque inicio: " + String(target.startBlock))
        print("bloques: " + String(target.blocks))
        let initialIndex = target.startBlock + target.blocks - 1
        
        print("INICIO EN BUSQUEDA LIMITE : " + String(initialIndex))
        
        var limit = 23
        
        if(initialIndex != 23){
        for i in initialIndex...23{
            
            if (self.pocisiones[ i ] == 1 )
            {
                limit = i
                break
            }
        }
        }
        
        print("El limite es :" + String(limit))
        
        
        
        
        UIView.animate(withDuration: 0, animations: {
            
            print(gesture.location(in: self.reservationArea).y)
            if( gesture.location(in: self.reservationArea).y > CGFloat((target.startBlock + 7 - 1 ) * 40) && gesture.location(in: self.reservationArea).y < 983 )
            {
                target.frame = CGRect(x: target.frame.origin.x , y: target.frame.origin.y , width: target.frame.width, height: gesture.location(in: self.reservationArea).y - target.frame.origin.y)
                
                if(gesture.location(in: self.reservationArea).y > CGFloat((limit)*40) && gesture.location(in: self.reservationArea).y < CGFloat(40*23) )
                {
                    print("////////// ENTRA A  MAYOR QUE LIMITE //////////////")
                    let alertController = UIAlertController(title: "Alerta", message: "¿Eliminar el siguiente bloque?", preferredStyle: .alert)
                    
                    let cancelAction = UIAlertAction(title: "No", style: .cancel) { (action:UIAlertAction!) in
                        print("you have pressed No button");
                        target.frame = CGRect(x: target.frame.origin.x , y: target.frame.origin.y , width: target.frame.width, height: CGFloat( limit * 40) - target.frame.origin.y)
                        K.User.homie?.deleteBlock(uid: target.idBlockeDB!)
                        target.blocks = (limit-target.startBlock)
                        target.idBlockeDB = self.createBlock(blockStart: target.startBlock-1, blocks: limit-target.startBlock + 1 , dateN: self.dateTemp)
                        K.User.homie?.save()
                        
                        
                        for i in target.startBlock...limit
                        {
                            self.pocisiones[(target.startBlock) + i] = 1
                            self.tagsssView[(target.startBlock) + i] = target.tag
                        }
                        
                        
                        
                    }
                    alertController.addAction(cancelAction)
                    
                    let OKAction = UIAlertAction(title: "si", style: .default) { (action:UIAlertAction!) in
                        print("you have pressed Yes button");
                        
                        for vi in self.reservationArea.subviews {
                            
                            let temp = vi as! CustomView
                            if(vi.tag == self.tagsssView[limit])
                            {
                                vi.removeFromSuperview()
                                print(temp.idBlockeDB!)
                                K.User.homie?.deleteBlock(uid: temp.idBlockeDB!)
                                K.User.homie?.deleteBlock(uid: target.idBlockeDB!)
                                for i in (temp.startBlock-1)...(temp.startBlock + temp.blocks - 2)
                                {
                                    self.pocisiones[i] = 0
                                    self.tagsssView[i] = 0
                                }
                                target.frame = CGRect(x: target.frame.origin.x , y: target.frame.origin.y , width: target.frame.width, height: CGFloat( (limit + 1) * 40) - target.frame.origin.y)
                                
                                target.idBlockeDB = self.createBlock(blockStart: target.startBlock - 1, blocks: limit + 1 , dateN: self.dateTemp)
                                K.User.homie?.save()
                                target.blocks = ((limit + 1) - target.startBlock - 1)
                                
                                for i in target.startBlock...(target.startBlock + target.blocks - 1)
                                {
                                    self.pocisiones[(target.startBlock) + i] = 1
                                    self.tagsssView[(target.startBlock) + i] = target.tag
                                }

                                
                                
                                break
                            }
                        }
                        
                        
                        
                        //Call another alert here
                    }
                    alertController.addAction(OKAction)
                    
                    self.present(alertController, animated: true, completion:nil)
                    print("DESPUES DE AVISO : pociciones :" +  self.pocisiones.description + " tags: " + self.tagsssView.description)
                    

                    
                }
                
                if(gesture.location(in: self.reservationArea).y < CGFloat((limit)*40) || gesture.location(in: self.reservationArea).y > CGFloat(40*23) ) {
                    
                    print("////////// ENTRA A  MENOR QUE LIMITE //////////////")
                    
                    
                    if(gesture.state == .ended)
                    {
                         print("////////// TERMINO MOVIMIENTO //////////////")
                        
                        let locAproximation = Int(gesture.location(in: self.reservationArea).y/40)
                        
                        
                        target.frame = CGRect(x: target.frame.origin.x , y: target.frame.origin.y , width: target.frame.width, height: CGFloat(locAproximation * 40) - target.frame.origin.y)
                        
                    
                        for i in (target.startBlock - 1)...(target.startBlock + target.blocks - 2)
                        {
                            
                            self.pocisiones[i] = 0
                            self.tagsssView[i] = 0
                        }
                        print("estado  111111: pociciones :" +  self.pocisiones.description + " tags: " + self.tagsssView.description)
                        
                        K.User.homie?.deleteBlock(uid: target.idBlockeDB!)
                        target.blocks = (locAproximation - target.startBlock + 1)
                        print("bloques cambio :" + String(target.blocks))
                        print("bloque inicio  :" + String(target.startBlock))
                        
                        target.idBlockeDB = self.createBlock(blockStart: target.startBlock-1, blocks: target.blocks, dateN: self.dateTemp)
                        K.User.homie?.save()
                        
                        for i in (target.startBlock - 1)...(target.startBlock + target.blocks - 2)
                        {
                            print ("valor de i :" + String(i))
                            self.pocisiones[ i] = 1
                            self.tagsssView[ i] = target.tag
                        }
                        
                        
                        
                        print("estado  despues de actualizar: pociciones :" +  self.pocisiones.description + " tags: " + self.tagsssView.description)
                        

                        
                    }
                    
                   
                }
                

            }
            
            
        })
        
        
    }
    
    func paintBlocks( dateN: Date){
        if let blockUser = K.User.homie?.blocks(date: dateN)
        {
            for i in blockUser {
                
                let tagView = i.UiFirstBlock() + 100
                for j in i.UiFirstBlock()...(i.UiFirstBlock() + i.UiBlocks() - 1)
                {
                    self.pocisiones[j] = 1
                    self.tagsssView[j] =  tagView
                }
                
                let n = CGFloat(40 * (Double(i.UiFirstBlock())))
                let viewP = CustomView(frame: CGRect.init(x: CGFloat(0), y: n, width:CGFloat( self.reservationArea.frame.width) , height:CGFloat( i.UiBlocks()*40) ))
                viewP.blocks = i.UiBlocks()
                viewP.startBlock = (i.UiFirstBlock() + 1 )
                viewP.tag = 100 + i.UiFirstBlock()
                viewP.idBlockeDB = i.uid
            
                if(i.serviceID == nil){
                let gest = UIPanGestureRecognizer(target: self, action: #selector(self.dragBlock))
                gest.minimumNumberOfTouches = 1
                gest.maximumNumberOfTouches = 1
                viewP.addGestureRecognizer(gest)
                }
                else{
                    viewP.backgroundColor = K.UI.alert_color
                    viewP.btnClos?.isEnabled = false
                    viewP.lableEstado?.text = "Ocupado"
                }
                self.reservationArea.addSubview(viewP)
            }
        }
        
        print("estado : pociciones :" +  self.pocisiones.description + " tags: " + self.tagsssView.description)
    }
    
    func drawInUi(x: CGFloat , y: CGFloat ){
        
        
        for index in 0...23 {
            if (y > CGFloat((Double(index) * 40)) && y < CGFloat((40 * (Double(index + 1)))))
            {
                print(index)
                if (index < 15)
                {
                    
                    print(index)
                    if(self.pocisiones[index] == 0 )
                    {
                        
                        if (index > 0){
                            if(self.pocisiones[index - 1] == 1){
                                
                                if index > 9 && index < 15 {
                                    
                                    let alertController = UIAlertController(title: "Alerta", message: "¿Extender el bloque anterior?", preferredStyle: .alert)
                                    
                                    let cancelAction = UIAlertAction(title: "No", style: .cancel) { (action:UIAlertAction!) in
                                        print("you have pressed No button");
                                        
                                        for i in 0...9
                                        {
                                            self.pocisiones[index + i] = 1
                                            self.tagsssView[index + i] = index + 100
                                        }
                                        
                                        let n = CGFloat(40 * (Double(index)))
                                        let viewP = CustomView(frame: CGRect.init(x: CGFloat(0), y: n, width:CGFloat( self.reservationArea.frame.width) , height:CGFloat( 400) ))
                                        viewP.blocks = 9
                                        
                                        viewP.startBlock = (index + 1)
                                        viewP.tag = 100 + index
                                        viewP.idBlockeDB = self.createBlock(blockStart: index, blocks: 10, dateN: self.dateTemp)
                                        
                                        let gest = UIPanGestureRecognizer(target: self, action: #selector(self.dragBlock))
                                        gest.minimumNumberOfTouches = 1
                                        gest.maximumNumberOfTouches = 1
                                        viewP.addGestureRecognizer(gest)
                                        
                                        self.reservationArea.addSubview(viewP)
                                        
                                        
                                        
                                        
                                    }
                                    alertController.addAction(cancelAction)
                                    
                                    let OKAction = UIAlertAction(title: "si", style: .default) { (action:UIAlertAction!) in
                                        print("you have pressed Yes button");
                                        
                                        
                                        let varia = self.reservationArea.viewWithTag(self.tagsssView[index - 1]) as! CustomView
                                        self.reservationArea.viewWithTag(self.tagsssView[index - 1])?.frame = CGRect.init(x: (varia.frame.origin.x), y: (varia.frame.origin.y), width: (varia.frame.width) , height:varia.frame.height + 400 )
                                        K.User.homie?.deleteBlock(uid: varia.idBlockeDB!)
                                        varia.blocks = varia.blocks + 10
                                        varia.idBlockeDB = self.createBlock(blockStart: varia.startBlock-1, blocks: varia.blocks , dateN: self.dateTemp)
                                        K.User.homie?.save()
                                        for i in 0...9
                                        {
                                            self.pocisiones[index + i] = 1
                                            self.tagsssView[index + i] = varia.tag
                                        }
                                        
                                        
                                        
                                        
                                        //Call another alert here
                                    }
                                    alertController.addAction(OKAction)
                                    
                                    self.present(alertController, animated: true, completion:nil)
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                }
                            }
                            else{
                                
                                
                                var cond = true
                                
                                for i in 0...9
                                {
                                    if(self.pocisiones[index + i] == 1)
                                    {
                                        cond = false
                                        break
                                    }
                                    
                                }
                                
                                if(cond)
                                {
                                
                                for i in 0...9
                                {
                                    self.pocisiones[index + i] = 1
                                    self.tagsssView[index + i] = index + 100
                                }
                                
                                let n = CGFloat(40 * (Double(index)))
                                let viewP = CustomView(frame: CGRect.init(x: CGFloat(0), y: n, width:CGFloat( self.reservationArea.frame.width) , height:CGFloat( 400) ))
                                viewP.blocks = 10
                                
                                viewP.startBlock = (index + 1)
                                viewP.tag = 100 + index
                                viewP.idBlockeDB = createBlock(blockStart: index, blocks: 10, dateN: self.dateTemp)
                                
                                let gest = UIPanGestureRecognizer(target: self, action: #selector(self.dragBlock))
                                gest.minimumNumberOfTouches = 1
                                gest.maximumNumberOfTouches = 1
                                viewP.addGestureRecognizer(gest)
                                
                                self.reservationArea.addSubview(viewP)
                                
                                print("estado despues de agregar : pociciones :" +  self.pocisiones.description + " tags: " + self.tagsssView.description)
                                
                                }
                            }
                            
                            
                        }
                        else{
                            
                            var cond = true
                            
                            for i in 0...9
                            {
                                if(self.pocisiones[index + i] == 1)
                                {
                                    cond = false
                                    break
                                }
                                
                            }
                            
                            if(cond)
                            {
                                for i in 0...9
                                {
                                    self.pocisiones[index + i] = 1
                                    self.tagsssView[index + i] = index + 100                            }
                                
                                let n = CGFloat(40 * (Double(index)))
                                let viewP = CustomView(frame: CGRect.init(x: CGFloat(0), y: n, width:CGFloat( self.reservationArea.frame.width) , height:CGFloat( 400) ))
                                viewP.blocks = 10
                                viewP.startBlock = (index + 1)
                                viewP.tag = 100 + index
                                viewP.idBlockeDB = createBlock(blockStart: index, blocks: 10, dateN: self.dateTemp)
                                let gest = UIPanGestureRecognizer(target: self, action: #selector(self.dragBlock))
                                gest.minimumNumberOfTouches = 1
                                gest.maximumNumberOfTouches = 1
                                viewP.addGestureRecognizer(gest)
                                
                                self.reservationArea.addSubview(viewP)
                                
                                print("estado  despues de agregar: pociciones :" +  self.pocisiones.description + " tags: " + self.tagsssView.description)
                                
                            }
                            
                           }
                    }
                }
            }
            
        }
    }
    
    
    func createBlock(blockStart: Int , blocks: Int , dateN: Date)->String{
        let initialTime = Double(7.0 + (Double(blockStart)/2.0))
        let finalTime =   Double((7.0 + (Double(blockStart + blocks)/2.0)))
        let  date = dateN
        
        let blo = HTCBlock(dict: [:])
        
        blo.startHour = Date(fromString: K.blo.getHourFromSeconds(time: initialTime) , withFormat: .Custom("HH:mm"))
        blo.endHour = Date(fromString: K.blo.getHourFromSeconds(time: finalTime) , withFormat: .Custom("HH:mm"))
        blo.date = Date(fromString: date.toString(format: .Custom("yyyy-MM-dd"))!, withFormat: .Custom("yyyy-MM-dd"))
        
        let uid = (K.User.homie?.saveBlock(block: blo))
        K.User.homie?.save()
        return uid!
        
        
    }
}
