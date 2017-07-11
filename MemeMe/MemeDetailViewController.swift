//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Azeem Mohammad on 11/07/17.
//  Copyright © 2017 Azeem Mohammad. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    var detail : UIImage!
    
    @IBOutlet weak var meme: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        meme.image = detail
    }

}
