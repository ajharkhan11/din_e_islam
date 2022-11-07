//
//  GenericTableViewDataSource.swift
//  din-e-islam
//
//  Created by Ajharudeen Khan on 05/10/22.
//

import UIKit

class GenericTableViewDataSource<CELL: UITableViewCell, T>: NSObject,UITableViewDataSource,UITableViewDelegate {
    
    private var cellIdentifier : String!
    
    private var items : [T]?
    
    var configureCell : (CELL, T?) -> () = {_,_ in }
    
    init(cellIdentifier : String, items : [T]?, configureCell : @escaping (CELL, T?) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let item = items?[indexPath.row]
        self.configureCell(tableViewCell as! CELL, item)
        return tableViewCell
    }
}
