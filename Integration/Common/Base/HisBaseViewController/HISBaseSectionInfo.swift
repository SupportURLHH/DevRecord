//
//  HISBaseSectionInfo.swift
//  HIStudent
//
//  Created by 苏虹 on 16/4/25.
//  Copyright © 2016年 smilingmobile. All rights reserved.
//

import UIKit
// MARK:TODO_DELETE
class BaseCellModel: NSObject {
    var className:String!
    var selectedBlock: ((IndexPath)->())?
    var indexPath:IndexPath?
    var cellHeight:CGFloat = 0.0
    var cellWidth:CGFloat = 0.0
}

// MARK:TODO_DELETE
class BaseSectionModel: NSObject {
    var sectionName :String!
    var selectedBlock :((IndexPath)->())?
    var indexPath :IndexPath?
    var sectionHeaderHeight :CGFloat = 0.0001
    var sectionFooterHeight :CGFloat = 0.0001
    var cellModels = [BaseCellModel]()
    
    var openSection:Bool = false
}




class HISBaseTableCellInfo : NSObject{
    var title : String = ""
    var titleColor: UIColor?
    var titleLeading:CGFloat?
    var titleFont: UIFont?
    var backGroundColor: UIColor?
    var des: String = ""
    var leftVColor: UIColor?
    var content : String?
    var placeholder : String?
    var chose : Bool = false
    
    var cellNibName : String = ""
    var gotoNextBlock : ((AnyObject)->())?
    var height : CGFloat = 44
    var model: AnyObject? // 携带的值
    
    
    var isNeedCornerRadius : Bool = false
    var isLast : Bool = false // 是否是最后一个
    var line : Bool = false // 是否显示分割线
    var topLine: Bool = false
    var bottomLine :Bool = false
    var isFirst:Bool = false
    var hiddenMore: Bool = false
    
}


class HISBaseTableViewInfo : NSObject{
    var cellNibName : String = ""
    var title : String = ""
    var clickBlock :  (()->())?
    var bgColor : UIColor?
    var line : Bool = false
}

class HISBaseSectionInfo: NSObject {
    var headInfo : HISBaseTableCellInfo?
    var footInfo : HISBaseTableCellInfo?
    var headHeight : CGFloat = 0.01
    var footHeight : CGFloat = 0.01
    var sectionIndexTitles: [String]?
    var cellInfoArray = [HISBaseTableCellInfo]()
}

class HomeExpertHeaderCellInfo: HISBaseTableCellInfo {
    var selectIndex: Int = 0
}

class CollectionContainerCellInfo: HISBaseTableCellInfo {
    var collectionContainerCellType:CollectionContainerCellType?
    
}

class DCCollectionContainerCellInfo: HISBaseTableCellInfo {
    var collectionContainerCellType:DCCollectionContainerCellType?
    
}




