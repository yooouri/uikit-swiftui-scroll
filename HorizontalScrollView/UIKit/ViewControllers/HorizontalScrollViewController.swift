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
    
    private let width = 260
    private let height = 440
    private var index: Int = 0
    private var high:CGFloat = 30
    private let cardCnt = 10
    private let space:CGFloat = 30
    
    lazy var margin = (view.frame.width - CGFloat(width)) / 2
    
    private var contentOrigin: Double? //collectionView.cellForItem(at: IndexPath(row: 1, section: 0))?.frame.origin.y
    private var once = true
    
    private var lastOffSet: CGFloat = 0
    private var direction:ScrollDirection = .right
    enum ScrollDirection {
        case left
        case right
    }
    private var temp: CGFloat = 81.5
    private var std:CGFloat = 0.5
    private var upY: CGFloat = 0
    private var downY: CGFloat = 0
    
    private var endScroll = true
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        configureLayout()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.decelerationRate = .fast
//        getStand()
        
        
    }
    
    
    
    func configureLayout() {
        let collectionViewLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: width, height: height)
            layout.minimumLineSpacing = space
            layout.sectionInset = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
            layout.scrollDirection = .horizontal
            
            return layout
        }()
        collectionView.collectionViewLayout = collectionViewLayout
        print("collectionview frame", collectionView.frame.size.width)
        
    }
    
    func getStand() {
        let scrollViewContentWidth = ((width + Int(space)) * cardCnt - Int(space) + Int(view.frame.width) - width)/10
        print("scrollViewWidth",scrollViewContentWidth)
        print("std", high/CGFloat(scrollViewContentWidth))
//        std = high/CGFloat(scrollViewContentWidth)
        std = high / (CGFloat(width)+CGFloat(space))
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //        focusUpAnimation(index: self.index)
        //        focusAroundAnimation(index: self.index-1)
        //        focusAroundAnimation(index: self.index+1)
        endScroll.toggle() //false
        //        upY = temp
        //        downY = temp-high
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrollView.contentOffset.x",scrollView.contentOffset.x)
       
       
        if !endScroll {
            //            if  upY >= temp-high {
            //                upY -= std
            //            }
            //            if temp-high <= downY && downY < temp {
            //                downY += std
            //            }

            std=30/290
//            print("aaaaaa",index)
            if lastOffSet > scrollView.contentOffset.x {
//                if lastOffSet-scrollView.contentOffset.x > 0 {
//                    let ratio = abs(lastOffSet-scrollView.contentOffset.x)*high/(CGFloat(width)+CGFloat(space))
//                    print("ratio", ratio)
//                    std = ratio
//                }
                direction = .left
                //                UIView.animate(withDuration: 0.1, delay: 0, options: .allowAnimatedContent, animations: { [self] in
                //                    print("lele upY",upY)
                //                    print("lele downY",downY)
                //                    self.collectionView.cellForItem(at: IndexPath(row: index, section: 0))?.frame.origin.y = upY
                //                    self.collectionView.cellForItem(at: IndexPath(row: index-1, section: 0))?.frame.origin.y = downY

//                if index != 0{
                    print("left index y down")
                        collectionView.cellForItem(at: IndexPath(row: index, section: 0))?.frame.origin.y = collectionView.cellForItem(at: IndexPath(row: index, section: 0))!.frame.origin.y+std
//

//                }
//                if CGFloat(collectionView.cellForItem(at: IndexPath(row: index, section: 0))!.frame.origin.y) < temp {
                    print("left index-1 y up")
                    collectionView.cellForItem(at: IndexPath(row: index-1, section: 0))?.frame.origin.y = collectionView.cellForItem(at: IndexPath(row: index-1, section: 0))!.frame.origin.y-std
//                }



                //                })

            }else{
//                if scrollView.contentOffset.x-lastOffSet > 0 {
//                    let ratio = abs(scrollView.contentOffset.x-lastOffSet)*high/(CGFloat(width)+CGFloat(space))
//                    print("ratio", ratio)
//                    std = ratio
//                }
                
                direction = .right
                //                UIView.animate(withDuration: 0.1, delay: 0, options: .allowAnimatedContent, animations: { [self] in

//                if CGFloat(collectionView.cellForItem(at: IndexPath(row: index, section: 0))!.frame.origin.y) < temp  {

                print("right index+1 y up")
                    collectionView.cellForItem(at: IndexPath(row: index+1, section: 0))?.frame.origin.y = collectionView.cellForItem(at: IndexPath(row: index+1, section: 0))!.frame.origin.y-std
//                }
//                if temp-high < CGFloat(collectionView.cellForItem(at: IndexPath(row: index+1, section: 0))!.frame.origin.y) {
                print("right index y down",collectionView.cellForItem(at: IndexPath(row: index, section: 0))!.frame.origin.y)
                    collectionView.cellForItem(at: IndexPath(row: index, section: 0))?.frame.origin.y = collectionView.cellForItem(at: IndexPath(row: index, section: 0))!.frame.origin.y+std
//                }

                //                })
            }
            lastOffSet = scrollView.contentOffset.x
        }

    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print("end!!!", scrollView.contentOffset.x)
        endScroll.toggle() //true
        guard let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {return}
        //        //collectionview item size
        let cellWidthIncludingSpaing = layout.itemSize.width + layout.minimumLineSpacing
        //
        //        //이동한 x좌표 값과 item의 크기를 비교 후 페이징 값 설정
        let estimateIndex = scrollView.contentOffset.x / cellWidthIncludingSpaing
        //        print("velocity", velocity.x)
        if velocity.x > 0{
            if index != cardCnt-1 { //마지막 인덱스 벗어나지 못하게
                index = Int(ceil(estimateIndex))
            }
            //            focusAroundAnimation(index: self.index-1)

        }else if velocity.x < 0 {
            if index != 0 { //처음 인덱스 벗어나지 못하게
                index = Int(floor(estimateIndex))
            }
            //            focusAroundAnimation(index: self.index+1)

        }else {
            index = Int(round(estimateIndex))
            //            focusUpAnimation(index: self.index)//스크롤 이동 안 했을 때 y값 유지
        }

        targetContentOffset.pointee = CGPoint(x: CGFloat(index) * cellWidthIncludingSpaing, y:  0)//scroll.offset.x
//        if direction == .right{
//            focusAroundAnimation(index: index-1)
//            focusUpAnimation(index: index)
//        }else{
//            focusAroundAnimation(index: index+1)
//            focusUpAnimation(index: index)
//        }

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
            //$0.centerX.centerY.equalToSuperview()
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
