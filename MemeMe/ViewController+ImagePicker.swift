//
//  ViewController+ImagePicker.swift
//  MemeMe
//
//  Created by Azeem Mohammad on 08/07/17.
//  Copyright © 2017 Azeem Mohammad. All rights reserved.
//

import UIKit

extension ViewController : UIImagePickerControllerDelegate {
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        chooseSourceTypeAndPresent(sourceType: .camera)
    }
    
    
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        chooseSourceTypeAndPresent(sourceType: .photoLibrary)
    }
    
    func chooseSourceTypeAndPresent(sourceType: UIImagePickerControllerSourceType) {
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)

    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePicked.image = image
        }
        shareBtn.isEnabled = true
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
