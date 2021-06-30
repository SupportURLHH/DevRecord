//
//  QYBaseViewController.swift
//  Integration
//
//  Created by 范庆宇 on 2021/6/22.
//

import UIKit

public class QYBaseViewController: UIViewController,QYNavigationBarDelegate,QYNavigationBarDataSource,VCDataSource {
    
    public override var title: String? {
        didSet {
            qyNavigationBar.title = changeTitle(curTitle: title ?? "")
            
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.qyNavigationBar.qy_width = self.view.qy_width
        self.view.bringSubviewToFront(qyNavigationBar)
        
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIApplication.shared.setStatusBarStyle(vcPreferStatusBarStyle(vc: self), animated: animated)
        
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.setStatusBarStyle(vcPreferStatusBarStyle(vc: self), animated: animated)
        
    }
    
    // MARK: NavigationBarDataSource
    func qyNavigationBarLeftButtonImage(navigationBar: QYNavigationBar) -> UIImage? {
        if self.navigationController?.children.count == 1 {
            return nil
            
        }else{
            return UIImage(named: "navgationBar_leftButton")!
            
        }
        
    }
    
    func qyNavigationBarBottomLineColor(navigationBar: QYNavigationBar) -> UIColor {
        return Color.line
        
    }
    
    func qyNavigationBarTitle(navigationBar:QYNavigationBar) -> NSMutableAttributedString {
        return changeTitle(curTitle: title ?? "")
        
    }
    
    func qyNavigationIsHideBottomLine(navigationBar: QYNavigationBar) -> Bool {
        return false
        
    }
    
    func qyNavigationHeight(navigationBar: QYNavigationBar) -> CGFloat {
        return kTopBarHeight
        
    }
    
    func qyNavigationBarBackgroundColor(navigationBar: QYNavigationBar) -> UIColor {
        return Color.white
        
    }
    

    // MARK:NavigationBarDelegate
    func qyNavigationBarTitleEvent(sender: UILabel, navigationBar: QYNavigationBar) {
        QYLog()
        
    }
    
    func qyNavigationBarLeftButtonEvent(sender: UIButton, navigationBar: QYNavigationBar) {
        self.navigationController?.popViewController(animated: true)
        QYLog()
        
    }
    
    func qyNavigationBarRightButtonEvent(sender: UIButton, navigationBar: QYNavigationBar) {
        QYLog()
        
    }
    
    // MARK:VCDataSource
    func vcIsNeedNavBar(vc: QYBaseViewController) -> Bool {
        return true
        
    }
    
    func vcPreferStatusBarStyle(vc: QYBaseViewController) -> UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
            
        }else {
            return .default
            
        }
    }

    // MARK: Private Method
    func setTitle(title:String, titleColor:UIColor) {
        qyNavigationBar.title = changeTitle(curTitle: title, titleColor: titleColor)
        
    }
         
    private func changeTitle(curTitle:String) -> NSMutableAttributedString {
        changeTitle(curTitle: curTitle, titleColor: Color.b_33)
        
    }
    
    func changeTitle(curTitle:String, titleColor:UIColor) -> NSMutableAttributedString {
        let title = NSMutableAttributedString.init(string: curTitle)
        let range = NSRange.init(location: 0, length: curTitle.count)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        title.addAttributes([.font:QYFontOfSize(18, .medium), .foregroundColor:titleColor, .paragraphStyle:paragraphStyle], range: range)
        return title
        
    }
    
    lazy var qyNavigationBar:QYNavigationBar = {
        let navBar = QYNavigationBar()
        if vcIsNeedNavBar(vc: self) {
            navBar.delegate = self
            navBar.dataSource = self
            view.addSubview(navBar)
        }
        return navBar
        
    }()
    

}
