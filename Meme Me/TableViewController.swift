//
//  TableViewController.swift
//  Meme Me
//
//  Created by Tony Buckner on 10/18/17.
//  Copyright © 2017 Tony Buckner. All rights reserved.
//

import Foundation
import UIKit

//TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate

class TableViewController: UITableViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //"TCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: "TCell")!
        let meme = self.appDelegate.memes[(indexPath as NSIndexPath).row]
        
        //normal settings
        cell.imageView?.image = meme.memedImage
        cell.textLabel?.text = meme.topText
        cell.detailTextLabel?.text = meme.bottomText
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Hello")
        
        let sentMeme = self.storyboard!.instantiateViewController(withIdentifier: "SentMemeController") as! SentMemeController
        let meme = self.appDelegate.memes[(indexPath as NSIndexPath).row]
        sentMeme.meme = meme
        
        self.navigationController!.pushViewController(sentMeme, animated: true)
    }
    @IBAction func newMeme(_ sender: Any) {
        
        //these two lines gave me initialization errors
        //self.present(ViewController(), animated: true, completion: nil)
        //self.navigationController!.pushViewController(ViewController(), animated: true)
    }
    
}

