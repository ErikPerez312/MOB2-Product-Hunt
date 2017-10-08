//
//  CommentListTableViewController.swift
//  Mobile2-Product-Hunt
//
//  Created by Erik Perez on 10/8/17.
//  Copyright © 2017 Erik Perez. All rights reserved.
//

import UIKit

class CommentListTableViewController: UITableViewController {
    //TODO: Handle abcense of comments and optionals
    var comments = [Comment?]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell",
                                                 for: indexPath) as! CommentTableViewCell
        cell.userDisplayNameLabel.text = comments[indexPath.row]?.userDisplayName ?? " "
        cell.accountUsernameLabel.text = comments[indexPath.row]?.accountUsername
        cell.bodyLabel.text = comments[indexPath.row]?.body
        
        // FIXME: Vote count is nil
//        cell.votesLabel.text = String(describing: comments[indexPath.row]?.votes)
//        if let votes = comments[indexPath.row]?.votes{
//            cell.votesLabel.text = String(votes)
//        }
        return cell
    }
}










