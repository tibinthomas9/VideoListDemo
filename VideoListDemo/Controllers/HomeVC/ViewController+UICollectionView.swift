//
//  ViewController+CollectionView.swift
//  VideoListDemo
//
//  Created by Tibin Thomas on 24/05/19.
//  Copyright © 2019 tibint. All rights reserved.
//

import UIKit



// MARK: - <#UICollectionViewDataSource#>
extension ViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! VLCollectionViewCell
        cell.nameLabel.text = mainContents?[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainContents?.count ?? 0
    }
    
    
}

// MARK: - <#UICollectionViewDelegate#>
extension ViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 0.2,
                       options: .beginFromCurrentState,
                       animations: {
                        cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { (finished) in
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath){
            //prevent user interaction during animation
            view.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.5,
                           delay: 0.0,
                           usingSpringWithDamping: 0.4,
                           initialSpringVelocity: 0.2,
                           options: .beginFromCurrentState,
                           animations: {
                            cell.transform = .identity
            }) { (finished) in
                self.performSegue(withIdentifier: "showListings", sender:  self.mainContents?[indexPath.row])
                cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                self.view.isUserInteractionEnabled = true
            }
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
}
