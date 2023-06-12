//
//  MainViewController.swift
//  HorizontalScrollView
//
//  Created by YURI KIM on 2023/06/08.
//

import UIKit


class MainViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        basicSetting()
    }
    
    func basicSetting() {
        if #available(iOS 14.5, *) {
            button.setTitle("iOS 14.5 이상", for: .normal)
        }
        else {
            button.setTitle("iOS 14.5 미만", for: .normal)
        }
    }
    @IBAction func actNext(_ sender: Any) {
        if #available(iOS 14.5, *) {
            // [iOS 14.5 버전 이상 인 경우 분기 처리 내용]
            guard let nextVC = viewController("HorizontalScrollHostingController") as? HorizontalScrollHostingController else {return}
            navigationController?.pushViewController(nextVC, animated: false)
        }
        else {
            // [iOS 14.5 버전 미만 인 경우 분기 처리 내용]
            guard let nextVC = viewController("HorizontalScrollViewController") as? HorizontalScrollViewController else {return}
            navigationController?.pushViewController(nextVC, animated: false)
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
