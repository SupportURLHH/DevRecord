//
//  QYTableVC.swift
//  JC
//
//  Created by 范庆宇 on 2020/8/19.
//  Copyright © 2020 com.cangbei.inc. All rights reserved.
//

import UIKit

class QYTableVC: LMJTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
            
        }
        
        // push 内页 底部增加 VirtualHeight 间距
        self.tableView.contentInset = UIEdgeInsets.init(top: self.tableView.contentInset.top, left: self.tableView.contentInset.left, bottom: self.tableView.contentInset.bottom + VirtualHeight, right: self.tableView.contentInset.right)
        
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
