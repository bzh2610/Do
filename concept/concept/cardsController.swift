//
//  cardsController.swift
//  concept
//
//  Created by Evan OLLIVIER on 29/09/2017.
//  Copyright © 2017 Evan OLLIVIER. All rights reserved.
//

import UIKit

class cardsController: UIViewController {


    


    @IBOutlet weak var rightCard: UIView!
    @IBOutlet weak var test: UILabel!
    @IBOutlet weak var leftCard: UIView!
    @IBOutlet weak var leftCardWidth: NSLayoutConstraint!
    @IBOutlet weak var LeftGreyBarMarginBottom: NSLayoutConstraint!
    let screenSize = UIScreen.main.bounds
    var last_swipe_update :TimeInterval = 0.0
    

    func swipe_card(direction:CGFloat, velocity:CGFloat){
    

        if(last_swipe_update > 2){
            last_swipe_update=0;
        }

        UIView.animate(withDuration: 0.2) {
            
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "switchSmallCard"),
                                            object: nil,
                                            userInfo: ["active": true])
            
            self.leftCard.frame.size.width = UIScreen.main.bounds.width*0.9
            self.leftCard.frame.size.height = (self.view.frame.size.height  - self.leftCard.bounds.minY)*0.5
            self.leftCard.frame.origin.y = (self.view.frame.size.height  - self.leftCard.bounds.minY)*0.5
            
