//
//  LessonsListViewController.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/26/22.
//

import UIKit
import Combine

final class LessonsListViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension LessonsViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
