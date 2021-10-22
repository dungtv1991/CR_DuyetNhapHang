//
//  BaseUITableViewDataSource.swift
//  BaoCaoHinhAnhTrungBay
//
//  Created by Trần Văn Dũng on 08/07/2021.
//

import Foundation
import UIKit

protocol BaseUITableViewDataSourceDelegate:class {
    func didSelectIndex<T>(model:T)
}

class BaseUITableViewDataSource<CELL : UITableViewCell,T> : NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private var cellIdentifier : String!
    private var items : [T]!
    var configureCell : (CELL, T, Int) -> () = {_,_,_ in }
    weak var baseUITableViewDataSourceDelegate:BaseUITableViewDataSourceDelegate?
    
    init(cellIdentifier : String, items : [T], configureCell : @escaping (CELL, T, Int) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.items.count != 0 {
            tableView.backgroundView?.isHidden = true
        }
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CELL
        
        let item = self.items[indexPath.row]
        self.configureCell(cell, item, indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.baseUITableViewDataSourceDelegate?.didSelectIndex(model: items[indexPath.row])
    }
}
