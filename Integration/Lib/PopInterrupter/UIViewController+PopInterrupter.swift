//
//  UIViewController+PopInterrupter.swift
//  Integration
//
//  Created by 范庆宇 on 2021/2/30.
//

import Foundation
import UIKit

public protocol AnyPopInterrupter {
    var isPopEnabled: Bool { get }
    
}

extension UINavigationController : UINavigationBarDelegate {
    
    public func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        if viewControllers.count < navigationBar.items?.count ?? 0 {
            return true
        }
        var shouldPop = true
        if let vc = topViewController as? AnyPopInterrupter { // 是否遵循协议
            shouldPop = vc.isPopEnabled
        }
        
        if shouldPop {
            DispatchQueue.main.async {
                self.popViewController(animated: true)
            }
        }
        return shouldPop
    }

}

extension UINavigationController : UIGestureRecognizerDelegate {
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == interactivePopGestureRecognizer {
            if viewControllers.count <= 1 {
                return false
            }
            
            if let vc = topViewController as? AnyPopInterrupter { // 是否遵循协议
                return vc.isPopEnabled
            }
            
            let originDelegate = objc_getAssociatedObject(self, &UINavigationController.originDelegateKey) as? UIGestureRecognizerDelegate
            return originDelegate?.gestureRecognizerShouldBegin?(gestureRecognizer) ?? true
        }
        return true
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return gestureRecognizer == interactivePopGestureRecognizer
    }
}
