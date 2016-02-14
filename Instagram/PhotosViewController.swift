//
//  ViewController.swift
//  Instagram
//
//  Created by Julia Yu on 2/10/16.
//  Copyright © 2016 Julia Yu. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var iTableView: UITableView!
    
    var instagramData:NSMutableArray?
    var total = 0
    var loading = false
    
    let imageHeight = 320
    let headerHeight = 60
    let padBottom = 20
    let refreshControl = UIRefreshControl()
    let tableFooterView: UIView = UIView(frame: CGRectMake(0, 0, 320, 50))
    let loadingView: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
    
    func stopLoading(){
        self.loading = false
        loadingView.stopAnimating()
        self.iTableView.tableFooterView?.hidden = true
    }
    
    func loadMore() {
        if (self.loading) {
            return
        }
        loadingView.startAnimating()
        self.iTableView.tableFooterView?.hidden = false
        
        self.loading = true
        getInstagramData()
    }
    
    func getInstagramData() {
        let clientId = "e05c462ebd86446ea48a5af73769b602"
        let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\(clientId)")
        let request = NSURLRequest(URL: url!)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            
                            let moreData = responseDictionary["data"] as? NSMutableArray

                            if (self.instagramData == nil) {
                                self.instagramData = moreData
                            } else {
                                // ADD MORE DATA HOW
//                                self.instagramData?.addObjectsFromArray(moreData)
                            }
                            
                            self.total = self.instagramData!.count
                            self.iTableView.reloadData()
                            self.refreshControl.endRefreshing()
                            
                            self.stopLoading()
                    }
                }
        });
        task.resume()
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("com.codepath.DemoPrototypeCell", forIndexPath: indexPath) as! iTableViewCell
        
        if (self.instagramData != nil) {
            let oneData = self.instagramData![indexPath.section]
            let images = oneData["images"]!
            let lowres = images?["low_resolution"]!
            let url = lowres?["url"] as? String
            let imageURL = NSURL(string:url!)
    
            cell.instaImage.setImageWithURL(imageURL!)
        }
        

        let max = self.total - 1
        if (max == indexPath.section) {
            print("load more")
            self.loadMore()
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return total
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        headerView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        
        let profileView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 15;
        profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
        profileView.layer.borderWidth = 1;
        
        let usernameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 280, height: 30))
        usernameLabel.frame.origin.x = 50
        usernameLabel.frame.origin.y = 8
        usernameLabel.font = UIFont(name: "HelveticaNeue-Light", size: 14.0)
        usernameLabel.textColor = UIColor.grayColor()
        
        let oneData = self.instagramData![section]
        let user = oneData["user"]!
        let name = user?["username"] as? String
        let profilepic = user?["profile_picture"] as? String
        let profileImageURL = NSURL(string:profilepic!)

        profileView.setImageWithURL(profileImageURL!)
        usernameLabel.text = name
        
        headerView.addSubview(profileView)
        headerView.addSubview(usernameLabel)
        
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        self.getInstagramData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getInstagramData()
        
        iTableView.dataSource = self
        iTableView.delegate = self
        
        self.iTableView.rowHeight = CGFloat(imageHeight + headerHeight + padBottom)
        
        self.refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        iTableView.insertSubview(refreshControl, atIndex: 0)
        
        loadingView.center = tableFooterView.center
        tableFooterView.addSubview(loadingView)
        self.iTableView.tableFooterView = tableFooterView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "detailSegue") {
            let detailView = segue.destinationViewController as! PhotoDetailsViewController
            let indexPath = iTableView.indexPathForCell(sender as! UITableViewCell)
            let rowNum = indexPath?.section
            let oneData = self.instagramData![rowNum!]
            
            detailView.detailData = oneData as? NSDictionary
            
        }
        
    }


}

