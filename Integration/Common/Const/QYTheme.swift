//
//  Theme.swift
//  CB_ios
//
//  Created by 范庆宇 on 2019/12/31.
//  Copyright © 2019 com.miaoxinren.inc. All rights reserved.
//

import Foundation
import UIKit
import Toast_Swift
import MJRefresh
import SCLAlertView
import LCActionSheet

typealias ToastCompletionNext = (Bool) -> (Void)

func QYSheet(title: String = "", cancelButtonTitle:String = "取消", otherButtonTitleArray:[String] = [], handler: ((Int) -> ())? = nil) {
    let sheet = LCActionSheet.init(title: title, cancelButtonTitle: cancelButtonTitle, clicked: { (sheet, index) in
        handler?(index)
        
    }, otherButtonTitleArray: otherButtonTitleArray)
    sheet.darkViewNoTaped = false
    sheet.darkOpacity = 0.65
    sheet.unBlur = true
    sheet.animationDuration = 0.2
    sheet.buttonHeight = 51
    sheet.buttonFont = QYFontOfSize(14, .regular)
    sheet.buttonColor = Color.b_33
    sheet.separatorColor = Color.line
    sheet.cancelButtonColor = Color.b_99
    sheet.show()
    
}

func QYInfoAlert(title: String = "", message: String = "",handler: (() -> ())? = nil){
    
    var backGround = Color.view
    if #available(iOS 13.0, *) {
        backGround = Color.init { (trainCollection) -> UIColor in
            if trainCollection.userInterfaceStyle == .dark {
                return Color.white
            }else {
                return Color.view
            }
        }
    }
    
    let appearance = SCLAlertView.SCLAppearance(kDefaultShadowOpacity: 0.5, kTitleTop: 22, kWindowWidth: 270*kScreenWidth/375.0, kButtonHeight: 50, kTitleFont: UIFont.systemFont(ofSize: 17,weight: .medium), kTextFont: UIFont.systemFont(ofSize: 14), kButtonFont: UIFont.systemFont(ofSize: 14), showCloseButton: false, showCircularIcon: false, shouldAutoDismiss: true, contentViewCornerRadius: 10, fieldCornerRadius: 4, buttonCornerRadius: 0, hideWhenBackgroundViewIsTapped: true, contentViewColor: backGround, contentViewBorderColor: .clear, titleColor: Color.b_33, dynamicAnimatorActive: false, buttonsLayout: .horizontal, activityIndicatorStyle: .whiteLarge)
    
    let alert = SCLAlertView(appearance: appearance)
    

    let cancelBtn = alert.addButton("知道了", backgroundColor: backGround, textColor: Color.theme, action: {
        print("First button tapped")
        handler?()
        
    })
    cancelBtn.layer.cornerRadius = 0.0
    cancelBtn.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
    cancelBtn.layer.borderWidth = 0.5
    cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    
    _ = alert.showSuccess(title, subTitle: message)
    
}

func JCAlert(title: String = "", message: String = "",cancelTitle: String = "取消",okTitle: String = "确定",cancelHandle:(() -> ())? = nil, okHandler: (() -> ())? = nil){
    
    var backGround = Color.view
    if #available(iOS 13.0, *) {
        backGround = Color.init { (trainCollection) -> UIColor in
            if trainCollection.userInterfaceStyle == .dark {
                return Color.white
            }else {
                return Color.view
            }
        }
    }
    
    let appearance = SCLAlertView.SCLAppearance(kDefaultShadowOpacity: 0.5, kTitleTop: 22, kWindowWidth: 270*kScreenWidth/375.0, kButtonHeight: 50, kTitleFont: UIFont.systemFont(ofSize: 17,weight: .medium), kTextFont: UIFont.systemFont(ofSize: 14), kButtonFont: UIFont.systemFont(ofSize: 14), showCloseButton: false, showCircularIcon: false, shouldAutoDismiss: true, contentViewCornerRadius: 10, fieldCornerRadius: 4, buttonCornerRadius: 4, hideWhenBackgroundViewIsTapped: true, contentViewColor: backGround, contentViewBorderColor: .clear, titleColor: Color.b_33, dynamicAnimatorActive: false, buttonsLayout: .horizontal, activityIndicatorStyle: .whiteLarge)
    
    let alert = SCLAlertView(appearance: appearance)
    
    let btnBackGround = Color.generatColor(lightColor: Color.view, darkColor: Color.hex(hexString: "#28262C"))
    
    let btnBorderColor = Color.generatColor(lightColor: Color.hex(hexString: "#D4D4D4"), darkColor: Color.hex(hexString: "#9497A0")) //Color.hex(hexString: "#D4D4D4")
        
    let cancelBtn = alert.addButton("取消", backgroundColor: btnBackGround, textColor: Color.b_66, action: {
        cancelHandle?()

    })
    cancelBtn.layer.borderColor = btnBorderColor.cgColor
    cancelBtn.layer.borderWidth = 0.5
    cancelBtn.layer.cornerRadius = 4
    cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)

    
    let okBtn = alert.addButton("确定", backgroundColor: Color.theme, textColor: Color.white, action: {
        okHandler?()

    })
    okBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    okBtn.layer.cornerRadius = 4
    
    _ = alert.showSuccess(title, subTitle: message)
    
}

