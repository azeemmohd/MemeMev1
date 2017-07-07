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
        switch(textField.tag) {
        case 1:
            if(shouldTopTextBeCleared) {
                textField.text = ""
                shouldTopTextBeCleared = false
            }
        case 2:
            if(shouldBottomTextBeCleared) {
                textField.text = ""
                shouldBottomTextBeCleared = false
            }
        default:
            print("No Match")
        }
    }
    
    
    
    
    
    
}