            self.rightCard.frame.size.width = UIScreen.main.bounds.width*0.9
            self.rightCard.frame.size.height = (self.view.frame.size.height  - self.rightCard.bounds.minY)*0.5
            self.rightCard.frame.origin.y = (self.view.frame.size.height  - self.rightCard.bounds.minY)*0.5
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeHomeStatus"),
                                            object: nil,
                                            userInfo: ["Visible": true])
                    if(velocity > 50){ // Vers la droite
                        
                       // ViewController().change_bg_color()
                        print("droite")
                        if(self.leftCard.frame.origin.x < -self.leftCard.frame.width ){ //Complètement caché
                            self.leftCard.frame.origin.x = -self.leftCard.frame.width//->bord droit de la carte
                           
                            print("->")
                        }else if(self.leftCard.frame.origin.x < 0 ){ //bord droit
                            self.leftCard.frame.origin.x = UIScreen.main.bounds.width*0.05//visible
                           
                              print(" = ")
                        } else if(self.leftCard.frame.origin.x <= UIScreen.main.bounds.width*0.2 ){ //bord droit
                            self.leftCard.frame.origin.x = UIScreen.main.bounds.width*1//
                            
                              print("-->")
                        }else{
                              print("---------->")
                            self.leftCard.frame.origin.x = UIScreen.main.bounds.width*2
                          
                        }
                        
                        print("~~~~~~~~CHANGE")
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeBackgroundColor"),
                                                        object: nil,
                                                        userInfo: ["Sens": -1])
                        
                    }else if(velocity < -50){// <--
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeBackgroundColor"),
                                                        object: nil,
                                                        userInfo: ["Sens": 1])
                        
                      //ViewController().change_bg_color(_sens: -1)
                            if(self.leftCard.frame.origin.x >= UIScreen.main.bounds.width){
                                  print("----------<")
                                
                                self.leftCard.frame.origin.x = UIScreen.main.bounds.width*0.05
                               
                            }else if(self.leftCard.frame.origin.x > 0){
                                self.leftCard.frame.origin.x = -self.leftCard.frame.width
                               
                            }else{
                                 self.leftCard.frame.origin.x = -self.leftCard.frame.width*2
                            
                            }
                        
                        }
            self.rightCard.frame.origin.x=self.leftCard.frame.origin.x+self.leftCard.bounds.width + UIScreen.main.bounds.width*0.05
            //ViewController().change_bg_color();
           
           
            //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopSoundNotification"), object: nil)

                } //End of animation
        
        
        //print(velocity)
        
      
         leftCard.updateConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        leftCard.frame.size.width = (screenSize.width)
        leftCard.frame.origin.x = (screenSize.width*0.1)

    }
    

    
    @objc func handleTapGesture(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        print("∞~~~~~~~")
        print(touch.view)
        var result :Bool = false

            if true/*touch.view!.superview!.superclass! .isSubclass(of: newReminderController.self) {
                print("Canceled")
                return false
            }else*/{
        if gestureRecognizer.state == UIGestureRecognizerState.recognized
        {
            //Card clicked
        
            if(leftCard.frame.origin.x > 0 && leftCard.frame.origin.x+leftCard.bounds.width < screenSize.width){
                leftCard.frame.size.height = (screenSize.height)+100
                leftCard.frame.size.width = (screenSize.width)+30
                UIView.animate(withDuration: 1.2) {
                    //ViewController().hideUserInfo()
                    print( ScreenInfo.shared.cardsMargintop)
                    self.leftCard.frame.origin.y = -ScreenInfo.shared.cardsMargintop-70
                    self.leftCard.frame.origin.x = -12
                    self.view.layoutIfNeeded()
                  
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeHomeStatus"),
                                                    object: nil,
                                                    userInfo: ["Visible": false])
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "switchFullCard"),
                                                    object: nil,
                                                    userInfo: ["active": true])
                }
                print("Not a child of leftCard")
                result = true
            }
            
            else if(rightCard.frame.origin.x > 0 && rightCard.frame.origin.x+rightCard.bounds.width < screenSize.width){
                
                rightCard.frame.size.height = (screenSize.height)+100
                rightCard.frame.size.width = (screenSize.width)+30
                UIView.animate(withDuration: 1.2) {
                    //ViewController().hideUserInfo()
                    print( ScreenInfo.shared.cardsMargintop)
                    self.rightCard.frame.origin.y = -ScreenInfo.shared.cardsMargintop-70
                    self.rightCard.frame.origin.x = -12
                    self.view.layoutIfNeeded()
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeHomeStatus"),
                                                    object: nil,
                                                    userInfo: ["Visible": false])
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "switchFullCard"),
                                                    object: nil,
                                                    userInfo: ["active": true])
                }
                print("Not a child of leftCard")
                result = true
            }else{
                print("CANCELED")
                result = false
            }
           
            

            
        }
       
        }
        return result
    }
    
    @objc func handlePanGestureRecognizer(gestureRecognizer: UIPanGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
     
        
    
        let velocity = gestureRecognizer.velocity(in: self.view)
        let position = gestureRecognizer.translation(in: self.view)
        
        if gestureRecognizer.state == UIGestureRecognizerState.changed {
           // if position.y > -1.0 && position.y < 1 {
          //  swipe_card(direction: position.x/10, velocity: velocity.x)
           // }
        }else if gestureRecognizer.state == UIGestureRecognizerState.ended {
           swipe_card(direction: position.x/10, velocity: velocity.x)
        }
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGestureRecognizer))
        panGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(panGestureRecognizer)
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action:
            #selector(handleTapGesture))
        tapGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(tapGestureRecognizer) //détecte les clics sur

    
        
        // Set elements
        self.leftCard.frame.size.width = UIScreen.main.bounds.width*0.9
        self.leftCard.frame.size.height = (self.view.frame.size.height  - self.leftCard.bounds.minY)*0.5
        self.leftCard.frame.origin.y = (self.view.frame.size.height  - self.leftCard.bounds.minY)*0.5
        
        
        
        self.rightCard.frame.size.width = UIScreen.main.bounds.width*0.9
        self.rightCard.frame.size.height = (self.view.frame.size.height  - self.leftCard.bounds.minY)*0.5
        self.rightCard.frame.origin.y = (self.view.frame.size.height  - self.rightCard.bounds.minY)*0.5
        self.rightCard.frame.origin.x = (self.view.frame.size.width  - self.rightCard.frame.size.width)*0.9

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
