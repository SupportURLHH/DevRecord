//
//  HISBaseTableCell.swift
//  HIStudent
//
//  Created by 苏虹 on 16/4/25.
//  Copyright © 2016年 smilingmobile. All rights reserved.
//

import UIKit

class BaseTableCell: UITableViewCell {

    var info: HISBaseTableCellInfo?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
//        self.contentView.backgroundColor = Color.customWhite
        
    }
    
    /// 默认 UI 函数
    open func configUI() {
        
    }
    
    /// model 赋值函数
    open func configurateTheCell(_ info:BaseCellModel){

    }
    
    // MARK: --基类不能出现语法错误
    func fillData(_ cellInfo: HISBaseTableCellInfo){
        info = cellInfo
    }
    
    override func select(_ sender: Any?) {
        if let tempModel = info?.model {
            info?.gotoNextBlock?(tempModel)
        }
    }
    
    
}
