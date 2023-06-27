//230627 14:00까지 작업내용

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
    
    private var index: Int = 0
    private let cardCnt = 10
    
    private lazy var width = collectionView.frame.size.width * 0.7 //260
    private lazy var height = collectionView.frame.size.height * 0.7 //440

    private var high:CGFloat = 30
    
    private lazy var space:CGFloat = width * 0.11
    
    
    
    lazy var xInset = (collectionView.frame.width - CGFloat(width)) / 2
    lazy var yInset = (collectionView.frame.height - CGFloat(height)) / 2
    
    private var contentOrigin: Double? //collectionView.cellForItem(at: IndexPath(row: 1, section: 0))?.frame.origin.y
    
    private var once = true
    
    private var lastOffSet: CGFloat = 0
    private var direction:ScrollDirection = .right
    enum ScrollDirection {
        case left
        case right
    }
    private var std:CGFloat = 0.5

    private var endScroll = true
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        configureLayout()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.decelerationRate = .fast
        
        
    }
    
    
    
    func configureLayout() {
        let collectionViewLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: width, height: height)
            layout.minimumLineSpacing = space
            layout.sectionInset = UIEdgeInsets(top: yInset, left: xInset, bottom: yInset, right: xInset)
            layout.scrollDirection = .horizontal
            
            return layout
        }()
        collectionView.collectionViewLayout = collectionViewLayout
        print("collectionview frame", collectionView.frame.size.width)
        
    }

    //비율 안 맞음,,,사용 안 함
    func ratioCalculation(i: Int) -> CGFloat {
        let collectionViewCenterWidth = collectionView.frame.size.width / 2
        let contentOffset = collectionView.contentOffset.x
        let center = collectionView.layoutAttributesForItem(at: IndexPath(row: i, section: 0))!.center.x - contentOffset
        
        let maxDistance = CGFloat(width) + space
        let distance = min(abs(collectionViewCenterWidth - center), maxDistance)
        
        let ratio = (maxDistance - distance) / maxDistance
        let heightRatio = high - ratio * high
        
        return heightRatio
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {

        endScroll.toggle() //false

    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        
        if !endScroll {

            if lastOffSet > scrollView.contentOffset.x {

                direction = .left
   
                if index != 0{
                        collectionView.cellForItem(at: IndexPath(row: index, section: 0))?.frame.origin.y = collectionView.cellForItem(at: IndexPath(row: index, section: 0))!.frame.origin.y+std

                }

                    collectionView.cellForItem(at: IndexPath(row: index-1, section: 0))?.frame.origin.y = collectionView.cellForItem(at: IndexPath(row: index-1, section: 0))!.frame.origin.y-std


            }else{

                direction = .right

                    collectionView.cellForItem(at: IndexPath(row: index+1, section: 0))?.frame.origin.y = collectionView.cellForItem(at: IndexPath(row: index+1, section: 0))!.frame.origin.y-std
              
                    collectionView.cellForItem(at: IndexPath(row: index, section: 0))?.frame.origin.y = collectionView.cellForItem(at: IndexPath(row: index, section: 0))!.frame.origin.y+std

            }
            lastOffSet = scrollView.contentOffset.x
        }

    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        endScroll.toggle() //true
        guard let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {return}
        let cellWidthIncludingSpaing = layout.itemSize.width + layout.minimumLineSpacing
        //이동한 x좌표 값과 item의 크기를 비교 후 페이징 값 설정
        let estimateIndex = scrollView.contentOffset.x / cellWidthIncludingSpaing
                print("velocity", velocity.x)
        if velocity.x > 0{
            if index != cardCnt-1 { //마지막 인덱스 벗어나지 못하게
                index = Int(ceil(estimateIndex))
            }

        }else if velocity.x < 0 {
            if index != 0 { //처음 인덱스 벗어나지 못하게
                index = Int(floor(estimateIndex))
            }

        }else {
            index = Int(round(estimateIndex))
        }

        targetContentOffset.pointee = CGPoint(x: CGFloat(index) * cellWidthIncludingSpaing, y:  0)//scroll.offset.x
        
        if direction == .right{
            focusAroundAnimation(index: index-1)
            focusUpAnimation(index: index)
        }else{
            focusAroundAnimation(index: index+1)
            focusUpAnimation(index: index)
        }

    }
    
    
    func focusUpAnimation(index: Int){
        UIView.animate(withDuration: 0.3, delay: 0, options: .allowAnimatedContent, animations: { [self] in
            collectionView.cellForItem(at: IndexPath(row: index, section: 0))?.frame.origin.y = contentOrigin!-high
        })
    }
    
    func focusAroundAnimation(index: Int){
        UIView.animate(withDuration: 0.3, delay: 0,  animations: { [self] in
            collectionView.cellForItem(at: IndexPath(row: index, section: 0))?.frame.origin.y = contentOrigin!
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
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(width)
            $0.height.equalTo(height)
        }

        if indexPath.row == 0 && once {
            contentOrigin = cell.frame.origin.y
            cell.frame.origin.y = cell.frame.origin.y-high
            once.toggle()
            print("cell contentOrigin", contentOrigin)
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

extension HorizontalScrollViewController: UICollectionViewDelegateFlowLayout {

}
