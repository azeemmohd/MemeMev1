//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Azeem Mohammad on 10/07/17.
//  Copyright © 2017 Azeem Mohammad. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
    
    let cellReuseIdentifier = "MemeCellReuseIdentifier"
    
    var memesToShow : [Meme]!
    
    func getMemes() -> [Meme] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memesToShow = getMemes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        memesToShow = getMemes()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memesToShow.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? MemeTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MemeTableViewCell.")
        }
        
        let meme = memesToShow[(indexPath as NSIndexPath).row]
        cell.memeLabel.text = meme.topText + " " + meme.bottomText
        cell.memeThumbnail.image = meme.memedImage
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showMemeDetail") {
            let detailVC =  segue.destination as! MemeDetailViewController
            let indexPath = sender as! IndexPath
            let nsIndexPath = indexPath as NSIndexPath
            let memeDetail = memesToShow[nsIndexPath.row]
            detailVC.detail = memeDetail.memedImage
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showMemeDetail", sender: indexPath)
    }
}
