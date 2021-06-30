//
//  UINavigationController+Swizzle.swift
//  Integration
//
//  Created by 范庆宇 on 2021/2/30.
//

import Foundation
import UIKit

public func load() {
    _ = __init__
}

private let __init__: Bool = {
    UINavigationController.exchange(#selector(UINavigationController.viewDidLoad), withSEL: #selector(UINavigationController.qy_viewDidLoad))
    return true
    
}()

extension UINavigationController {
    
    @objc func qy_viewDidLoad() {
        qy_viewDidLoad()
        objc_setAssociatedObject(self, &UINavigationController.originDelegateKey, interactivePopGestureRecognizer?.delegate, .OBJC_ASSOCIATION_ASSIGN)
        interactivePopGestureRecognizer?.delegate = self
        
    }
    
    static var originDelegateKey: Void?
}

fileprivate extension NSObject {
    
    @discardableResult
    class func exchange(_ oldSEL: Selector, withSEL newSEL: Selector) -> Bool {
        
        guard let originMethod = class_getInstanceMethod(self, oldSEL),
              let altMethod = class_getInstanceMethod(self, newSEL) else {
            return false
        }
        
        let didAddMethod = class_addMethod(self, oldSEL, method_getImplementation(altMethod), method_getTypeEncoding(altMethod))
        if didAddMethod {
            class_replaceMethod(self, newSEL, method_getImplementation(originMethod), method_getTypeEncoding(originMethod))
        } else {
            method_exchangeImplementations(originMethod, altMethod)
        }
        return true
    }
}
