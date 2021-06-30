//
//  QYNavigationController.swift
//  Integration
//
//  Created by 范庆宇 on 2021/6/25.
//

import UIKit

class QYNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.children.count != 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
        
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        return super.popViewController(animated: animated)
        
    }

}

//extension QYNavigationController: UINavigationControllerDelegate {
//
//}
