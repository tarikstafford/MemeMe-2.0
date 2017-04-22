//
//  SavedMemeCollectionViewController.swift
//  MemeMe
//
//  Created by tarik on 4/21/17.
//  Copyright © 2017 Udacity Tarik. All rights reserved.
//

import UIKit

class SentMemeCollectionViewController: UICollectionViewController{
    
    var meme: [Meme]!
    
    override func viewDidLoad() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        meme = appDelegate.memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return meme.count
    }
    
    // Present Meme Editor With Object
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let memeEditor = self.storyboard!.instantiateViewController(withIdentifier: "Meme Editor") as! ViewController
        memeEditor.memeEdit = self.meme[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(memeEditor, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SavedMemeCollectionViewCell
        
        let memeInstance = self.meme[(indexPath as NSIndexPath).row]
        
        cell.memeImage?.image = memeInstance.memeImage
        
        return cell
    }
    
    // Present Meme Editor Without Object
    @IBAction func presentMemeEditor(_ sender: Any) {
        let memeEditor = self.storyboard!.instantiateViewController(withIdentifier: "Meme Editor") as! ViewController
        self.navigationController!.pushViewController(memeEditor, animated: true)
    }
    
}
