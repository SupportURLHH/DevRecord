//
//  BaseVCDataSource.swift
//  Integration
//
//  Created by 范庆宇 on 2021/6/22.
//

import Foundation
import UIKit

protocol VCDataSource {
    func vcIsNeedNavBar(vc:QYBaseViewController) -> Bool
    func vcPreferStatusBarStyle(vc:QYBaseViewController) -> UIStatusBarStyle
    
}
