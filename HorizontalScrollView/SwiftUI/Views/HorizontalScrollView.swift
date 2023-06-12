//
//  HorizontalScrollView.swift
//  HorizontalScrollView
//
//  Created by YURI KIM on 2023/06/08.
//

import SwiftUI

@available(iOS 13.0, *)
struct HorizontalScrollView: View {
    
    let cards = [0,1,2,3,4,5,6,7,8,9]
    
    @State private var scrollEffectValue: Double = 13
    @State private var activePageIndex: Int = 0
    
    let itemWidth: CGFloat = 260
    let itemPadding: CGFloat = 20
    
    var body: some View {
        ZStack {
                GeometryReader { geometry in
                    AdaptivePagingScrollView(currentPageIndex: self.$activePageIndex, itemsAmount: self.cards.count, itemWidth: self.itemWidth, itemPadding: itemPadding, pageWidth: geometry.size.width) {
                        ForEach(cards, id: \.self) { card in
                            GeometryReader { screen in
                                ImageCardView()
                                .scaleEffect(activePageIndex == cards.firstIndex(of: card) ?? 0 ? 1.05 : 1)
                            }
                            .frame(width: self.itemWidth)
                        }
                    }
                }
            
        }
    }
}
@available(iOS 13.0, *)
struct HorizontalScrollView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalScrollView()
    }
}

