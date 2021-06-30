//
//  BaseTableViewController.swift
//  Student
//
//  Created by 苏虹 on 16/3/31.
//
//

import UIKit
import HandyJSON

class HISBaseTableViewController: QYTableVC {

    var dataDic = NSMutableDictionary()
    let tableDelegate = HISBaseTableDelegate()

    var pageIndex:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        view.backgroundColor = Color.customWhite
        
    }
    
    func configTableView() {
        
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 100
        
        self.setDeletableForTableView(self.tableView, delegate: tableDelegate)
        
        tableView.header = RefreshHeader{[weak self] in
            self?.requestHeader()
        }
        
        tableView.footer = RefreshFooter{[weak self] in
            self?.footerRefresh()
        }
        tableView.footer?.isHidden = true
        
        tableView.cbEmpty = EmptyView.init(image:UIImage(named: "common_noRecord") , title: "暂时还没有相关数据", des: "", verticalOffset: -100) {[weak self] in
            self?.headerRefresh()
            
        }
        
        tableView.tableFooterView = UIView()
        
    }
    
    @objc func headerRefresh() {
        requestHeader()
        
    }
    
    @objc func requestHeader() {
        request(pageIndex: 0)
    }
    
    func footerRefresh() {
        let pageIndex = self.pageIndex + 1
        request(pageIndex: pageIndex)
    }
    
    func request(pageIndex: Int) {
        
    }

    func setDeletableForTableView(_ tbView:UITableView,delegate:HISBaseTableDelegate){
        tbView.dataSource = delegate
        tbView.delegate = delegate
        tbView.backgroundColor = UIColor.clear
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getContent(_ row:Int,section:Int)->NSString{
        let sectionInfo = self.dataDic[String(section)] as! HISBaseSectionInfo
        let cellInfo = sectionInfo.cellInfoArray[row] as! HISBaseTableCellInfo
        return cellInfo.content! as NSString
    }


}
