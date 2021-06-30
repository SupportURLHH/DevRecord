//
//  BaseLabelCell.swift
//  HIStudent
//
//  Created by 苏虹 on 16/4/14.
//  Copyright © 2016年 smilingmobile. All rights reserved.
//

import UIKit

class HISBaseLabelCell: BaseTableCell {

    @IBOutlet var label: UILabel! {
        didSet{
            label.backgroundColor = Color.clear
        }
    }
    @IBOutlet weak var leading: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func fillData(_ cellInfo: HISBaseTableCellInfo) {
        label.text = cellInfo.title
        if cellInfo.titleColor != nil {
            label.textColor = cellInfo.titleColor
        }
        if cellInfo.titleFont != nil {
            label.font = cellInfo.titleFont
        }
        if cellInfo.titleLeading != nil {
            leading.constant = cellInfo.titleLeading ?? 10.0
        }
        if cellInfo.backGroundColor != nil {
            self.contentView.backgroundColor = cellInfo.backGroundColor
            self.backgroundColor = cellInfo.backGroundColor
            
        }
    }
    
}
