//
//  ViewController.swift
//  Integration
//
//  Created by 范庆宇 on 2021/6/22.
//

import UIKit

class ViewController: QYBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "首页"
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc = FirstVC()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override func qyNavigationBarBottomLineColor(navigationBar: QYNavigationBar) -> UIColor {
        return Color.red
        
    }
    
}