/// 强提醒
/// - Parameters:
///   - title: 标题
///   - message: 内容
///   - cancelTitle: 取消按钮
///   - okTitle: 确定按钮
///   - handler: 确定按钮时间
func CBAlert(title: String = "", message: String = "", cancelTitle: String = "", okTitle: String = "确定",handler: ((UIAlertAction) -> Void)? = nil){
    
    let alert = UIAlertController(style: .alert)
    if !title.isEmpty {
        alert.set(title: title, font: Font.title, color: Color.title)
    }
    if !message.isEmpty {
        alert.set(message: message, font: Font.content, color: Color.content)
    }
    if !cancelTitle.isEmpty {
        alert.addAction(image: nil, title: cancelTitle, color: Color.subTitle, style: .default)
    }
    if !okTitle.isEmpty {
        alert.addAction(image: nil, title: okTitle, color: Color.theme, style: .default, isEnabled: true) { (action) in
            handler?(action)
        }
    }
    alert.show()

}

/// 弱提醒
/// - Parameters:
///   - msg: 内容
///   - completion: 动画完成回调
func Toast(_ msg:String?, completion: ToastCompletionNext? = nil){
    DispatchQueue.main.async {
        topVC?.view.makeToast(msg, duration: 1.2, position: .center, title: nil, image: nil, style: ToastManager.shared.style, completion: { (finished) in
            completion?(finished)
            
        })
    }
}

/// 成功提示，兼容之前的一些写好的，后面弱提示用 Toast
/// - Parameter title: 内容
func HUD(_ title:String?){
    appDelegate.window?.rootViewController?.view.makeToast(title, duration: 1.2, position: .center, title: nil, image: nil, style: ToastManager.shared.style, completion: nil)
    
}


//extension UIScrollView {
//    var header: RefreshHeader? {
//        get {
//            return mj_header as? RefreshHeader
//        }
//        set {
//            mj_header = newValue
//
//        }
//    }
//
//    var footer: RefreshFooter? {
//        get {
//            return mj_footer as? RefreshFooter
//        }
//        set {
//            mj_footer = newValue
//        }
//    }
//}


//class RefreshHeader: DIYHeader {}

//class RefreshHeader: MJRefreshNormalHeader {}

//class RefreshFooter: MJRefreshAutoNormalFooter {}


private  func _topVC(_ vc: UIViewController?) -> UIViewController? {
    if vc is UINavigationController {
        return _topVC((vc as? UINavigationController)?.topViewController)
    } else if vc is UITabBarController {
        return _topVC((vc as? UITabBarController)?.selectedViewController)
    } else {
        return vc
    }
}

open class Font: UIFont {
    public static let title = UIFont.systemFont(ofSize: 18, weight: .bold)
    public static let content = UIFont.systemFont(ofSize: 14, weight: .medium)
    public static let subTitle = UIFont.systemFont(ofSize: 16, weight: .bold)
    public static let guideText = UIFont.systemFont(ofSize: 11, weight: .medium)
    public static let font12 = UIFont.systemFont(ofSize: 12, weight: .regular)
    public static let font13 = UIFont.systemFont(ofSize: 13, weight: .regular)

}

