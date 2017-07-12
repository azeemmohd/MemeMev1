//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Azeem Mohammad on 10/07/17.
//  Copyright © 2017 Azeem Mohammad. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MemeCollectionReuse"

class SentMemesCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memesToShow : [Meme]!
    
    func getMemes() -> [Meme] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memes
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        memesToShow = getMemes()
        let space:CGFloat = 3.0
        let dimensionW = (view.frame.size.width - (2 * space)) / 3.0
        let dimensionH = (view.frame.size.height - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimensionW, height: dimensionH)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        memesToShow = getMemes()
        collectionView?.reloadData()
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memesToShow.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MemeMeCollectionViewCell
        let meme = memesToShow[(indexPath as NSIndexPath).row]
        cell.memeThumbnail.image = meme.memedImage
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showCollectionDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showCollectionDetail") {
            let detailVC =  segue.destination as! MemeDetailViewController
            let indexPath = sender as! IndexPath
            let nsIndexPath = indexPath as NSIndexPath
            let memeDetail = memesToShow[nsIndexPath.row]
            detailVC.detail = memeDetail.memedImage
        }
    }

}
