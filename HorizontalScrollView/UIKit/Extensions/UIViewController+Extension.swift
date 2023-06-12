//
//  UIViewController+Extension.swift
//  HorizontalScrollView
//
//  Created by YURI KIM on 2023/06/08.
//

import Foundation
import UIKit

extension UIViewController {
    func viewController(_ identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}
