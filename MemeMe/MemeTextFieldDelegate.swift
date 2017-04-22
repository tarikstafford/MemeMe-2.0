//
//  MemeTextField.swift
//  MemeMe
//
//  Created by Tarik Stafford on 3/1/17.
//  Copyright © 2017 Udacity Tarik. All rights reserved.
//

import UIKit

class MemeTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    //Clear Field on Touch
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        textField.textAlignment = NSTextAlignment.center
        
    }
    
    //Pressing Enter Stops Editing
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    //Add text if field is Empty after editing
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else {
            textField.text = "ENTER TEXT"
            
            return
        }
    }
}

