//
//  SaveLoadGameMenu.swift
//  Phantom of the West
//
//  Created by Christopher Raleigh on 2015/10/28.
//  Copyright © 2015 Christopher Raleigh. All rights reserved.
//

import GameKit
import UIKit

/*
An options submenu that handles in-app purchases.
*/
class SaveLoadGameMenu: OptionsMenu {
    
    var options: [SavedGameItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let o = options {
            return o.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let o = options {
            let targetIndex = indexPath.row
            return o[targetIndex].cell
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let o = options {
            let i = indexPath.row
            let selectedCell = o[i]
            OptionsMenu.selectedRow(tableView, indexPath: indexPath, option: selectedCell)
        }
    }
    
    override func tableView(tableView: UITableView,
        canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
            return true
    }
}