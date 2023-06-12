//
//  CardView.swift
//  HorizontalScrollView
//
//  Created by YURI KIM on 2023/06/09.
//

import Foundation
import UIKit
import Then
import SnapKit

class CardView: UIView {
//    private let backgroundImageView = UIImageView().then {
//        $0.image = UIImage(named: "")
//    }
    
    private let frontLabel = UILabel().then {
        $0.text = "카드입니다."
        $0.textAlignment = .center
        //        $0.font = UIFont(name: "NotoSansKR-Medium", size: 34)
        $0.textColor = .black
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 260, height: 440))
        
        backgroundColor = .red
        configureCardView()
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func cardShadowSetting() {
        self.layer.shadowColor = UIColor(named: "#ECECEC")?.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize(width: 0, height: 6)
        self.layer.cornerRadius = 10
    }
    
    func configureCardView() {
        addSubviews(frontLabel)
        setCardLayout()
    }
    
    func setCardLayout() {
//        backgroundImageView.snp.makeConstraints {
//            $0.top.bottom.leading.trailing.equalToSuperview()
//        }
        
        frontLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
//            $0.bottom.equalToSuperview().multipliedBy(0.55)
        }

    }
    
    
    
    
}
