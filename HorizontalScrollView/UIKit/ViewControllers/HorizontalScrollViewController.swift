//
//  HorizontalScrollViewController.swift
//  HorizontalScrollView
//
//  Created by YURI KIM on 2023/06/08.
//

import UIKit
import SnapKit

class HorizontalScrollViewController: UIViewController {
    
    let width = 260
    let height = 440
    lazy var spacing = (view.frame.width - CGFloat(width)) / 2
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
        //        collectionView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 20, right: 15)
        
        collectionView.decelerationRate = .fast
        
    }

    
    func configureLayout2() {
        let collectionViewLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: width, height: height)
            layout.minimumLineSpacing = 30
            layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
            layout.scrollDirection = .horizontal
            return layout
        }()
        collectionView.collectionViewLayout = collectionViewLayout
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {return}
        //collectionview item size
        let cellWidthIncludingSpaing = layout.itemSize.width + layout.minimumLineSpacing
        
        //이동한 x좌표 값과 item의 크기를 비교 후 페이징 값 설정
        let estimateIndex = scrollView.contentOffset.x / cellWidthIncludingSpaing
        let index: Int
        
                print("estimateIndex",estimateIndex)
                print("velocity.x",velocity.x)
        if velocity.x > 0{
            index = Int(ceil(estimateIndex))
        }else if velocity.x < 0 {
            index = Int(floor(estimateIndex))
        }else {
            index = Int(round(estimateIndex))
        }
                
        targetContentOffset.pointee = CGPoint(x: CGFloat(index) * cellWidthIncludingSpaing, y: 0)
    }
    
    
}


extension HorizontalScrollViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as UICollectionViewCell
        
        let cardView = CardView()
        cell.contentView.addSubview(cardView)
        cardView.snp.makeConstraints {
            //            $0.top.leading.bottom.trailing.equalToSuperview()
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(width)
            $0.height.equalTo(height)
        }
        
        //        cell.layer.borderColor = UIColor.gray.cgColor
        //        cell.layer.borderWidth = 1
        
        return cell
    }
    
    
}

extension HorizontalScrollViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 30
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 30
//    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let itemSpace:CGFloat = 30
//        let width = view.frame.width * 0.5 //(collectionView.frame.width - itemSpace * 2 - 30) / 3
//        let height = view.frame.height * 0.7
//
//        return CGSize(width: 260, height: 440)
//    }
}
