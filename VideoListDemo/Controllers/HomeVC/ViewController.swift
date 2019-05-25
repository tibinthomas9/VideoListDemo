//
//  ViewController.swift
//  VideoListDemo
//
//  Created by Tibin Thomas on 23/05/19.
//  Copyright © 2019 tibint. All rights reserved.
//

import UIKit
import DataFetcher


class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var mainContents: [ContentModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        navigationController?.navigationBar.barTintColor = UIColor.black
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        mainContents = [ContentModel(name:"Romantic Comedy",poster_image:"poster1"),ContentModel(name:"Horror",poster_image:"poster3"),ContentModel(name:"Hip Hop",poster_image:"poster6")]
        collectionView.reloadData()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .automatic
            
        }
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
            navigationItem.largeTitleDisplayMode = .never
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? ContentListingViewController else{
            return
        }
        if let model = sender as? ContentModel{
            destinationVC.setNavigationItemBackButtonAndWithTitle(model.name ?? "")
        }
    }
}