open class Color: UIColor {
    
    static func generatColor(lightColor:UIColor, darkColor:UIColor)->UIColor {
        if #available(iOS 13.0, *) {
            return Color.init { (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    return darkColor
                    
                }else {
                    return lightColor
                }
            }
        }
        return lightColor
        
    }
    
   
    class var b_21:UIColor {
        if #available(iOS 13.0, *) {
            return Color.init { (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    return Color.dark.b_21
                    
                }else {
                    return Color.light.b_21
                }
            }
        }
        return Color.light.b_21
    }

    
    class var b_88:UIColor{
        if #available(iOS 13.0, *) {
            return Color.init { (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    return Color.dark.b_88
                    
                }else {
                    return Color.light.b_88
                }
            }
        }
        return Color.light.b_88
    }
    
    class var b_33:UIColor {
        if #available(iOS 13.0, *) {
            return Color.init { (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    return Color.dark.b_33
                    
                }else {
                    return Color.light.b_33
                }
            }
        }
        return Color.light.b_33
    }
    
    class var b_66:UIColor {
        if #available(iOS 13.0, *) {
            return Color.init { (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    return Color.dark.b_66
                    
                }else {
                    return Color.light.b_66
                }
            }
        }
        return Color.light.b_66
    }
    
    class var b_CC:UIColor {
        if #available(iOS 13.0, *) {
            return Color.init { (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    return Color.dark.b_CC
                    
                }else {
                    return Color.light.b_CC
                }
            }
        }
        return Color.light.b_CC
    }
    
    class var b_00:UIColor {
        if #available(iOS 13.0, *) {
            return Color.init { (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    return Color.dark.b_00
                    
                }else {
                    return Color.light.b_00
                }
            }
        }
        return Color.light.b_00
    }
    
    class var b_99:UIColor {
        if #available(iOS 13.0, *) {
            return Color.init { (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    return Color.dark.b_99
                    
                }else {
                    return Color.light.b_99
                }
            }
        }
        return Color.light.b_99
    }
    
    class var b_9C:UIColor {
        if #available(iOS 13.0, *) {
            return Color.init { (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    return Color.dark.b_9C
                    
                }else {
                    return Color.light.b_9C
                }
            }
        }
        return Color.light.b_9C
    }
    
    class var line: UIColor {
        if #available(iOS 13.0, *) {
            return Color.init { (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    return Color.dark.line
                    
                }else {
                    return Color.light.line
                }
            }
        }
        return Color.light.line
    }
    
    class var title: UIColor {
        if #available(iOS 13.0, *) {
            return Color.init { (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    return Color.dark.title
                    
                }else {
                    return Color.light.title
                }
            }
        }
        return Color.light.title
    }
    
    class var content: UIColor {
        if #available(iOS 13.0, *) {
            return Color.init { (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    return Color.dark.content
                    
                }else {
                    return Color.light.content
                }
            }
        }
        return Color.light.content
    }
    
    class var subTitle: UIColor {
        if #available(iOS 13.0, *) {
            return Color.init { (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    return Color.dark.subTitle
                    
                }else {
                    return Color.light.subTitle
                }
            }
        }
        return Color.light.subTitle
    }
    
    class var guideText: UIColor {
        if #available(iOS 13.0, *) {
            return Color.init { (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    return Color.dark.guideText
                    
                }else {
                    return Color.light.guideText
                }
            }
        }
        return Color.light.guideText
    }
    
    class var view: UIColor {
        if #available(iOS 13.0, *) {
            return Color.init { (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    return Color.dark.view
                    
                }else {
                    return Color.light.view
                }
            }
        }
        return Color.light.view
    }
    
    class var tab_s: UIColor {
        if #available(iOS 13.0, *) {
            return Color.init { (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    return Color.dark.tab_s
                    
                }else {
                    return Color.light.tab_s
                }
            }
        }
        return Color.light.tab_s
    }
    
    class var tab_n: UIColor {
        if #available(iOS 13.0, *) {
            return Color.init { (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    return Color.dark.tab_n
                    
                }else {
                    return Color.light.tab_n
                }
            }
        }
        return Color.light.tab_n
    }
    
    
    class var b_6A: UIColor {
        if #available(iOS 13.0, *) {
            return Color.init { (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    return Color.dark.b_6A
                    
                }else {
                    return Color.light.b_6A
                }
            }
        }
        return Color.light.b_6A
    }
    
    // light text
    private class light {
        public static let main = UIColor.hex(hexString: "#00AFAA")
        
        public static let title = UIColor.hex(hexString: "#212121")
        public static let content = UIColor.hex(hexString: "#333333")
        public static let subTitle = UIColor.hex(hexString: "#666666")
        public static let guideText = UIColor.hex(hexString: "#999999")
        
        public static let line = UIColor.hex(hexString: "#F4F4F4")
        public static let lineEE = UIColor.hex(hexString: "#EEEEEE")
        public static let view = UIColor.hex(hexString: "#F5F5F5")
        
        public static let white = UIColor.hex(hexString: "#FFFFFF")
        
        public static let tab_s = UIColor.hex(hexString: "#00AFAA")
        public static let tab_n = UIColor.hex(hexString: "#888888")
        
        public static let b_00 = UIColor.hex(hexString: "#000000")
        public static let b_21 = UIColor.hex(hexString: "#212121")
        public static let b_33 = UIColor.hex(hexString: "#333333")
        public static let b_66 = UIColor.hex(hexString: "#666666")
        public static let b_6A = UIColor.hex(hexString: "#AAAAAA")
        public static let b_88 = UIColor.hex(hexString: "#888888")
        public static let b_99 = UIColor.hex(hexString: "#999999")
        public static let b_9C = UIColor.hex(hexString: "#9C9C9C")
        public static let b_CC = UIColor.hex(hexString: "#CCCCCC")
        
    }
    
    // dark text
    private class dark {
        
        public static let main = UIColor.hex(hexString: "#00AFAA")
        
        
        public static let title = UIColor.hex(hexString: "#212121")
        public static let content = UIColor.hex(hexString: "#333333")
        public static let subTitle = UIColor.hex(hexString: "#666666")
        public static let guideText = UIColor.hex(hexString: "#999999")
        
        public static let line = UIColor.hex(hexString: "#EEEEEE")
        public static let lineEE = UIColor.hex(hexString: "#0D0D0F")
        
        public static let view = UIColor.hex(hexString: "#0D0D0F")
        
        public static let white = UIColor.hex(hexString: "#1A191F")
        
        public static let tab_s = UIColor.hex(hexString: "#9497A0")
        public static let tab_n = UIColor.hex(hexString: "#444854")
        
        public static let b_00 = UIColor.hex(hexString: "#C4C7CC")
        
        public static let b_21 = UIColor.hex(hexString: "#C4C7CC")
        
        public static let b_33 = UIColor.hex(hexString: "#C4C7CC")
        
        public static let b_66 = UIColor.hex(hexString: "#9497A0")
        
        public static let b_6A = UIColor.hex(hexString: "#9497A0")
        
        public static let b_CC = UIColor.hex(hexString: "#9497A0")
        
        public static let b_88 = UIColor.hex(hexString: "#9497A0")
        
        public static let A3 = UIColor.hex(hexString: "#9497A0")
        
        public static let b_99 = UIColor.hex(hexString: "#9497A0")
        
        public static let b_9C = UIColor.hex(hexString: "#9497A0")
        
    }
    
}

/// 字体
/// - Parameters:
///   - size: 大小
///   - weight: 粗细
func QYFontOfSize(_ size:CGFloat,_ weight:UIFont.Weight) -> UIFont{
    
//    if weight == .regular {
//        return UIFont.init(name: "PingFangSC-Regular", size: size)!
//
//    }else if weight == .medium{
//        return UIFont.init(name: "PingFangSC-Medium", size: size)!
//
//    }else {
//         return UIFont.systemFont(ofSize: size, weight: weight)
//    }
    
    return UIFont.systemFont(ofSize: size, weight: weight)
    
}
