//
//  HISBaseHeadLabelCell.swift
//  HIStudent
//
//  Created by K.E. on 17/6/22.
//  Copyright © 2017年 smilingmobile. All rights reserved.
//

import UIKit

class HISBaseHeadLabelCell: BaseTableCell {

    @IBOutlet var label: UILabel!{
        didSet{
            label.textColor = Color.b_21
            label.font = JCFontOfSize(14, .bold)
        }
    }
    
    @IBOutlet weak var leftV: UIView!{
        didSet{
            leftV.backgroundColor = Color.main
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        leftV.ef_cornerRadius(withRight: 2)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.separatorInset = UIEdgeInsets.init(top: -1000, left: -1000, bottom: 1000, right: 1000)
    }
    
    override func fillData(_ cellInfo: HISBaseTableCellInfo) {
        label.text = cellInfo.title
        if cellInfo.titleColor != nil {
            label.textColor = cellInfo.titleColor
        }
        
        if cellInfo.titleFont != nil {
            label.font = cellInfo.titleFont
        }
        
        
        if cellInfo.leftVColor != nil {
            leftV.backgroundColor = cellInfo.leftVColor
            
        }else {
            leftV.backgroundColor = Color.main
        }
        
        if cellInfo.line {
            self.separatorInset = UIEdgeInsets.init(top: self.separatorInset.top, left: self.separatorInset.left, bottom: self.separatorInset.bottom, right: self.separatorInset.right)

        }else {
            self.separatorInset = UIEdgeInsets.init(top: -1000, left: -1000, bottom: 1000, right: 1000)
        }
        
    }
    

    
}
