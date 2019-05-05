//
//  HomeViewController.swift
//  CampusImpression
//
//  Created by Xinhao Liang on 2/23/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

//    var postId: String!
    @IBOutlet weak var tableView: UITableView!
    
    var selectedPost: PFObject!
    var posts = [PFObject]()
    var postslimit = 20
    var postlikes = 0
    var liked: Bool = false
    
    let myRefreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightAddBarButtonItem = UIBarButtonItem(image: UIImage(named: "add"), style: .plain, target: self, action: #selector(showPostScreen))
        let rightFilterBarButtonItem = UIBarButtonItem(image: UIImage(named: "category"), style: .plain, target: self, action: #selector(showFilterScreen))
        self.navigationItem.setRightBarButtonItems([rightAddBarButtonItem,rightFilterBarButtonItem], animated: false)
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 400
        
        myRefreshControl.addTarget(self, action: #selector(loadPosts), for: .valueChanged)
        self.tableView.refreshControl = myRefreshControl
        self.tableView.tableFooterView = UIView()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "Your date Format"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadPosts()
    }

    @objc func showFilterScreen() {
        self.performSegue(withIdentifier: "FilterSegue", sender: nil)
    }
    
    @objc func showPostScreen() {
        self.performSegue(withIdentifier: "AddPostSegue", sender: nil)
    }
    
    // Implement the delay method
    func run(after wait: TimeInterval, closure: @escaping () -> Void) {
        let queue = DispatchQueue.main
        queue.asyncAfter(deadline: DispatchTime.now() + wait, execute: closure)
    }
    
    @objc func loadPosts() {
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
        
        let filter = UserDefaults.standard.string(forKey: "Filter")
        if filter != nil && filter != "All" {
            query.whereKey("tag", equalTo: filter!)
        }
        query.order(byDescending: "createdAt")
        query.limit = postslimit
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
        run(after: 2) {
            self.myRefreshControl.endRefreshing()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == posts.count {
            loadMorePosts()
        }
    }
    
    func loadMorePosts() {
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
        let filter = UserDefaults.standard.string(forKey: "Filter")
        if filter != nil {
            query.whereKey("tag", equalTo: filter!)
        }
        query.order(byDescending: "createdAt")
        postslimit = postslimit + 20
        query.limit = postslimit
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil && posts!.count > 20 {
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
    }
    
//    @objc func likePressed(_ sender: UIButton)
//    {
//        if liked{
//            sender.setImage(UIImage(named: "fav-icon-red"), for: UIControl.State.normal)
//        }
//        else{
//            sender.setImage(UIImage(named: "fav-icon"), for: UIControl.State.normal)
//        }
//    }
    
    func showButton(cell: PostCell){
        //print("\nAgain", liked)
        if liked{
            cell.likeButton.setImage(UIImage(named: "fav-icon-red"), for: UIControl.State.normal)
        }
        else{
            cell.likeButton.setImage(UIImage(named: "fav-icon"), for: UIControl.State.normal)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        let post = posts[indexPath.row]
        let imageFile = (post["image"] as? PFFileObject) ?? nil

        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor(named: "borderColor")?.cgColor
        if imageFile == nil {
            cell.photoViewHeight.constant = 0
        }
        else {
            let urlString = imageFile!.url!
            let url = URL(string: urlString)!
            cell.photoView.af_setImage(withURL: url)
            cell.photoViewHeight.constant = 185
        }
        
        let user = post["author"] as! PFUser
        cell.postTag.text = "#\(String(describing: post["tag"] as! String))"
        
        // substract timePosted from currentTime
        let currTime = Date()
        let postedTime = post["postedTime"] as? Date
        if postedTime != nil {
            let calendar = Calendar.current
            let timeDiff = calendar.dateComponents([.day, .hour, .minute], from: postedTime!, to: currTime)
            if timeDiff.hour! < 1 {
                cell.postedBy.text = "\(String(describing: timeDiff.minute!)) mins ago by \(String(describing: user.username!))"
            } else if timeDiff.day! < 1 {
                cell.postedBy.text = "\(String(describing: timeDiff.hour!)) hrs ago by \(String(describing: user.username!))"
            } else {
                cell.postedBy.text = "\(String(describing: timeDiff.day!)) days ago by \(String(describing: user.username!))"
            }
        } else {
            cell.postedBy.text = user.username
        }
        cell.postTitle.text = (post["postTitle"] as! String)
        cell.postPreview.text = (post["postContents"] as! String)
        
        let likes = (post["likes"] as? [PFObject]) ?? []
        postlikes = likes.count
        
        cell.likeCounting.text = String(postlikes)
        
//        let query = PFQuery(className: "Likes")
//        query.includeKeys(["post", "author"])
//        
//        query.whereKey("post", equalTo: post)
//        query.whereKey("author", equalTo: PFUser.current() as! PFObject)
//        
//        query.findObjectsInBackground { (like, error) in
//            if like != [] {
//                self.liked = true
//            }
//            else{
//                self.liked = false
//            }
//        }
//        
//        self.showButton(cell: cell)
        
        //cell.likeButton.addTarget(self, action: #selector(HomeViewController.likePressed(_:)), for: .touchUpInside)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        self.selectedPost = post
        self.performSegue(withIdentifier: "PostDetailsSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let postDetailsViewController = segue.destination as? PostDetailsViewController {
            postDetailsViewController.selectedPost = self.selectedPost
        }
    }
}
