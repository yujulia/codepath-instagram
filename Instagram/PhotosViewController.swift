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
    
    var instagramData:NSArray?
    
    let imageHeight = 320
    let headerHeight = 60
    let padBottom = 20
    let refreshControl = UIRefreshControl()
    
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

                            self.instagramData = responseDictionary["data"] as? NSArray
                            self.iTableView.reloadData()
                            self.refreshControl.endRefreshing()
                    }
                }
        });
        task.resume()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("com.codepath.DemoPrototypeCell", forIndexPath: indexPath) as! iTableViewCell
        
        cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.width / 2
        cell.profileImage.clipsToBounds = true
        cell.profileImage.layer.borderColor = UIColor.lightGrayColor().CGColor
        cell.profileImage.layer.borderWidth = 2
        
        if (self.instagramData != nil) {
            
            let oneData = self.instagramData![indexPath.row]
            let images = oneData["images"]!
            let lowres = images?["low_resolution"]!
            let url = lowres?["url"] as? String
            let imageURL = NSURL(string:url!)
            
            let user = oneData["user"]!
            let name = user?["username"] as? String
            let profilepic = user?["profile_picture"] as? String
            let profileImageURL = NSURL(string:profilepic!)
            
            
            cell.instaImage.setImageWithURL(imageURL!)
            cell.profileImage.setImageWithURL(profileImageURL!)
            cell.username.text = name
            
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = self.instagramData
        if (data != nil) {
            return data!.count
        } else {
            return 0
        }
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "detailSegue") {
            let detailView = segue.destinationViewController as! PhotoDetailsViewController
            let indexPath = iTableView.indexPathForCell(sender as! UITableViewCell)
            let rowNum = indexPath?.row
            let oneData = self.instagramData![rowNum!]
            
            detailView.detailData = oneData as? NSDictionary
            
        }
        
    }


}

