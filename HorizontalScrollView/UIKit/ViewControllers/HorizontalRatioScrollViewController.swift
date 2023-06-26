//
//  HorizontalRatioScrollViewController.swift
//  HorizontalScrollView
//
//  Created by YURI KIM on 2023/06/23.
//

import Foundation
import UIKit
import SnapKit
import Then

class HorizontalRatioScrollViewController: UIViewController {
    
    @IBOutlet weak var ratioCollectionView: UICollectionView!
    
    private let cardCnt = 10
    private var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        configureLayoutGM()
        
        ratioCollectionView.dataSource = self
        ratioCollectionView.delegate = self
        
    }
    
    
    func configureLayoutGM() {
        let collectionViewLayout = CardCollectionViewFlow()
        ratioCollectionView.collectionViewLayout = collectionViewLayout
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        guard let layout = self.ratioCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else {return}
        //collectionview item size
        let cellWidthIncludingSpaing = layout.itemSize.width + layout.minimumLineSpacing
        
        //이동한 x좌표 값과 item의 크기를 비교 후 페이징 값 설정
        let estimateIndex = scrollView.contentOffset.x / cellWidthIncludingSpaing
        //        print("velocity", velocity.x)
        if velocity.x > 0{
            if index != cardCnt-1 { //마지막 인덱스 벗어나지 못하게
                index = Int(ceil(estimateIndex))
                                
            }else if velocity.x < 0 {
                if index != 0 { //처음 인덱스 벗어나지 못하게
                    index = Int(floor(estimateIndex))
                }
                
            }else {
                index = Int(round(estimateIndex))
            }
            
            targetContentOffset.pointee = CGPoint(x: CGFloat(index) * cellWidthIncludingSpaing, y:  0)//scroll.offset.x
        }
    }
    
}


extension HorizontalRatioScrollViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardCnt
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as UICollectionViewCell
        
        guard let layout = self.ratioCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return cell }
        
        let cardView = CardView()
        cell.contentView.addSubview(cardView)
        cardView.snp.makeConstraints {
            $0.width.height.equalToSuperview()
//            $0.centerX.centerY.equalToSuperview()
//            $0.width.equalTo(layout.itemSize.width)
//            $0.height.equalTo(layout.itemSize.height)
        }

        
        let label = UILabel().then {
            $0.text = "\(indexPath.row)"
        }
        cell.contentView.addSubview(label)
        label.snp.makeConstraints {
            $0.leading.equalToSuperview()
        }
        
        
        return cell
    }
    
    
}

extension HorizontalRatioScrollViewController: UICollectionViewDelegateFlowLayout {

}
