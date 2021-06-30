//
//  QYConst.swift
//  Integration
//
//  Created by 范庆宇 on 2021/6/22.
//

import Foundation
import UIKit

//MRAK: 应用默认颜色
extension UIColor {
    class var background: UIColor {
        return UIColor(r: 242, g: 242, b: 242)
    }
    
    class var theme: UIColor {
        return UIColor(r: 29, g: 221, b: 43)
    }
    
}

extension String {
    static let searchHistoryKey = "searchHistoryKey"
    static let sexTypeKey = "sexTypeKey"
}

extension NSNotification.Name {
    static let USexTypeDidChange = NSNotification.Name("USexTypeDidChange")
}


let appDelegate = UIApplication.shared.delegate as! AppDelegate
let kScreenWidth = UIScreen.screenWidth
let kScreenHeight = UIScreen.screenHeight
let kStatusHeight = UIApplication.shared.statusBarFrame.size.height
let kNavigationBarHeight:CGFloat = 44.0
var kTopBarHeight: CGFloat {
    return CGFloat(kNavigationBarHeight) + kStatusHeight
}

var isIphoneX: Bool {
    if #available(iOS 13.0, *) {
        return UIDevice().userInterfaceIdiom == .phone
            && (max(UIScreen.main.bounds.height, UIScreen.main.bounds.width) == 812
                || max(UIScreen.main.bounds.height, UIScreen.main.bounds.width) == 896)
    }else{
        return UI_USER_INTERFACE_IDIOM() == .phone
            && (max(UIScreen.main.bounds.height, UIScreen.main.bounds.width) == 812
                || max(UIScreen.main.bounds.height, UIScreen.main.bounds.width) == 896)
    }
}

var isIphoneXMax: Bool {
    if #available(iOS 13.0, *) {
        return UIDevice().userInterfaceIdiom == .phone
            && max(UIScreen.main.bounds.height, UIScreen.main.bounds.width) == 896
    }else{
        return UI_USER_INTERFACE_IDIOM() == .phone
            && max(UIScreen.main.bounds.height, UIScreen.main.bounds.width) == 896
    }
}

let VirtualButtonHeight = isIphoneX ? 34 : 0
let kTabbarHeight = VirtualButtonHeight + 49



//MARK: print
func QYLog(_ message: String = "", file: String = #file, function: String = #function, lineNumber: Int = #line) {
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print("[\(fileName):funciton:\(function):line:\(lineNumber)]- \(message)")
    #endif
}



let nsObject: AnyObject? = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as AnyObject?//First get the nsObject by defining as an optional anyObject
let kAppVersion = nsObject as? String
let kAppID = kAppVersion?.replacingOccurrences(of: ".", with: "")// 1.0.0 ==> 100，1.0.1 ==>101
let kAppType = "iOS"
let kAppPlatform = UIDevice.detailedModel
let kSystemVersion = UIDevice.osVersion
let kSys_UDID  = UIDevice.current.identifierForVendor//设备唯一标识udid

var topVC: UIViewController? {
    var resultVC: UIViewController?
    resultVC = _topVC(UIApplication.shared.keyWindow?.rootViewController)
    while resultVC?.presentedViewController != nil {
        resultVC = _topVC(resultVC?.presentedViewController)
    }
    return resultVC
}

private  func _topVC(_ vc: UIViewController?) -> UIViewController? {
    if vc is UINavigationController {
        return _topVC((vc as? UINavigationController)?.topViewController)
    } else if vc is UITabBarController {
        return _topVC((vc as? UITabBarController)?.selectedViewController)
    } else {
        return vc
    }
}


