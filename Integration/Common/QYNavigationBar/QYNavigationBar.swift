//
//  QYNavigationBar.swift
//  Integration
//
//  Created by 范庆宇 on 2021/6/22.
//

import UIKit

@objc protocol QYNavigationBarDataSource:class {
    
    @objc optional func qyNavigationBarTitle(navigationBar:QYNavigationBar) -> NSMutableAttributedString
    
    @objc optional func qyNavigationBarBackgroundImage(navigationBar:QYNavigationBar) -> UIImage?
    
    @objc optional func qyNavigationBarBackgroundColor(navigationBar:QYNavigationBar) -> UIColor
    
    @objc optional func qyNavigationBarBottomLineColor(navigationBar:QYNavigationBar) -> UIColor
    
    @objc optional func qyNavigationBarBackView(navigationBar:QYNavigationBar) -> UIView
    
    @objc optional func qyNavigationIsHideBottomLine(navigationBar:QYNavigationBar) -> Bool
    
    @objc optional func qyNavigationHeight(navigationBar:QYNavigationBar) -> CGFloat
    
    @objc optional func qyNavigationBarLeftView(navigationBar:QYNavigationBar) -> UIView
    
    @objc optional func qyNavigationBarRightView(navigationBar:QYNavigationBar) -> UIView
    
    @objc optional func qyNavigationBarTitleView(navigationBar:QYNavigationBar) -> UIView
    
    @objc optional func qyNavigationBarLeftButtonImage(navigationBar:QYNavigationBar) -> UIImage?
    
    @objc optional func qyNavigationBarRightButtonImage(navigationBar:QYNavigationBar) -> UIImage
    
}

@objc protocol QYNavigationBarDelegate:class {
    
    // 左边的按钮的点击
    @objc optional func qyNavigationBarLeftButtonEvent(sender:UIButton, navigationBar:QYNavigationBar)
    
    // 右边的按钮的点击
    @objc optional func qyNavigationBarRightButtonEvent(sender:UIButton, navigationBar:QYNavigationBar)
    
    // 中间的点击
    @objc optional func qyNavigationBarTitleEvent(sender:UILabel, navigationBar:QYNavigationBar)
    
}

class QYNavigationBar: UIView {

    weak var dataSource:QYNavigationBarDataSource? {
        didSet{
            setupDataSourceUI()
            
        }
    }
    
    weak var delegate:QYNavigationBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.backgroundColor = Color.white
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.superview?.bringSubviewToFront(self)
        if let holderLeftV = leftView {
            holderLeftV.frame = CGRect.init(x: 5, y: kStatusHeight, width: holderLeftV.qy_width, height: holderLeftV.qy_height)
            
        }
        
        if let holderRightV = rightView {
            holderRightV.frame = CGRect.init(x: self.qy_width - holderRightV.qy_width, y: kStatusHeight, width: holderRightV.qy_width, height: holderRightV.qy_height)
            
        }
        
        if let holderTitleV = titleView {
            holderTitleV.frame = CGRect.init(x: 0.2*kScreenWidth, y: kStatusHeight + (44.0 - holderTitleV.qy_height)*0.5, width: 0.6*kScreenWidth, height: holderTitleV.qy_height)
            
        }
        
