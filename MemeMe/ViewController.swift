//
//  ViewController.swift
//  MemeMe
//
//  Created by Azeem Mohammad on 06/07/17.
//  Copyright © 2017 Azeem Mohammad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
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

    var keyBoardWasManipulated : Bool = false
    
    var shouldTextBeClearedDictionary = [UITextField : Bool]()
    
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
        configure(textField: topTextField, withText: "TOP")
        configure(textField: bottomTextField, withText: "BOTTOM")
    }
    
    func configure (textField: UITextField, withText: String) {
        textField.text = withText
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        shouldTextBeClearedDictionary[textField] = true
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
    
    

    
    
    @IBAction func clearAll(_ sender: Any) {
        imagePicked.image = nil
        resetUI()
    }
    
    
    @IBAction func shareMeme(_ sender: Any) {
        let image = self.generateMemedImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        controller.completionWithItemsHandler = {
            (activity, success, items, error) in
            if(success && error == nil){
                self.save(memedImage: image)
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
        if(activeTextField != nil && activeTextField == bottomTextField) {
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
    
    func hideNavAndToolBar(hide : Bool) {
        topNav.isHidden = hide
        bottomBar.isHidden = hide
    }
    
    func generateMemedImage() -> UIImage {
        hideNavAndToolBar(hide: true)
        
        // Render view to an image.
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        hideNavAndToolBar(hide: false)
        
        return memedImage
    }
}

