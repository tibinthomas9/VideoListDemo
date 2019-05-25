//
//  ContentListingViewController+UICollectionView.swift
//  VideoListDemo
//
//  Created by Tibin Thomas on 25/05/19.
//  Copyright © 2019 tibint. All rights reserved.
//

//
//  ViewController+CollectionView.swift
//  VideoListDemo
//
//  Created by Tibin Thomas on 24/05/19.
//  Copyright © 2019 tibint. All rights reserved.
//

import UIKit
import DataFetcher

extension ContentListingViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "contentCell", for: indexPath) as! VLContentCollectionViewCell
        //prevent accessing array item out of range incase data is not yet fetched
        guard contentModel?.page?.content_items?.content?.count ?? 0 > indexPath.row else {
            return UICollectionViewCell()
        }
        if let content = contentModel?.page?.content_items?.content?[indexPath.row]  {
        //let request = ImageRequest(url: URL(string: imageUrl))
        cell.nameLabel.text = content.name
            if let image = UIImage(named: content.poster_image ?? ""){
              cell.imageView.image = image
            }
            else{
                cell.imageView.image =  UIImage(named: "placeholder_for_missing_posters.png")
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(contentModel?.page?.total_content_items ?? "") ?? 0
    }
    
    
}
extension ContentListingViewController:UICollectionViewDelegate{

}
extension ContentListingViewController:UICollectionViewDataSourcePrefetching{
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        //fetch more content when the data for prefetch items is not yet loaded
        if indexPaths.contains(where: isLoadingCell) {
            self.fetchContent()
        }
    }
    
}
extension ContentListingViewController {
    //check whether the data for indexpath is yet to be  loaded
    private func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= self.currentCount
    }
}

