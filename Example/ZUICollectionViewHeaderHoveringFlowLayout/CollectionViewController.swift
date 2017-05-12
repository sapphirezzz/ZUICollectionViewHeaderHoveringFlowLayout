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

    let headerColors = [UIColor.brownColor(), UIColor.greenColor(), UIColor.purpleColor(), UIColor.magentaColor(), UIColor.lightGrayColor(), UIColor.blackColor(), UIColor.brownColor(), UIColor.greenColor(), UIColor.purpleColor(), UIColor.magentaColor(), UIColor.lightGrayColor(), UIColor.blackColor()]
    let cellColors = [UIColor.blueColor(), UIColor.orangeColor(), UIColor.redColor(), UIColor.yellowColor()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (collectionView?.collectionViewLayout as? ZUICollectionViewHeaderHoveringFlowLayout)?.sectionToHover = 2
        
        collectionView?.registerClass(ReusableHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "ReusableHeaderView")
        collectionView?.registerClass(ReusableHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "ReusableHeaderView")
    }
}

extension CollectionViewController {
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return headerColors.count
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellColors.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
        cell.backgroundColor = cellColors[indexPath.row]
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "ReusableHeaderView", forIndexPath: indexPath)
        headerView.backgroundColor = headerColors[indexPath.section]
        return headerView
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = floor((collectionView.bounds.width - 5) / 4)
        return CGSize(width: width, height: width)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 40)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 40)
    }
}

class ReusableHeaderView: UICollectionReusableView {
}

class CollectionViewCell: UICollectionViewCell {
}
