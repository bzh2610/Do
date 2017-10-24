//
//  leftCardController.swift
//  concept
//
//  Created by Evan OLLIVIER on 22/10/2017.
//  Copyright © 2017 Evan OLLIVIER. All rights reserved.
//

import UIKit

class leftCardController: UIViewController {

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var greyProgressMarginBottom: NSLayoutConstraint!
     @IBOutlet weak var activeProgressMarginBottom: NSLayoutConstraint!
    @IBOutlet weak var cardTitleMarginBottom: NSLayoutConstraint!
    
    @IBOutlet weak var newReminder: UIView!
    @IBOutlet weak var TableCellViewLeft: UIView!
    //  @IBOutlet weak var tableView: UITableView!
    
    
    @objc func switchFullCard(){
        ///loadSampleMeals()
        //tableView.reloadData()
        
        print("Full card");
        addButton.isHidden=false
        cardTitleMarginBottom.constant = UIScreen.main.bounds.height-250
            greyProgressMarginBottom.constant=150
            activeProgressMarginBottom.constant=150

        TableCellViewLeft.isHidden = false
        
    }
    
    
    @IBAction func SHOW(_ sender: UIButton) {
        
        TableCellViewLeft.frame.size.width = 0
        newReminder.isHidden = false
        //newReminder.becomeFirstResponder()
        print("Image Tapped")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // let tapGesture = UITapGestureRecognizer(target: self, action: #selector(leftCardController.imageTapped(gesture:)))
       
       // addButton.addGestureRecognizer(tapGesture)
        // make sure imageView can be interacted with by user
      //  addButton.isUserInteractionEnabled = true
    }
    
    

    @objc func imageTapped(gesture: UIGestureRecognizer){
        
        
    
       
        // if the tapped view is a UIImageView then set it to imageview
        if (gesture.view as? UIImageView) != nil {
            TableCellViewLeft.frame.size.width = 0
            newReminder.isHidden = false
            //newReminder.becomeFirstResponder()
            print("Image Tapped")
            //Here you can initiate your new ViewController
            
        }
    }
    
    
    @objc func switchSmallCard(){
        
        print("Small card");
          addButton.isHidden=true
         cardTitleMarginBottom.constant = 70
        greyProgressMarginBottom.constant=30
         TableCellViewLeft.isHidden = true
       
        activeProgressMarginBottom.constant=30
        
        
    }
    
    
    
    
        override func viewWillAppear(_ animated: Bool) {
            
            
    NotificationCenter.default.addObserver(self,
                                                selector: #selector(self.switchFullCard),
                                                name:NSNotification.Name(rawValue: "switchFullCard"),
                                                object: nil )
        
                NotificationCenter.default.addObserver(self,
                                                       selector: #selector(self.switchSmallCard),
                                                       name:NSNotification.Name(rawValue: "switchSmallCard"),
                                                       object: nil )
    }
            
            

    
    
}
