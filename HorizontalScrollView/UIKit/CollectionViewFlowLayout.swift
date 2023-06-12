//
//  CollectionViewFlowLayout.swift
//  HorizontalScrollView
//
//  Created by YURI KIM on 2023/06/12.
//

import Foundation
import UIKit

/**
 애니메이션 효과 적용
 */
final class MainCollectionViewFlowLayout: UICollectionViewFlowLayout {
    private var isSetup = false
    
    override func prepare() {
        super.prepare()

        if !isSetup {
            setupLayout()
            isSetup.toggle()
        }
    }
    
    private func setupLayout() {
        guard let collectionView = collectionView else {
            return
        }
        
        let collectionViewSize = collectionView.frame.size
        
        let itemWidth = collectionViewSize.width * 0.72
        let itemHeight = collectionViewSize.height * 0.95
        itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        let xInset = (collectionViewSize.width - itemWidth) / 2
        let bottomInset = collectionViewSize.height * 0.05
        sectionInset = UIEdgeInsets(top: 0, left: xInset, bottom: bottomInset, right: xInset)
        
        minimumLineSpacing = collectionViewSize.width * 0.083
        scrollDirection = .horizontal
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superAttributes = super.layoutAttributesForElements(in: rect), let attributes = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes] else {
            return nil
        }
        
        return attributes.map { collectionViewLayoutAttributes in
            transformLayoutAttributes(attributes: collectionViewLayoutAttributes)
        }
    }
    
    private func transformLayoutAttributes(attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        guard let collectionView = collectionView else {
            return attributes
        }
        
        let collectionViewCenterWidth = collectionView.frame.size.width / 2
        let contentOffset = collectionView.contentOffset.x
        let center = attributes.center.x - contentOffset
        
        let maxDistance = (itemSize.width + minimumLineSpacing) * 2
        let distance = min(abs(collectionViewCenterWidth - center), maxDistance)
        
        let ratio = (maxDistance - distance) / maxDistance
        let sideCellHeightGap: CGFloat = 60
        let heightRatio = sideCellHeightGap - ratio * sideCellHeightGap
        
        let transform = CGAffineTransform(translationX: 0, y: heightRatio)
        attributes.transform = transform
        
        return attributes
    }
}
