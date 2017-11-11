//
//  ViewController.swift
//  concept
//
//  Created by Evan OLLIVIER on 24/09/2017.
//  Copyright © 2017 Evan OLLIVIER. All rights reserved.
//

import UIKit


public class ScreenInfo {
    
    public var cardsMargintop = CGFloat(0.0)
    
    
    
     public static let shared = ScreenInfo()
    
}


class ViewController: UIViewController {
    @IBOutlet weak var ProfilePicture: UIImageView!
    @IBOutlet weak var Card_Slideshow_View: UIView!
    @IBOutlet weak var Slide_image: UIImageView!
    @IBOutlet weak var Image_top: NSLayoutConstraint!
    
    @IBOutlet weak var welcome_text: UILabel!
  
    @IBOutlet weak var settings_icon: UIButton!
    @IBOutlet weak var cardsControllerMarginBottom: NSLayoutConstraint!
    @IBOutlet weak var cardsControllerMarginTop: NSLayoutConstraint!
    enum PanDirections: Int {
        case Right
        case Left
        case Bottom
        case Top
        case TopLeftToBottomRight
        case TopRightToBottomLeft
        case BottomLeftToTopRight
        case BottomRightToTopLeft
    }
    
    var gradientLayer: CAGradientLayer!
    var colorSets = [[CGColor]]()
    var currentColorSet: Int!
    var panDirection: PanDirections!
    var top_option_activated = false
    var cardsMargintop : CGFloat = 0.0;

    
    
    
   
    
    func setHomeStatus(_visible : Bool = true){
        
        if(_visible){
            self.view.bringSubview(toFront: welcome_text)
            self.view.bringSubview(toFront:  ProfilePicture)
        }else{
            self.view.sendSubview(toBack: welcome_text)
            self.view.sendSubview(toBack: ProfilePicture)
        }
    }
    @objc func changeHomeStatus(_ notification: Notification){
        
        if let info = notification.userInfo as? Dictionary<String, Bool> {
            if let s = info["Visible"]{
                setHomeStatus(_visible : s)
            }
        }
        
    }
    @objc func get_bg_change_sens(_ notification: Notification){
        // First try to cast user info to expected type
        
      
        if let info = notification.userInfo as? Dictionary<String, Int> {
              print("Valid dict")
            // Check if value present before using it
            if let s = info["Sens"] {
                  print(s)
                change_bg_color(_sens: s)
                
            }
        }else{
            print("Invalid dict")
        }
      
    }
    
    @objc func change_bg_color(_sens : Int = 1){

        
        if(_sens > 0){
            if currentColorSet < colorSets.count - _sens {
                currentColorSet! += _sens
            }
            else {
                currentColorSet = 0
            }
        }else{
            if currentColorSet + _sens >= 0 {
                currentColorSet! += _sens
            }
            else{
                currentColorSet =  colorSets.count - 1
            }
        }
        
        print(currentColorSet)
        
        let colorChangeAnimation = CABasicAnimation(keyPath: "colors")
        colorChangeAnimation.duration = 2.0
        colorChangeAnimation.toValue = colorSets[currentColorSet]
        colorChangeAnimation.fillMode = kCAFillModeForwards
        colorChangeAnimation.isRemovedOnCompletion = false
        gradientLayer.colors = colorSets[currentColorSet]

        //gradientLayer.add(colorChangeAnimation, forKey: "colorChange")
    }
    
    
    
    
    
    func createColorSets() {
        colorSets.append([UIColor.init(red: 244/255, green: 183/255, blue: 97/255, alpha: 1).cgColor, //yellow
                          UIColor.init(red: 246/255, green: 98/255, blue: 133/255, alpha: 1).cgColor]) //red
        colorSets.append([UIColor.init(red: 244/255, green: 183/255, blue: 97/255, alpha: 1).cgColor, //Yellow
                          UIColor.init(red: 156/255, green: 100/255, blue: 255/255, alpha: 1).cgColor] //Aqua
                          ) //Violet
        colorSets.append([UIColor.init(red: 52/255, green: 194/255, blue: 196/255, alpha: 1).cgColor, //Aqua
                           UIColor.init(red: 156/255, green: 100/255, blue: 255/255, alpha: 1).cgColor])//violet
        colorSets.append([UIColor.init(red: 52/255, green: 194/255, blue: 196/255, alpha: 1).cgColor, //Aqua
            UIColor.init(red: 244/255, green: 183/255, blue: 97/255, alpha: 1).cgColor])//violet

        
        currentColorSet = 0
    }
    
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()

        /*gradientLayer.startPoint = CGPoint(x: 0.0, 0.5")
        gradientLayer.endPoint = CGPoint(x: 1.0, 0.5")
        */
        gradientLayer.colors = colorSets[currentColorSet]

        
        gradientLayer.frame = self.view.bounds
        self.view.layer.addSublayer(gradientLayer)
    }
    
    
    func setFullSizeView() {
      /*  cardsControllerMarginBottom.constant = -40
        cardsControllerMarginTop.constant = -40
        self.view.sendSubview(toBack: welcome_text)
        self.view.sendSubview(toBack: ProfilePicture)
        */
    }
    
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize = UIScreen.main.bounds
        
        createColorSets()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("ViewController : viewWillAppear")
        ScreenInfo.shared.cardsMargintop=cardsControllerMarginTop.constant
        print( ScreenInfo.shared.cardsMargintop)
        print("constraint  : \(cardsControllerMarginTop.constant)");
      //  NotificationCenter.default.post(name: (NSNotification.Name(rawValue: "left"), object: nil, userInfo: ["direction": 1])
NotificationCenter.default.addObserver(self,
                                       selector: #selector(self.get_bg_change_sens),
                                       name:NSNotification.Name(rawValue: "changeBackgroundColor"),
                                       object: nil )
        
NotificationCenter.default.addObserver(self,
                                       selector: #selector(self.changeHomeStatus),
                                       name:NSNotification.Name(rawValue: "changeHomeStatus"),
                                               object: nil )
   
     //NotificationCenter.default.addObserver(self, selector: "change_bg_color:",name:NSNotification.Name(rawValue: "stopSoundNotification"), object: nil)
        super.viewWillAppear(animated)
        createGradientLayer()
         self.view.bringSubview(toFront: Card_Slideshow_View)
         self.view.bringSubview(toFront: welcome_text)
        self.view.bringSubview(toFront: settings_icon)
         self.view.bringSubview(toFront: ProfilePicture)
        self.welcome_text.textColor = UIColor.white
        settings_icon.setImage(#imageLiteral(resourceName: "settings_highlight"), for: UIControlState.highlighted)
        setFullSizeView()
       // self.view.addSubview(v)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



