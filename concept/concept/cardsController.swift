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

    func swipe_card(direction:CGPoint, velocity:CGPoint){
    
        print(velocity)
        print("swipe_card()")
        

        //UI CHANGE
        //Void switching to wrong controller when card is dismissed with (x) button
        if(direction.x == 0 && direction.y == 0 && velocity.x == 0 && velocity.y == 0){
            if(currentCard == leftCard){
               // hiddenCard=rightCard
            }else{
               // hiddenCard=leftCard
            }
        }
        
        if(last_swipe_update > 2){
            last_swipe_update=0;
        }
        if(currentCard == leftCard){
            hiddenCard=rightCard
        }else{
            hiddenCard=leftCard
        }
        
        if(currentCard.frame.height > UIScreen.main.bounds.height*0.8){
            print("Full card ~~~ Calculating position from device constant")
            if(velocity.x > 50){
                
                self.hiddenCard.frame.origin.x=UIScreen.main.bounds.width*0.05-UIScreen.main.bounds.width*0.9 - UIScreen.main.bounds.width*0.05
                
                
            }
            else if(velocity.x < -50){
                
                self.hiddenCard.frame.origin.x=UIScreen.main.bounds.width*0.05+UIScreen.main.bounds.width*0.9 + UIScreen.main.bounds.width*0.05
                
                
            }
        }
        
        else if(velocity.x > 50){
   
            self.hiddenCard.frame.origin.x=self.currentCard.frame.origin.x-self.currentCard.bounds.width - UIScreen.main.bounds.width*0.05
            
            
        }
        else if(velocity.x < -50){
            
            self.hiddenCard.frame.origin.x=self.currentCard.frame.origin.x + self.currentCard.bounds.width + UIScreen.main.bounds.width*0.05
            
            
        }
        
        
        UIView.animate(withDuration: 0.4) {
            
            if(self.currentCard.frame.height > UIScreen.main.bounds.height*0.8){
                self.currentCard.frame.origin.x = UIScreen.main.bounds.width*0.05
            }
            
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
            
            
            
            if(velocity.y > 500 && abs(velocity.x)<velocity.y ){
                
                
                 //visible
                
                if(self.currentCard == self.leftCard){
                    self.currentCard=self.rightCard
                }else{
                    self.currentCard=self.leftCard
                }
                
            }
                   else if(velocity.x > 50){ // Vers la droite
                        
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
                       
                        
                        
                    
                        
                    }else if(velocity.x < -50){// <--
                        
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
    
    
    @objc func switchSmallCardUI(){
        swipe_card(direction: CGPoint(x:0, y:0), velocity: CGPoint(x:0, y: 501))
    }
    

    @objc func handleTapGesture(gestureRecognizer: UIGestureRecognizer){
        print("∞~~~~~~~")

        if(currentCard == leftCard){
            hiddenCard=rightCard
        }else{
            hiddenCard=leftCard
        }


        if gestureRecognizer.state == UIGestureRecognizerState.recognized
        {
            //Card clicked
        
            if(currentCard.frame.origin.x > 0 && currentCard.frame.origin.x+currentCard.bounds.width < screenSize.width){
                currentCard.frame.size.height = (screenSize.height)+100
                currentCard.frame.size.width = (screenSize.width)+35
                UIView.animate(withDuration: 1.2) {
                    //ViewController().hideUserInfo()
                    print( ScreenInfo.shared.cardsMargintop)
                    self.currentCard.frame.origin.y = -ScreenInfo.shared.cardsMargintop-50
                    
                   
                    self.currentCard.frame.origin.x = -12
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
           swipe_card(direction: position, velocity: velocity)
        }
    }
    
   
    override func viewDidLoad() {
         print("CardsController -> viewdidload()")
        super.viewDidLoad()
       
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.switchSmallCardUI),
                                               name: NSNotification.Name(rawValue: "switchSmallCardUI"),
                                               object: nil)
        
        
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
