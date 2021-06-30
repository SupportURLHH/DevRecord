//
//  FirstVC.swift
//  Integration
//
//  Created by 范庆宇 on 2021/6/25.
//

import UIKit
import PopInterrupter

class FirstVC: QYBaseViewController,AnyPopInterrupter {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Color.white
        
    }
    
    var isPopEnabled: Bool {
        if !jobHasDone {
            let alertController = UIAlertController(title: "您还有内容未完成", message: "是否离开此页面?", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "是", style: .destructive, handler: { action in
                self.navigationController?.popViewController(animated: true)
                
            }))
            alertController.addAction(UIAlertAction(title: "否", style: .cancel, handler: nil))
            present(alertController, animated: true, completion: nil)
            
        }
        return jobHasDone
    }
    
    var jobHasDone = false
    
    // 重写 QYBaseViewController实现QYNavigationBar 的 dataSource
    override func vcPreferStatusBarStyle(vc: QYBaseViewController) -> UIStatusBarStyle {
        return .lightContent
        
    }
    
    override func qyNavigationBarBackgroundColor(navigationBar: QYNavigationBar) -> UIColor {
        return Color.black
        
    }
    
    override func qyNavigationBarLeftButtonImage(navigationBar: QYNavigationBar) -> UIImage? {
        return UIImage(named: "navgationBar_leftButton_white")
        
    }
    
    override func qyNavigationBarTitle(navigationBar: QYNavigationBar) -> NSMutableAttributedString {
        return changeTitle(curTitle: "自定义标题", titleColor: Color.white)
        
    }
    
    override func qyNavigationBarBottomLineColor(navigationBar: QYNavigationBar) -> UIColor {
        return Color.white // 白色线条
        
    }
    
}
