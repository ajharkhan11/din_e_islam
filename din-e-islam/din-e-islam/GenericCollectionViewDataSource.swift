//
//  GenericCollectionViewDataSource.swift
//  din-e-islam
//
//  Created by Ajharudeen Khan on 19/10/22.
//

import UIKit

class GenericCollectionViewDataSource<CELL: UICollectionViewCell, T>: NSObject,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {


    private var cellIdentifier : String!
    
    private var items : [T]?

    var configureCell : (CELL?, T?) -> () = {_,_ in }
    
    var updateIndex : (Int) -> () = {_ in }
    
    private let sectionInsets = UIEdgeInsets(
      top: 10.0,
      left: 0.0,
      bottom: 0.0,
      right: 10.0)
    
    private let itemsPerRow: CGFloat = 1
    

    init(cellIdentifier : String, items : [T]?, configureCell : @escaping (CELL?, T?) -> (), updateIndex: @escaping (Int) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
        self.updateIndex = updateIndex
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        if let item = items?[indexPath.row] {
            self.configureCell(collectionViewCell as? CELL, item)
        }
        return collectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = indexPath.section == 0 ? sectionInsets.left * (itemsPerRow + 1) : sectionInsets.left * (1 + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize.init(width: widthPerItem, height: collectionView.frame.size.height-sectionInsets.top - sectionInsets.bottom)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x/scrollView.frame.size.width
        self.updateIndex(Int(index))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

