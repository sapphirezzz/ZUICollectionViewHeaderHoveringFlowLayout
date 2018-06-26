//
//  ZUICollectionViewHeaderHoveringFlowLayout.swift
//  Promise_Test
//
//  Created by Zack･Zheng on 2017/3/31.
//  Copyright © 2017年 Zack･Zheng. All rights reserved.
//

import UIKit

public class ZUICollectionViewHeaderHoveringFlowLayout: UICollectionViewFlowLayout {
    
    @IBInspectable public var sectionToHover: Int = -1
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let superAttributes = super.layoutAttributesForElements(in: rect) ?? []
        guard let collectionView = collectionView else {return superAttributes}
        
        let attributes = insertNoneHeaderSections(noneHeaderSection: sectionToHover, superAttributes: superAttributes)
        
        let finalAttributes: [UICollectionViewLayoutAttributes] = attributes.map { attribute in
            
            if attribute.representedElementKind == UICollectionElementKindSectionHeader && sectionToHover == attribute.indexPath.section {
                
                let numberOfItemsInSection = collectionView.numberOfItems(inSection: attribute.indexPath.section)
                
                var firstItemAttribute: UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes()
                
                if numberOfItemsInSection > 0 {
                    
                    let firstItemIndexPath = IndexPath(item: 0, section: attribute.indexPath.section)
                    firstItemAttribute = layoutAttributesForItem(at: firstItemIndexPath)!
                }else {
                    
                    let y = attribute.frame.maxY + self.sectionInset.top
                    firstItemAttribute.frame = CGRect(x: 0, y: y, width: 0, height: 0)
                }
                
                var rect = attribute.frame
                let offset = collectionView.contentOffset.y
                
                let sectionInsetTop: CGFloat = {
                    
                    if let inset = (collectionView.delegate as? UICollectionViewDelegateFlowLayout)?.collectionView?(collectionView, layout: self, insetForSectionAt: attribute.indexPath.section) {
                        return inset.top
                    }else {
                        return self.sectionInset.top
                    }
                }()
                
                let headerY = firstItemAttribute.frame.origin.y - rect.size.height - sectionInsetTop
                let maxY = max(offset + collectionView.contentInset.top, headerY)
                rect.origin.y = maxY
                attribute.frame = rect
                attribute.zIndex = .max
                
                return attribute
                
            }else {
                return attribute
            }
        }
        
        return finalAttributes
    }
    
    private func insertNoneHeaderSections(noneHeaderSection: Int, superAttributes: [UICollectionViewLayoutAttributes]) -> [UICollectionViewLayoutAttributes] {
        
        var attributes = superAttributes
        
        // 因为在iOS 9.3，当layoutAttributesForSupplementaryView方法传入的参数indexPath不存在时，会崩溃而不是返回nil，所以这里加了判断
        guard let sectionCount = collectionView?.numberOfSections, noneHeaderSection >= 0, noneHeaderSection < sectionCount else { return attributes }

        let indexPath = IndexPath(item: 0, section: noneHeaderSection)
        if let attribute = layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionHeader, at: indexPath) {
            attributes.append(attribute)
        }
        return attributes
    }
    
    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
