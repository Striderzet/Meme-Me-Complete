//
//  SentMemeController.swift
//  Meme Me
//
//  Created by Tony Buckner on 10/31/17.
//  Copyright © 2017 Tony Buckner. All rights reserved.
//

import Foundation
import UIKit

class SentMemeController: UIViewController {
    
    @IBOutlet weak var sentMeme: UIImageView!
    
    var meme: Meme!
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.sentMeme!.image = meme.memedImage
    }
}
