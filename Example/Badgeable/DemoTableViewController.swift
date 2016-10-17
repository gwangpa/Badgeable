//
//  DemoTableViewController.swift
//  Badgeable
//
//  Created by Daniel KIM on 9/10/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Badgeable

class DemoTableViewController: UITableViewController {
    
    @IBOutlet weak var label: Label!
    @IBOutlet weak var button: Button!
    @IBOutlet weak var textField: TextField!
    @IBOutlet weak var `switch`: Switch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 66.0
        tableView.estimatedRowHeight = 66.0
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.badgeCount = 4
        button.badgeCount = 4
        textField.badgeCount = 4
        `switch`.badgeCount = 4
    }

}
