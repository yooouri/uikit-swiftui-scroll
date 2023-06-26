//
//  CardCollectionViewFlow.swift
//  HorizontalScrollView
//
//  Created by YURI KIM on 2023/06/14.
//

import Foundation
import UIKit

final class CardCollectionViewFlow: UICollectionViewFlowLayout {
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
        print("collectionView.frame.size",collectionView.frame.size)
        let collectionViewSize = collectionView.frame.size
        
        let itemWidth = collectionViewSize.width * 0.72
        let itemHeight = collectionViewSize.height * 0.8
        itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        let xInset = (collectionViewSize.width - itemWidth) / 2
        let yInset = (collectionViewSize.height - itemHeight) / 2
        sectionInset = UIEdgeInsets(top: yInset, left: xInset, bottom: yInset, right: xInset)
        
        minimumLineSpacing = itemWidth * 0.11
        scrollDirection = .horizontal
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
         true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        print("========")
        guard let superAttributes = super.layoutAttributesForElements(in: rect), let attributes = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes] else {
            return nil
        }
//        print("superAttributes",superAttributes)
        return attributes.map { collectionViewLayoutAttributes in
            transformLayoutAttributes(attributes: collectionViewLayoutAttributes)
        }
    }
    
    private func transformLayoutAttributes(attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        print("|||||")
        guard let collectionView = collectionView else {
            return attributes
        }
//        print("attributes", attributes)
//        print("attributes.center.x", attributes.center.x)
        let collectionViewCenterWidth = collectionView.frame.size.width / 2
        let contentOffset = collectionView.contentOffset.x
        let center = attributes.center.x - contentOffset
        
        print("contentOffset", contentOffset)
        print("collectionView.frame.size.width", collectionView.frame.size.width)
        
        let maxDistance = (itemSize.width + minimumLineSpacing) * 2
        let distance = min(abs(collectionViewCenterWidth - center), maxDistance)
        
        let ratio = (maxDistance - distance) / maxDistance
        let sideCellHeightGap: CGFloat = 60
        let heightRatio = sideCellHeightGap - ratio * sideCellHeightGap
        
        print("maxDistance", maxDistance , distance)
        print("ratio",ratio , heightRatio)
        
        let transform = CGAffineTransform(translationX: 0, y: heightRatio)
        attributes.transform = transform
        
        return attributes
    }
}

