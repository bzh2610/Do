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
    
    
    var keyboardHeight: CGFloat=0

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSizeTemp = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if(keyboardSizeTemp.height > CGFloat(0.00)){
                keyboardHeight = keyboardSizeTemp.height
        }
            print(keyboardHeight)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addTopKeyboard"),
                                            object: nil,
                                            userInfo: ["Height": keyboardHeight])
        }
    }
    

    

    @IBAction func resignKeyboard(_ sender: AnyObject) {
         sender.resignFirstResponder()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "hideKeyboard"),
                                        object: nil )
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
     NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)

    }
    
}



