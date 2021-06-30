//
//  QYBaseVC.swift
//  JC
//
//  Created by 范庆宇 on 2020/8/19.
//  Copyright © 2020 com.cangbei.inc. All rights reserved.
//

import UIKit
import TTTAttributedLabel
import BFKit

class QYBaseVC: LMJBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
        loadData()
        
    }
    
    // MARK: - UI
    func loadUI() {
//        self.view.backgroundColor = Color.view
        
    }
    
    // MARK: - Data methods
    func loadData() {
        
    }
    
    override func lmjNavigationIsHideBottomLine(_ navigationBar: LMJNavigationBar!) -> Bool {
        return true
    }
    
    override func lmjNavigationBackgroundColor(_ navigationBar: LMJNavigationBar!) -> UIColor! {
        return Color.generatColor(lightColor: Color.white, darkColor: Color.init(hex: "#1A191F"))
        
    }
    
    override func lmjNavigationLineColor(_ navigationBar: LMJNavigationBar!) -> UIColor! {
        return Color.lineWhite
    }
    
    override func navUIBaseViewControllerPreferStatusBarStyle(_ navUIBaseViewController: LMJNavUIBaseViewController!) -> UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent /// 适配iOS 13，默认变为了 DarkContent
        }
        return .default
        
    }
    
    
}
