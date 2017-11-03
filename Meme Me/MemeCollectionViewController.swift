//
//  MemeCollectionViewController.swift
//  Meme Me
//
//  Created by Tony Buckner on 9/15/17.
//  Copyright © 2017 Tony Buckner. All rights reserved.
//
//NOT IN USE!!!!!!!
import Foundation
import UIKit

class MemeCollectionViewController : UICollectionViewController {
    var memes: [Meme]!

    override func viewDidLoad() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
    }
}

