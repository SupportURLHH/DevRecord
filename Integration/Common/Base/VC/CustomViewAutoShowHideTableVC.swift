//
//  CustomViewAutoShowHideTableVC.swift
//  YangShu
//
//  Created by 范庆宇 on 2021/3/24.
//

import UIKit

class CustomViewAutoShowHideTableVC: HISBaseTableViewController,HISSrollDelegate {

    var scrollProxy: MediumScrollFullScreen?
    
    func moveCustomView(deltaY: CGFloat) {
       
    }
    
    func setCustomOriginY(y: CGFloat) {
        
    }
    
    func hideCustomView() {
        
    }
    
    func showCustomView() {
        setCustomOriginY(y: StatusBarHeight)
        
    }
    
    var statement: State = .Hiding
    
    enum State {
        case Normal
        case Showing
        case Hiding
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableDelegate.delegate = self
        scrollProxy = MediumScrollFullScreen()
        scrollProxy?.delegate = self as MediumScrollFullScreenDelegate
        // Do any additional setup after loading the view.
    }
    
    func scroll(scrollView: UIScrollView) {
        self.scrollProxy?.scrollViewDidScroll(scrollView)
        
    }
    
    func scrollDidEndDragging(scrollView: UIScrollView, decelerate: Bool) {
        self.scrollProxy?.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
        
    }
    
}

extension CustomViewAutoShowHideTableVC: MediumScrollFullScreenDelegate {
    
    func scrollFullScreen(fullScreenProxy: MediumScrollFullScreen, scrollViewDidScrollUp deltaY: CGFloat, userInteractionEnabled enabled: Bool) {
        moveCustomView(deltaY: deltaY)
        
    }
    
    func scrollFullScreen(fullScreenProxy: MediumScrollFullScreen, scrollViewDidScrollDown deltaY: CGFloat, userInteractionEnabled enabled: Bool) {
//        if deltaY >  || statement == .Normal{ //TODO: 手势向下滑动速度较快，显示顶部试图，其他不显示。当滑动到默认显示位置时候，需要再自动显示
//            statement = .Showing
//        }
        showCustomView()
        
    }
    
    func scrollFullScreenScrollViewDidEndDraggingScrollUp(fullScreenProxy: MediumScrollFullScreen, userInteractionEnabled enabled: Bool) {
        if enabled {
            hideCustomView()
        }
        
    }
    
    func scrollFullScreenScrollViewDidEndDraggingScrollDown(fullScreenProxy: MediumScrollFullScreen, userInteractionEnabled enabled: Bool) {
        if enabled {
            showCustomView()
        }
        
    }
}
