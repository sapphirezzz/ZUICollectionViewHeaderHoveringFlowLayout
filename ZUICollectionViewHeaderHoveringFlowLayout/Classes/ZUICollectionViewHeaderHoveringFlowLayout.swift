//
//  ZUICollectionViewHeaderHoveringFlowLayout.swift
//  Promise_Test
//
//  Created by Zack･Zheng on 2017/3/31.
//  Copyright © 2017年 Zack･Zheng. All rights reserved.
//

import UIKit

public class ZUICollectionViewHeaderHoveringFlowLayout: UICollectionViewFlowLayout {
    
    @IBInspectable public var sectionToHover: Int = 0
    
    public override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let superAttributes = super.layoutAttributesForElementsInRect(rect) ?? []
        guard let collectionView = collectionView else {return superAttributes}
        
        let attributes = insertNoneHeaderSections(sectionToHover, superAttributes: superAttributes)
        
        let finalAttributes: [UICollectionViewLayoutAttributes] = attributes.map { attribute in
            
            if attribute.representedElementKind == UICollectionElementKindSectionHeader && sectionToHover == attribute.indexPath.section {
                
                let numberOfItemsInSection = collectionView.numberOfItemsInSection(attribute.indexPath.section)

                var firstItemAttribute: UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes()
                
                if numberOfItemsInSection > 0 {
                    
                    let firstItemIndexPath = NSIndexPath(forItem: 0, inSection: attribute.indexPath.section)
                    firstItemAttribute = layoutAttributesForItemAtIndexPath(firstItemIndexPath)!
                }else {
                    
                    let y = attribute.frame.maxY + self.sectionInset.top
                    firstItemAttribute.frame = CGRect(x: 0, y: y, width: 0, height: 0)
                }
                
                var rect = attribute.frame
                let offset = collectionView.contentOffset.y
                
                let sectionInsetTop: CGFloat = {
                    
                    if let inset = (collectionView.delegate as? UICollectionViewDelegateFlowLayout)?.collectionView?(collectionView, layout: self, insetForSectionAtIndex: attribute.indexPath.section) {
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
        let indexPath = NSIndexPath(forItem: 0, inSection: noneHeaderSection)
        if let attribute = layoutAttributesForSupplementaryViewOfKind(UICollectionElementKindSectionHeader, atIndexPath: indexPath) {
            attributes.append(attribute)
        }
        return attributes
    }
    
    public override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
}
