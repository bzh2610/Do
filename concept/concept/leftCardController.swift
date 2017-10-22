//
//  leftCardController.swift
//  concept
//
//  Created by Evan OLLIVIER on 22/10/2017.
//  Copyright © 2017 Evan OLLIVIER. All rights reserved.
//

import UIKit

class leftCardController: UIViewController {

     @IBOutlet weak var greyProgressMarginBottom: NSLayoutConstraint!
     @IBOutlet weak var activeProgressMarginBottom: NSLayoutConstraint!
    
    @IBOutlet weak var TableCellViewLeft: UIView!
    //  @IBOutlet weak var tableView: UITableView!
    
    
    @objc func switchFullCard(){
        ///loadSampleMeals()
        //tableView.reloadData()
        
        print("Full card");
            greyProgressMarginBottom.constant=150
            activeProgressMarginBottom.constant=150
        TableCellViewLeft.isHidden = false
        
    }
    
    
    @objc func switchSmallCard(){
        
        print("Small card");
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
