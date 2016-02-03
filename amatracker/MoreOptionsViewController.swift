//
//  MoreOptionsViewController.swift
//  amatracker
//
//  Created by Ryan Martz on 1/31/16.
//  Copyright © 2016 ryan. All rights reserved.
//

import UIKit

class MoreOptionsViewController: UIViewController {
    
    let EXPORT_TABLE_CELL_ID = "exportTableCell"
    
    let exportOptions : [String] = ["Google Drive", "Dropbox"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }


}

extension MoreOptionsViewController : UITableViewDataSource {
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exportOptions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : ExportOptionTableCell = tableView.dequeueReusableCellWithIdentifier(EXPORT_TABLE_CELL_ID) as! ExportOptionTableCell
        
        cell.cellTitle.text = exportOptions[indexPath.row]
        
        return cell
    }
    
}

extension MoreOptionsViewController : UITableViewDelegate {
    
        
}