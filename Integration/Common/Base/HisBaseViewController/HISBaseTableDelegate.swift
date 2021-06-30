//
//  HISBaseTableDelegate.swift
//  HIStudent
//
//  Created by 苏虹 on 16/4/25.
//  Copyright © 2016年 smilingmobile. All rights reserved.
//

import UIKit

protocol HISSrollDelegate{
    func scroll(scrollView:UIScrollView)
    func scrollDidEndDragging(scrollView:UIScrollView, decelerate:Bool)
}

//MARK: CELL
public func getCellNibName(_ aClass: AnyClass)->String{
    let nameSpaceClassName = NSStringFromClass(aClass.self)
    let className = nameSpaceClassName.components(separatedBy: ".").last! as String
    return className
}

func registerCell<T: UITableViewCell>(_ tableView:UITableView,cell:T.Type){
    tableView .register(UINib.init(nibName: "\(cell)", bundle: nil), forCellReuseIdentifier: "\(cell)")
}

func getCell<T: UITableViewCell>(_ tableView:UITableView ,cell: T.Type ,indexPath:IndexPath) -> T {
    return tableView.dequeueReusableCell(withIdentifier: "\(cell)", for: indexPath) as! T ;
}

func swiftClassFromString(_ className: String) -> AnyClass! {
    //获取命名空间
    guard let appNameSpace = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String else {
        print("获取失败")
        return nil
    }
    //拼接完整的类
    guard let cls = NSClassFromString(appNameSpace + "." + className) else {
        print("拼接失败")
        return nil
    }
    return cls
}

class HISBaseTableDelegate: NSObject,UITableViewDelegate,UITableViewDataSource {
    var dataDic = NSMutableDictionary()
    var delegate : HISSrollDelegate?

    func loadData(_ dic:NSMutableDictionary){
        self.dataDic = dic
    }

    func getSectionInfo(_ section:Int)->HISBaseSectionInfo{
        let secIndex = NSString.init(format: "%d", section)
        return  self.dataDic[secIndex] as! HISBaseSectionInfo
    }

    func getCellInfo(_ index:IndexPath)->HISBaseTableCellInfo{
        let secInfo = getSectionInfo(index.section)
        return secInfo.cellInfoArray[index.row] as! HISBaseTableCellInfo
    }
    
    //MARK: Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let info = getCellInfo(indexPath)
        let cellClass=swiftClassFromString(info.cellNibName) as! BaseTableCell.Type
        let cell=getCell(tableView, cell: cellClass.self, indexPath: indexPath)
        cell.fillData(info)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let secIndex = NSString.init(format: "%d",section)
        let secInfo = self.dataDic[secIndex] as! HISBaseSectionInfo
        return secInfo.cellInfoArray.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataDic.allKeys.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let info = getCellInfo(indexPath)
        return info.height
    }

    //MARK: Head && Foot
    func getViewForSection(_ info:HISBaseTableCellInfo,secIndex:Int)->BaseTableCell{
        let array  = Bundle.main.loadNibNamed(info.cellNibName, owner: self, options: nil)
        let view : BaseTableCell = array?[0] as! BaseTableCell
        view.fillData(info)
        return view
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let secInfo = getSectionInfo(section)
        if  nil != secInfo.headInfo {
            return getViewForSection(secInfo.headInfo!, secIndex: section)
        }else {
            return UIView.init()
        }
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let secInfo = getSectionInfo(section)
        if  nil != secInfo.footInfo {
            return getViewForSection(secInfo.footInfo!, secIndex: section)
        }else {
            return UIView.init()
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let secInfo = getSectionInfo(section)
        return secInfo.headHeight
    }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if let secInfo = self.dataDic["0"] as? HISBaseSectionInfo {
            return secInfo.sectionIndexTitles ?? []
            
        }
        return []
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let secInfo = getSectionInfo(section)
        return secInfo.footHeight
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if nil != self.delegate {
            self.delegate?.scroll(scrollView: scrollView)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if nil != self.delegate {
            self.delegate?.scrollDidEndDragging(scrollView: scrollView, decelerate: decelerate)
        }
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let info = getCellInfo(indexPath)
        if let tempModel = info.model {
            info.gotoNextBlock?(tempModel)
        }else {
            info.gotoNextBlock?(-1 as AnyObject)
        }
        
    }


}


