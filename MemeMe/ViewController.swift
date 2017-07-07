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
    
    struct Meme {
        var topText : String
        var bottomText : String
        var originalImage: UIImage
        var memedImage : UIImage
    }
    
    var arrayOfMemes : [Meme] = [Meme]()
    
    @IBOutlet weak var shareBtn: UIBarButtonItem!
    
    
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    
    
    @IBOutlet weak var cameraBtn: UIBarButtonItem!
    
    @IBOutlet weak var photoPickerBtn: UIBarButtonItem!
    
    @IBOutlet weak var imagePicked: UIImageView!
    
    
    @IBOutlet weak var topTextField: UITextField!
    
    @IBOutlet weak var bottomTextField: UITextField!
    
    var activeTextField : UITextField!
    
    let imagePicker : UIImagePickerController = UIImagePickerController()
    
    @IBOutlet weak var topNav: UINavigationBar!
    
    @IBOutlet weak var bottomBar: UIToolbar!
    
    var shouldTopTextBeCleared : Bool = true
    var shouldBottomTextBeCleared : Bool = true
    var keyBoardWasManipulated : Bool = false
    
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
        shouldTopTextBeCleared = true
        shouldBottomTextBeCleared = true
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
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
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
        controller.completionWithItemsHandler = {
            (activity, success, items, error) in
            if(success && error == nil){
                self.save(memedImage: self.generateMemedImage())
                self.dismiss(animated: true, completion: nil);
            }
            else if (error != nil){
                print("Error Occured While Saving The Meme")
            }
        };
        self.present(controller, animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func keyboardWillShow(_ notification:Notification) {
        if(activeTextField == bottomTextField) {
            view.frame.origin.y = 0 - getKeyboardHeight(notification)
            keyBoardWasManipulated = true
        }
    }
    
    func keyboardWillHide(_ notification:Notification) {
        if(keyBoardWasManipulated) {
            view.frame.origin.y = 0
            keyBoardWasManipulated = false
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
        
    }
    
    
    func save(memedImage: UIImage) {
        let memeToSave = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePicked.image!, memedImage: memedImage)
        
        arrayOfMemes.append(memeToSave)
    }
    
    func generateMemedImage() -> UIImage {
        // Hide Top and Bottom Bars
        topNav.isHidden = true
        bottomBar.isHidden = true
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        //Show toolbar and navbar
        topNav.isHidden = false
        bottomBar.isHidden = false
        return memedImage
    }
}

