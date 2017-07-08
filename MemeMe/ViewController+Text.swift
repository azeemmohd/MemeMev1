//
//  ViewController+Text.swift
//  MemeMe
//
//  Created by Azeem Mohammad on 06/07/17.
//  Copyright © 2017 Azeem Mohammad. All rights reserved.
//

import UIKit

extension ViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
        if(shouldTextBeClearedDictionary[textField] == true) {
            textField.text = ""
            shouldTextBeClearedDictionary[textField] = false
        }
    }
    
    
    
    
    
    
}
