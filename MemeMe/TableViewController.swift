//
//  TableViewController.swift
//  MemeMe
//
//  Created by tarik on 4/21/17.
//  Copyright © 2017 Udacity Tarik. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var meme: [Meme]!
    
    override func viewDidLoad() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        meme = appDelegate.memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meme.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memeEditor = self.storyboard!.instantiateViewController(withIdentifier: "Meme Editor") as! ViewController
        self.navigationController!.pushViewController(memeEditor, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell")!
        
        let memeInstance = self.meme[(indexPath as NSIndexPath).row]
        
        cell.imageView?.image = memeInstance.memeImage
        
        cell.textLabel?.text = memeInstance.topTextField
        
        cell.detailTextLabel?.text = memeInstance.bottomTextField
        
        return cell
    }
    
}

    
