//
//  CardView.swift
//  HorizontalScrollView
//
//  Created by YURI KIM on 2023/06/12.
//

import Foundation
import SwiftUI

struct ImageCardView: View {
    var body: some View {
        ZStack{
            Text("카드입니다")
        }
        .frame(width: 260, height: 440)
        .background(Color.blue)
        .cornerRadius(8)
    }
}

