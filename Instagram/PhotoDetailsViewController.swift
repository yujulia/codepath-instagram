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
    
    var detailData:NSDictionary?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let images = detailData?["images"]
        let lowres = images?["low_resolution"]!
        let url = lowres?["url"] as? String
        let imageURL = NSURL(string:url!)
        
        detailImage.setImageWithURL(imageURL!)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
