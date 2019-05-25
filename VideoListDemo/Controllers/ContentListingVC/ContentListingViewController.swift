//
//  ContentListingViewController.swift
//  VideoListDemo
//
//  Created by Tibin Thomas on 25/05/19.
//  Copyright © 2019 tibint. All rights reserved.
//

import UIKit
import DataFetcher

class ContentListingViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var contentModel : ContentBaseModel?
    private var currentPage = 1
    private var total = 0
    var currentCount: Int {
        return contentModel?.page?.content_items?.content?.count ?? 0
    }
    private var isFetchInProgress = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setNavigationItemRightItemWithSearchButton()
        setCustomLayoutForCollectionView(collectionView)
        if let bgImage = UIImage(named: "nav_bar"){
            //self.navigationController?.navigationBar.setBackgroundImage(bgImage,for: .default)
        }
        collectionView.prefetchDataSource = self
        //add shadow effect
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 5.0
        self.navigationController?.navigationBar.layer.shadowOpacity = 1.0
        self.navigationController?.navigationBar.layer.masksToBounds = false
        //Fetch data
        fetchContent()
    }
    
    /// fetch data with paging
    func fetchContent() {
        //prevent fetch if a fetch operation is in progress
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        if let url = Bundle.main.url(forResource: "CONTENTLISTINGPAGE-PAGE\(currentPage)", withExtension: "json"){
            let request = JsonRequest<ContentBaseModel>.init(url: url)
            request.load { [weak self](model) in
                self?.isFetchInProgress = false
                guard let model = model else{
                    return
                }
                //set model on initial load
                if self?.currentPage == 1 {
                    self?.contentModel = model
                }
                //append data to existing model
                else if let moreData = model.page?.content_items?.content{
                    
                    self?.contentModel?.page?.content_items?.content?.append(contentsOf: moreData)
                    
                }
                self?.currentPage += 1
                self?.collectionView.reloadData()
            }
        }
    }
    
    func setNavigationItemBackButtonAndWithTitle(_ name:String) {
        navigationItem.hidesBackButton = true
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 280, height: 40))
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 10, width: 20, height: 20))
        imageView.image = UIImage(named: "Back")
        let label = UILabel(frame: CGRect(x: 26, y: 0, width: 150, height: 40))
        label.text = name
        label.textColor = UIColor.white
        view.addSubview(label)
        view.addSubview(imageView)
        view.addSubview(button)
        button.addTarget(self, action: #selector(backToMain), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: view)
    }
    func setNavigationItemRightItemWithSearchButton() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        let imageView = UIImageView(frame: CGRect(x: 30, y: 10, width: 20, height: 20))
        imageView.image = UIImage(named: "search")
        view.addSubview(imageView)
        view.addSubview(button)
        button.addTarget(self, action: #selector(searchAction), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: view)
    }
    
    fileprivate func setCustomLayoutForCollectionView(_ collectionView:UICollectionView) {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 0, right: 10)
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: view.frame.width/3 - 15 , height: 200)
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
    }
    
    @objc private func backToMain() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc private func searchAction() {

    }
    
}

