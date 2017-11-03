//
//  CollectionViewController.swift
//  Meme Me
//
//  Created by Tony Buckner on 10/22/17.
//  Copyright © 2017 Tony Buckner. All rights reserved.
//

import Foundation
import UIKit

//CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate

class CollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Flow Layout setup
        //let space:CGFloat = 1.0
        //let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        //flowLayout.minimumInteritemSpacing = space
        //flowLayout.minimumLineSpacing = space
        //flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    //keep the font the same as the generated memes
    func customizeTextField(textField: UITextField, defaultText: String) {
        let memeTextAttributes:[String:Any] = [
            NSStrokeColorAttributeName: UIColor.black,
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName: -5.0
        ]
        
        textField.defaultTextAttributes = memeTextAttributes
        textField.text = defaultText
        textField.textAlignment = .center
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.collectionView?.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return appDelegate.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        
        let meme = self.appDelegate.memes[(indexPath as NSIndexPath).row]
        
        customizeTextField(textField: cell.cellTopText, defaultText: meme.topText)
        customizeTextField(textField: cell.cellBottomText, defaultText: meme.bottomText)
        
        cell.cellImage.image = meme.pickedImage
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Hello")
        
        let sentMeme = self.storyboard!.instantiateViewController(withIdentifier: "SentMemeController") as! SentMemeController
        let meme = self.appDelegate.memes[(indexPath as NSIndexPath).row]
        sentMeme.meme = meme
        
        self.navigationController!.pushViewController(sentMeme, animated: true)
    }
    
}
