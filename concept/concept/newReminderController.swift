//
//  newReminderController.swift
//  concept
//
//  Created by Evan OLLIVIER on 24/10/2017.
//  Copyright © 2017 Evan OLLIVIER. All rights reserved.
//

import Foundation
import UIKit
import CoreData

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

extension cardsController :  UIGestureRecognizerDelegate {
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
      //  if( touch.view!.superview!.superclass! .isSubclass(of: newReminderController.self)){
            //print("false")
          //  return false
       // }
            print("True")
            return true
        
    }
    
    private func gestureRecognizer(_ gestureRecognizer: UIPanGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
     //   if touch.view!.superview!.superclass! .isSubclass(of: newReminderController.self) {
         //   print ("Touch in forbiden")
          //  return false
      //  }else{
            print ("Touch in allowed")
        return true
   // }
    }
}

class newReminderController: UIViewController {

    @IBOutlet var newReminderView: UIView!
    
    @IBOutlet weak var textfield: UITextField!
    

    
    
    
    
    @objc func enabled(){
       
        if(textfield.text != ""){
            let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            if let bd =  NSEntityDescription.insertNewObject(forEntityName: "Reminder", into: moc) as? Reminder {
                
                if let text : String = textfield.text{
                    print(text)
                bd.content=text
                }
                
                do {
                    try moc.save()
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTableView"),
                                                    object: nil)
                    
                } catch {
                    print("unable to add reminder\(error)")
                    
                }
                
                
            }
        }
        
    }
    
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
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "hideKeyboard"),
                                        object: nil )
         sender.resignFirstResponder()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
     NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)

        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.enabled),
                                               name: NSNotification.Name(rawValue: "addReminder"),
                                               object: nil)
        
        
        
    }
    
    
}



