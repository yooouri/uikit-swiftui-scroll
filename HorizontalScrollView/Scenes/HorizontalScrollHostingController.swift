//
//  HorizontalScrollHostingController.swift
//  HorizontalScrollView
//
//  Created by YURI KIM on 2023/06/08.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
class HorizontalScrollHostingController: UIHostingController<HorizontalScrollView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: HorizontalScrollView())
    }
}
