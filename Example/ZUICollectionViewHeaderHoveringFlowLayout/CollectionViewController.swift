//
//  CollectionViewController.swift
//  ZUICollectionViewHeaderHoveringFlowLayout
//
//  Created by ZackZheng2014 on 04/28/2017.
//  Copyright (c) 2017 ZackZheng2014. All rights reserved.
//

import UIKit
import ZUICollectionViewHeaderHoveringFlowLayout

class CollectionViewController: UICollectionViewController {

    let headerColors = [UIColor.brown, UIColor.green, UIColor.purple, UIColor.magenta, UIColor.lightGray, UIColor.black, UIColor.brown, UIColor.green, UIColor.purple, UIColor.magenta, UIColor.lightGray, UIColor.black]
    let cellColors = [UIColor.blue, UIColor.orange, UIColor.red, UIColor.yellow]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (collectionView?.collectionViewLayout as? ZUICollectionViewHeaderHoveringFlowLayout)?.sectionToHover = 2
        
        collectionView?.register(ReusableHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "ReusableHeaderView")
        collectionView?.register(ReusableHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "ReusableHeaderView")
    }
}

extension CollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return headerColors.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellColors.count
    }
 
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.backgroundColor = cellColors[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ReusableHeaderView", for: indexPath)
        headerView.backgroundColor = headerColors[indexPath.section]
        return headerView
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 5) / 4
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 40)
    }
}

class ReusableHeaderView: UICollectionReusableView {
}

class CollectionViewCell: UICollectionViewCell {
}
