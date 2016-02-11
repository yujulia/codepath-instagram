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
    var instagramDict:NSDictionary?
    
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

                            self.instagramData = responseDictionary["data"] as? NSArray
                            self.instagramDict = responseDictionary["data"] as? NSDictionary

//                            print(self.instagramData)
                            
//                            for test in self.instagramData! {
//                                print(test)
//                                print("----------------------------")
//                            }
                            
                            self.iTableView.reloadData()
//                            print(self.instagramData["data"])

                    }
                }
        });
        task.resume()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("com.codepath.DemoPrototypeCell", forIndexPath: indexPath) as! iTableViewCell
        
        if (self.instagramData != nil){
            
            let oneData = self.instagramData![indexPath.row]
            let images = oneData["images"]!
            let lowres = images?["low_resolution"]!
            let url = lowres?["url"] as? String
            
            let imageURL = NSURL(string:url!)
            cell.instaImage.setImageWithURL(imageURL!)
            
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
//        return self.instagramData!.count
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

