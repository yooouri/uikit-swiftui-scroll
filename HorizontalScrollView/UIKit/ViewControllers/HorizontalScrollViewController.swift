//
//  HorizontalScrollViewController.swift
//  HorizontalScrollView
//
//  Created by YURI KIM on 2023/06/08.
//

import UIKit
import SnapKit

class HorizontalScrollViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 20, right: 15)
    }
    
    func configureLayout() {
//        let layout = MainCollectionViewFlowLayout()
        collectionView.collectionViewLayout = MainCollectionViewFlowLayout()
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
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
//        cell.layer.borderColor = UIColor.gray.cgColor
//        cell.layer.borderWidth = 1

        return cell
    }
    
    
}

//extension HorizontalScrollViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 100
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let itemSpace:CGFloat = 10
//        let width = view.frame.width * 0.5 //(collectionView.frame.width - itemSpace * 2 - 30) / 3
//        let height = view.frame.height * 0.7
//        
//        return CGSize(width: 100, height: 100)
//    }
//}
