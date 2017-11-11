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
    
    @IBOutlet weak var addButtonMarginRight: NSLayoutConstraint!
    @IBOutlet weak var addButtonMarginBottom: NSLayoutConstraint!
    @IBOutlet weak var newReminder: UIView!
    @IBOutlet weak var TableCellViewLeft: UIView!
    @IBOutlet weak var addButtonKeyboardBottomMargin: NSLayoutConstraint!
    @IBOutlet weak var addButtonKeyboard: UIImageView!
    //  @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButtonKeyboardWidth: NSLayoutConstraint!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    
    @objc func switchSmallCard(){
        
        print("Small card");
        addButton.isHidden=true
        cardTitleMarginBottom.constant = 70
        greyProgressMarginBottom.constant=30
        TableCellViewLeft.isHidden = true
        addButtonKeyboard.isHidden=true
        activeProgressMarginBottom.constant=30
        cancelButton.isHidden=true
        
    }
    
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
    
    @IBAction func HIDE(_ sender: UIButton) {
        newReminder.isHidden=true
        TableCellViewLeft.isHidden=false
    }
    
    @IBAction func SHOW(_ sender: UIButton) {
        
        TableCellViewLeft.isHidden=true
        newReminder.isHidden = false
        //newReminder.becomeFirstResponder()
        print("Image Tapped")
    }
    
    @objc func hideKeyboard(){
        addButtonMarginRight.constant = 50
        addButtonMarginBottom.constant = 200
        addButton.setBackgroundImage(#imageLiteral(resourceName: "new_event"), for: UIControlState.normal)
        addButtonKeyboardWidth.constant = 0
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    @objc func add_button_top_keyboard(_ notification: Notification){
        print("add_button_top_keyboard")
        var keyboardHeight :CGFloat = 0
    if let info = notification.userInfo as? Dictionary<String, CGFloat> {
    if let s = info["Height"]{
        TableCellViewLeft.isHidden=true
        keyboardHeight = s
    }
    }
        print(keyboardHeight)
        addButtonMarginRight.constant = (UIScreen.main.bounds.width+35)/2-25
        addButtonMarginBottom.constant = keyboardHeight + 49
        addButton.setBackgroundImage(nil, for: UIControlState.normal)
        addButtonKeyboard.isHidden=false
        addButtonKeyboardBottomMargin.constant = 330 + 46
        
        addButtonKeyboardWidth.constant = UIScreen.main.bounds.width+35
        
        UIView.animate(withDuration: 2.0) {
            self.view.layoutIfNeeded()
        }
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
           TableCellViewLeft.isHidden = true
            //newReminder.becomeFirstResponder()
            print("Image Tapped")
            //Here you can initiate your new ViewController
            
        }
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

    
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(self.add_button_top_keyboard),
                                                   name:NSNotification.Name(rawValue: "addTopKeyboard"),
                                                   object: nil )
            
            
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(self.hideKeyboard),
                                                   name: NSNotification.Name(rawValue: "hideKeyboard"),
                                                   object: nil)

            
            
    }
            
            

    
    
}
