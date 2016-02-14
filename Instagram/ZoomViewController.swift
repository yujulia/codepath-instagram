//
//  ZoomViewController.swift
//  Instagram
//
//  Created by Julia Yu on 2/14/16.
//  Copyright © 2016 Julia Yu. All rights reserved.
//

import UIKit

class ZoomViewController: UIViewController, UIScrollViewDelegate {

    var detailData:NSDictionary?

    @IBOutlet weak var zoomImage: UIImageView!
    @IBOutlet weak var scrollPanel: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = detailData!.valueForKeyPath("images.low_resolution.url") as! String
        let imageURL = NSURL(string:urlString)
        zoomImage.setImageWithURL(imageURL!)
        scrollPanel.contentSize = zoomImage.image!.size
        scrollPanel.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func closeClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {});
    }
    
    func viewForZoomingInScrollView(scrollPanel: UIScrollView!) -> UIView! {
        return zoomImage
    }
}
