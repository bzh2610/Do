//
//  newReminderController.swift
//  concept
//
//  Created by Evan OLLIVIER on 24/10/2017.
//  Copyright © 2017 Evan OLLIVIER. All rights reserved.
//

import Foundation
import UIKit

// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


extension cardsController : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIPanGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view!.superview!.superclass! .isSubclass(of: newReminderController.self) {
            return false
        }
        return true
    }
}

class newReminderController: UIViewController {

    @IBOutlet var newReminderView: UIView!
    
    @IBOutlet weak var textfield: UITextField!
    
    @IBOutlet weak var btn: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isUserInteractionEnabled=true
        print(self.view.isUserInteractionEnabled)
       
        

    }
    
}



