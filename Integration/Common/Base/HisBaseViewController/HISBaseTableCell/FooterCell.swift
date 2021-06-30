//
//  FooterCell.swift
//  JC
//
//  Created by 范庆宇 on 2020/8/25.
//  Copyright © 2020 com.cangbei.inc. All rights reserved.
//

import UIKit

class FooterCell: BaseTableCell {

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//
//
//    }
//
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.backgroundColor = Color.view
        self.separatorInset = UIEdgeInsets.init(top: -1000, left: -1000, bottom: 1000, right: 1000)
    }
    
    override func fillData(_ cellInfo: HISBaseTableCellInfo) {
        
        if (cellInfo.backGroundColor != nil) {
            self.contentView.backgroundColor = cellInfo.backGroundColor
        }
        
        if cellInfo.line {
            self.separatorInset = UIEdgeInsets.init(top: self.separatorInset.top, left: self.separatorInset.left, bottom: self.separatorInset.bottom, right: self.separatorInset.right)

        }else {
            self.separatorInset = UIEdgeInsets.init(top: -1000, left: -1000, bottom: 1000, right: 1000)
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
