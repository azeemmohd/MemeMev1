//
//  ViewController.swift
//  MemeMe
//
//  Created by Azeem Mohammad on 06/07/17.
//  Copyright © 2017 Azeem Mohammad. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    @IBOutlet weak var shareBtn: UIBarButtonItem!
    
    
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    
    
    @IBOutlet weak var cameraBtn: UIBarButtonItem!
    
    @IBOutlet weak var photoPickerBtn: UIBarButtonItem!
    
    @IBOutlet weak var imagePicked: UIImageView!
    
    
    @IBOutlet weak var topTextField: UITextField!
    
    @IBOutlet weak var bottomTextField: UITextField!
    
    let imagePicker : UIImagePickerController = UIImagePickerController()
    
    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -2.0]
    
    
    func resetUI() {
        shareBtn.isEnabled = false
        cancelBtn.isEnabled = true
        cameraBtn.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        setupTextFields()
    }
    
    func setupTextFields() {
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTTOM"
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = .center
        bottomTextField.textAlignment = .center
    }
    
    
    override func viewDidLoad(){
        topTextField.delegate = self
        bottomTextField.delegate = self
        imagePicker.delegate = self
        resetUI()
    }

    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
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
    
    
    @IBAction func clearAll(_ sender: Any) {
        imagePicked.image = nil
        resetUI()
    }
    
    
    @IBAction func shareMeme(_ sender: Any) {
        let image = imagePicked.image!
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.present(controller, animated: true, completion: nil)
    }
    
    

}

