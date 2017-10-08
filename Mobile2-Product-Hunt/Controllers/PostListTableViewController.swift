//
//  PostListTableViewController.swift
//  Mobile2-Product-Hunt
//
//  Created by Erik Perez on 10/8/17.
//  Copyright © 2017 Erik Perez. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {
    var posts = [Post]() {
        didSet {
            DispatchQueue.main.async {
                 self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        Networking.shared.fetch(route: .post) { (data) in
            let decodedPosts = try? JSONDecoder().decode(PostList.self, from: data)
            guard let postList = decodedPosts?.posts else { return }
            self.posts = postList
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell",
                                                 for: indexPath) as! PostTableViewCell
        cell.nameLabel.text = posts[index].name
        cell.taglineLabel.text = posts[index].tagline
        cell.votesLabel.text = String(posts[index].votes)
        cell.thumbnailImageView.downloadedFrom(link: posts[index].thumbnailURL,
                                               contentMode: .scaleAspectFill)
        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toComments"{
            let commentListTableView = segue.destination as! CommentListTableViewController
            guard let indexPath = tableView.indexPathForSelectedRow else { fatalError("indexPath fail") }
            
            let postID = posts[indexPath.row].id
            
            Networking.shared.fetch(route: .comments(postId: postID)) { (data) in
                let decodedComments = try? JSONDecoder().decode(Comments.self, from: data)
                guard let commentList = decodedComments?.comments else { return }
                commentListTableView.comments = commentList
            }
        }
    }
}




