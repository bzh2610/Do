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
    var currentCard : UIView!
    var hiddenCard : UIView!

    func swipe_card(direction:CGFloat, velocity:CGFloat){
    
        print("swipe_card()")

        if(last_swipe_update > 2){
            last_swipe_update=0;
        }
        if(currentCard == leftCard){
            hiddenCard=rightCard
        }else{
            hiddenCard=leftCard
        }
        
        
        if(velocity > 50){
   
            self.hiddenCard.frame.origin.x=self.currentCard.frame.origin.x-self.currentCard.bounds.width - UIScreen.main.bounds.width*0.05
            
            
        }
        if(velocity < 50){
            
            self.hiddenCard.frame.origin.x=self.currentCard.frame.origin.x + self.currentCard.bounds.width + UIScreen.main.bounds.width*0.05
            
            
        }
        
        
        UIView.animate(withDuration: 1) {
            
           
            
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
                        if(self.currentCard.frame.origin.x < -self.currentCard.frame.width ){ //Complètement caché
                            self.currentCard.frame.origin.x = -self.currentCard.frame.width//->bord droit de la carte
                           
                            print("->")
                        }else if(self.currentCard.frame.origin.x < 0 ){ //bord droit
                            self.currentCard.frame.origin.x = UIScreen.main.bounds.width*0.05//visible
                           
                              print(" = ")
                        } else if(self.currentCard.frame.origin.x <= UIScreen.main.bounds.width*0.2 ){ //bord droit
                            self.currentCard.frame.origin.x = UIScreen.main.bounds.width*1//
                            
                              print("-->")
                        }else{
                              print("---------->")
                            self.currentCard.frame.origin.x = UIScreen.main.bounds.width*2
                          
                        }
                        
                        print("~~~~~~~~CHANGE")
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeBackgroundColor"),
                                                        object: nil,
                                                        userInfo: ["Sens": -1])
        
                        self.hiddenCard.frame.origin.x=self.currentCard.frame.origin.x-self.currentCard.bounds.width - UIScreen.main.bounds.width*0.05
                       
                        
                        
                    
                        
                    }else if(velocity < -50){// <--
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeBackgroundColor"),
                                                        object: nil,
                                                        userInfo: ["Sens": 1])
                        
                      //ViewController().change_bg_color(_sens: -1)
                            if(self.currentCard.frame.origin.x >= UIScreen.main.bounds.width){
                                  print("----------<")
                                
                                self.currentCard.frame.origin.x = UIScreen.main.bounds.width*0.05
                               
                            }else if(self.currentCard.frame.origin.x > 0){
                                self.currentCard.frame.origin.x = -self.currentCard.frame.width
                               
                            }else{
                                 self.currentCard.frame.origin.x = -self.currentCard.frame.width*2
                            
                            }
                        
                       self.hiddenCard.frame.origin.x=self.currentCard.frame.origin.x+self.currentCard.bounds.width + UIScreen.main.bounds.width*0.05
                        }
                       //ViewController().change_bg_color();
           
           
            
            //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopSoundNotification"), object: nil)

                } //End of animation
        
        if(currentCard == leftCard){
            currentCard=rightCard
        }else{
            currentCard=leftCard
        }
        
        
        //print(velocity)
        
      
         leftCard.updateConstraints()
    }
    
    

    
    @objc func handleTapGesture(gestureRecognizer: UIGestureRecognizer){
        print("∞~~~~~~~")



        if gestureRecognizer.state == UIGestureRecognizerState.recognized
        {
            //Card clicked
        
            if(leftCard.frame.origin.x > 0 && leftCard.frame.origin.x+leftCard.bounds.width < screenSize.width){
                leftCard.frame.size.height = (screenSize.height)+70
                leftCard.frame.size.width = (screenSize.width)+35
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
               
            }else{
                print("CANCELED")
            
            }
           
            

            
        }
       
      
    }
    
    @objc func handlePanGestureRecognizer(gestureRecognizer: UIPanGestureRecognizer){
     
        print("handlePanGestureRecognizer()")
    
        let velocity = gestureRecognizer.velocity(in: self.view)
        let position = gestureRecognizer.translation(in: self.view)
        
        if gestureRecognizer.state == UIGestureRecognizerState.changed {
           // if position.y > -1.0 && position.y < 1 {
          //  swipe_card(direction: position.x/10, velocity: velocity.x)
           // }
        }else if gestureRecognizer.state == UIGestureRecognizerState.ended {
           swipe_card(direction: position.x/10, velocity: velocity.x)
        }
    }
    
    
    override func viewDidLoad() {
         print("CardsController -> viewdidload()")
        super.viewDidLoad()
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGestureRecognizer))
        panGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(panGestureRecognizer)
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action:
            #selector(handleTapGesture))
        tapGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(tapGestureRecognizer) //détecte les clics sur

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        currentCard=leftCard
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "switchSmallCard"),
                                        object: nil,
                                        userInfo: ["active": true])
        
        self.leftCard.frame.size.width = UIScreen.main.bounds.width*0.9
        self.leftCard.frame.size.height = (self.view.frame.size.height  - self.leftCard.bounds.minY)*0.5
        self.leftCard.frame.origin.y = (self.view.frame.size.height  - self.leftCard.bounds.minY)*0.5
        
        self.rightCard.frame.size.width = UIScreen.main.bounds.width*0.9
        self.rightCard.frame.size.height = (self.view.frame.size.height  - self.rightCard.bounds.minY)*0.5
        self.rightCard.frame.origin.y = (self.view.frame.size.height  - self.rightCard.bounds.minY)*0.5
        self.rightCard.frame.origin.x=self.leftCard.frame.origin.x+self.leftCard.bounds.width + UIScreen.main.bounds.width*0.05
        
    }

    

}
