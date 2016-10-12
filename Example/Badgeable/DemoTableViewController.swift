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
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var `switch`: UISwitch!
    
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