        if let holderSelfV = selfView {
            holderSelfV.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: qy_height)
            
        }
        
        bottomLineView.frame = CGRect.init(x: 0, y: qy_height, width: kScreenWidth, height: bottomLineView.qy_height)
        
    }


    
    // MARK:UI
    func setupDataSourceUI() {
        
        // 高度
        if let navHeight = dataSource?.qyNavigationHeight?(navigationBar: self) {
            qy_height = navHeight
            
        }
        
        // 是否显示黑色线
        if let isHiddenBottomLine = dataSource?.qyNavigationIsHideBottomLine?(navigationBar: self) {
            bottomLineView.isHidden = isHiddenBottomLine
            
        }
        
        // 背景图片
        if let holderBackgroundImage = dataSource?.qyNavigationBarBackgroundImage?(navigationBar: self) {
            backgroundImage = holderBackgroundImage
            
        }
        
        // 背景色
        if let holderBackgroundColor = dataSource?.qyNavigationBarBackgroundColor?(navigationBar: self) {
            backgroundColor = holderBackgroundColor
            
        }
        
        // 导航栏中间视图
        if let backV = dataSource?.qyNavigationBarBackView?(navigationBar: self) {
            selfView = backV
        
        }
        
        // 导航栏中间视图
        if let titleV = dataSource?.qyNavigationBarTitleView?(navigationBar: self) {
            titleView = titleV
            
        }else if let holderTitle = dataSource?.qyNavigationBarTitle?(navigationBar: self) {
            title = holderTitle
            
        }
        
        // 底部线条
        if let bottomLineColor = dataSource?.qyNavigationBarBottomLineColor?(navigationBar: self) {
            bottomLineView.backgroundColor = bottomLineColor
            
        }
        
        // 左边视图
        if let leftV = dataSource?.qyNavigationBarLeftView?(navigationBar: self) {
            leftView = leftV
            
        }else {
            let btn = UIButton.init(type: .custom)
            btn.frame = CGRect.init(x: 0, y: 0, width: 28, height: 44)
            btn.titleLabel?.font = QYFontOfSize(16, .regular)
            if let leftButtonImage = dataSource?.qyNavigationBarLeftButtonImage?(navigationBar: self) {
                btn.setImage(leftButtonImage, for: .normal)
                
            }
            leftView = btn
            
        }
        
        // 右边视图
        if let rightV = dataSource?.qyNavigationBarRightView?(navigationBar: self) {
            rightView = rightV
            
        }else{
            let btn = UIButton.init(type: .custom)
            btn.frame = CGRect.init(x: 0, y: 0, width: 28, height: 44)
            btn.titleLabel?.font = QYFontOfSize(16, .regular)
            if let rightButtonImage = dataSource?.qyNavigationBarRightButtonImage?(navigationBar: self) {
                btn.setImage(rightButtonImage, for: .normal)
                
            }
            rightView = btn
            
        }
        
    }
    
    // MARK:Event
    
    @objc func leftBtnClick(btn: UIButton) {
        delegate?.qyNavigationBarLeftButtonEvent?(sender: btn, navigationBar: self)
        
    }

    @objc func rightBtnClick(btn: UIButton) {
        delegate?.qyNavigationBarRightButtonEvent?(sender: btn, navigationBar: self)
        
    }
    
    @objc func titleClick(tap: UITapGestureRecognizer) {
        if let label = tap.view as? UILabel {
            delegate?.qyNavigationBarTitleEvent?(sender: label, navigationBar: self)
        }
        
    }

    var titleView:UIView? {
        willSet {
            titleView?.removeFromSuperview()
            if newValue != nil {
                
            }
        }
        didSet {
            if titleView != nil {
                self.addSubview(titleView!)
                
                var isHaveTapGes:Bool = false
                
                for gesture in titleView!.gestureRecognizers ?? [] {
                    if gesture.isKind(of: UITapGestureRecognizer.self) {
                        isHaveTapGes = true
                        break
                    }
                    
                }
                if !isHaveTapGes {
                    let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(titleClick(tap:)))
                    titleView!.addGestureRecognizer(tapGes)
                    
                }
            }
            layoutIfNeeded()
            
        }
    }
    
    var title:NSMutableAttributedString? {
        didSet {
            // bug fix
            if let titleLabel = titleView as? UILabel {
                titleLabel.attributedText = title
                
            }else {
                let navTitleLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: qy_width*0.65, height: 44))
                navTitleLabel.numberOfLines = 1
                navTitleLabel.lineBreakMode = .byTruncatingTail
                navTitleLabel.attributedText = title
                navTitleLabel.textAlignment = .center
                navTitleLabel.backgroundColor = .clear
                navTitleLabel.isUserInteractionEnabled = true
                self.titleView = navTitleLabel
                
            }
        }
    }
    
    var leftView:UIView? {
        willSet {
            leftView?.removeFromSuperview()
        }
        didSet {
            if leftView != nil {
                self.addSubview(leftView!)
                if let btn = leftView as? UIButton {
                    btn.addTarget(self, action: #selector(leftBtnClick(btn:)), for: .touchUpInside)
                }
            }
            
            layoutIfNeeded()
            
        }
    }
    
    var rightView:UIView? {
        willSet {
            rightView?.removeFromSuperview()
        }
        didSet {
            if rightView != nil {
                self.addSubview(rightView!)
                if let btn = rightView as? UIButton {
                    btn.addTarget(self, action: #selector(rightBtnClick(btn:)), for: .touchUpInside)
                }
            }
            layoutIfNeeded()
            
        }
    }
    
    var selfView:UIView? {
        willSet{
            selfView?.removeFromSuperview()
        }
        didSet{
            if selfView != nil {
                self.addSubview(selfView!)
            }
            layoutIfNeeded()
        }
        
    }
    
    weak var backgroundImage:UIImage? {
        didSet {
            self.layer.contents = backgroundImage?.cgImage
            
        }
    }
    
    /** 底部的黑线 */
    lazy var bottomLineView:UIView = {
        let height:CGFloat =  CGFloat.kOnePixelLine
        let v = UIView.init(frame: CGRect.init(x: 0, y: self.qy_height, width: self.qy_width, height: height))
        addSubview(v)
        return v
        
    }()
    
}
