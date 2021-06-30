//
//  QYBaseWebVC.swift
//  JC
//
//  Created by 范庆宇 on 2020/9/1.
//  Copyright © 2020 com.cangbei.inc. All rights reserved.
//

import UIKit

class QYBaseWebVC: LMJWebViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func lmjNavigationIsHideBottomLine(_ navigationBar: LMJNavigationBar!) -> Bool {
        return true
    }
    
    override func lmjNavigationBackgroundColor(_ navigationBar: LMJNavigationBar!) -> UIColor! {
        return Color.generatColor(lightColor: Color.white, darkColor: Color.init(hex: "#1A191F"))
    }
    
    override func navUIBaseViewControllerPreferStatusBarStyle(_ navUIBaseViewController: LMJNavUIBaseViewController!) -> UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent /// 适配iOS 13，默认变为了 DarkContent
        }
        return .default
        
    }

}
