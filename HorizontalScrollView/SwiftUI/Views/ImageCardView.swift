//
//  CardView.swift
//  HorizontalScrollView
//
//  Created by YURI KIM on 2023/06/12.
//

import Foundation
import SwiftUI

struct ImageCardView: View {
    let cardIndex: Int
    var body: some View {
        VStack(alignment: .leading){
            Text("\(cardIndex)")
                .frame(alignment: .top)
            Text("카드입니다")
        }
        .frame(width: 260, height: 440)
        .background(Color.blue)
        .cornerRadius(8)
        
    }
}



struct ImageCardView_Previews: PreviewProvider {
    static var previews: some View {
        ImageCardView(cardIndex: 1)
    }
}
