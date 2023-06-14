//
//  HorizontalScrollViewController.swift
//  HorizontalScrollView
//
//  Created by YURI KIM on 2023/06/08.
//

import UIKit
import SnapKit
import Then

class HorizontalScrollViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let width = 260
    let height = 440
    var index: Int = 0
    var high:CGFloat = 25
    let cardCnt = 10
    
    lazy var margin = (view.frame.width - CGFloat(width)) / 2
    
    lazy var contentOrigin = collectionView.cellForItem(at: IndexPath(row: 1, section: 0))?.frame.origin.y
    var once = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
       
        //        configureLayoutGM()
        collectionView.dataSource = self
        collectionView.delegate = self
        //        collectionView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 20, right: 15)
        
        collectionView.decelerationRate = .fast

        

        
    }
  
    
    func configureLayoutGM() {
        let collectionViewLayout = CardCollectionViewFlow()
        collectionView.collectionViewLayout = collectionViewLayout
    }
    
    func configureLayout() {
        let collectionViewLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: width, height: height)
            layout.minimumLineSpacing = 30
            layout.sectionInset = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
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

        if velocity.x > 0{
            if index != cardCnt-1 { //마지막 인덱스 벗어나지 못하게
                index = Int(ceil(estimateIndex))
            }
            focusAroundAnimation(index: self.index-1)
  
        }else if velocity.x < 0 {
            if index != 0 { //처음 인덱스 벗어나지 못하게
                index = Int(floor(estimateIndex))
            }
            focusAroundAnimation(index: self.index+1)
            
        }else {
            index = Int(round(estimateIndex))
            focusUpAnimation(index: self.index)//스크롤 이동 안 했을 때 y값 유지
        }
        
        targetContentOffset.pointee = CGPoint(x: CGFloat(index) * cellWidthIncludingSpaing, y:  0)//scroll.offset.x
        focusUpAnimation(index: self.index) // collectionview.cell.off.y
            
        
    }
    
    func focusUpAnimation(index: Int){
        UIView.animate(withDuration: 0.3, delay: 0, options: .allowAnimatedContent, animations: {
            self.collectionView.cellForItem(at: IndexPath(row: index, section: 0))?.frame.origin.y = self.contentOrigin!-self.high
        })
    }
    func focusAroundAnimation(index: Int){
        UIView.animate(withDuration: 0.3, delay: 0, options: .allowAnimatedContent, animations: {
            self.collectionView.cellForItem(at: IndexPath(row: index, section: 0))?.frame.origin.y = self.contentOrigin!
        })
    }

    
}


extension HorizontalScrollViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardCnt
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as UICollectionViewCell
        
        let cardView = CardView()
        cell.contentView.addSubview(cardView)
        cardView.snp.makeConstraints {
            //$0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(width)
            $0.height.equalTo(height)
        }
        if indexPath.row == 0 && once {
            cell.frame.origin.y = cell.frame.origin.y-high
            once.toggle()
        }
    
        let label = UILabel().then {
            $0.text = "\(indexPath.row)"
        }
        cell.contentView.addSubview(label)
        label.snp.makeConstraints {
            $0.leading.equalToSuperview()
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
