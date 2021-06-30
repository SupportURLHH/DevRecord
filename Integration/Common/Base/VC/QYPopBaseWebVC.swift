//
//  QYPopBaseWebVC.swift
//  JC
//
//  Created by 范庆宇 on 2020/11/19.
//  Copyright © 2020 com.cangbei.inc. All rights reserved.
//

import UIKit

class QYPopBaseWebVC: LMJWebViewController {

    convenience init(alertContainerType: AlertContainerType){
        self.init()
        contentSizeInPopup = CGSize(width: SCREEN_WHIDTH, height: 450+VirtualHeight)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wkWebView.frame = CGRect.init(x: 0, y: 44, width: self.view.width, height: self.view.height-44)
        // Do any additional setup after loading the view.
        let backBtn = UIButton.init(type: .custom)
        backBtn.frame = CGRect.init(x: 10, y: 0, width: 27, height: 44)
        backBtn.setImage(UIImage(named: "nav_btn_back"), for: .normal)
        backBtn.addTarget(self, action: #selector(backToHomeView), for: .touchUpInside)
        self.view.addSubview(backBtn)
        
        let titleL = UILabel.init(frame: CGRect.init(x: 50, y: 0, width: SCREEN_WHIDTH-100, height: 44))
        titleL.text = self.title
        titleL.textAlignment = .center
        titleL.font = JCFontOfSize(15, .regular)
        titleL.textColor = Color.b_21
        self.view.addSubview(titleL)
        
    }
    
    var backClickBlock:(()->())?
    
    //MARK: 返回
    @objc func backToHomeView(){
        backClickBlock?()
        
    }
    
    override func lmjNavigationIsHideBottomLine(_ navigationBar: LMJNavigationBar!) -> Bool {
        return true
    }
    
    override func lmjNavigationHeight(_ navigationBar: LMJNavigationBar!) -> CGFloat {
        return 44
    }
    
    override func lmjNavigationBarLeftButtonImage(_ leftButton: UIButton!, navigationBar: LMJNavigationBar!) -> UIImage! {
        return UIImage(named: "nav_btn_back")
        
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
