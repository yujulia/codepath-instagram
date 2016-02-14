//
//  PhotoDetailsViewController.swift
//  Instagram
//
//  Created by Julia Yu on 2/12/16.
//  Copyright © 2016 Julia Yu. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var caption: UILabel!
    
    var detailData:NSDictionary?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let oneData = detailData!
        let images = oneData["images"]!
        let lowres = images["low_resolution"]!
        let url = lowres?["url"] as? String
        let imageURL = NSURL(string:url!)
        
        let dataCaption = detailData?["caption"]
        let dataText = dataCaption!["text"]
        
        detailImage.setImageWithURL(imageURL!)
        caption.text = dataText as? String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "zoomSegue") {
            let zoomView = segue.destinationViewController as! ZoomViewController
            zoomView.detailData = detailData
        }
    }
    
    @IBAction func onTap(tapper: UITapGestureRecognizer) {
        performSegueWithIdentifier("zoomSegue", sender: tapper)
    }

}
