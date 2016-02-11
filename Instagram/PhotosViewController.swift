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
    
    var instagramData:NSDictionary?
    
    
    let data = ["New York, NY", "Fort Worth, TX"]
    
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
                            self.instagramData = responseDictionary
                            
                            self.iTableView.reloadData()
//                            print(self.instagramData["data"])

                    }
                }
        });
        task.resume()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("com.codepath.DemoPrototypeCell", forIndexPath: indexPath) as! iTableViewCell
        
//        let oneData = self.instagramData[indexPath.row]?
//        print("ONE", oneData)
        
//        let url = oneData["images"]?["low_resolution"]?["url"]?
        
//        cell.cityLable.text = url
        
        let cityState = data[indexPath.row].componentsSeparatedByString(", ")
        cell.cityLabel.text = cityState.first
        cell.stateLabel.text = cityState.last
        
        let imageURL = NSURL(string:"https://scontent.cdninstagram.com/t51.2885-15/s320x320/e35/12558253_1541170002878318_987227936_n.jpg?ig_cache_key=MTE4MjM1MTExMjEyMTEyNjE5Nw%3D%3D.2")
        
        cell.instaImage.setImageWithURL(imageURL!)
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getInstagramData()
        
        iTableView.dataSource = self
        iTableView.delegate = self
        
        self.iTableView.rowHeight = 320
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

