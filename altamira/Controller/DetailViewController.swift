//
//  DetailViewController.swift
//  altamira
//
//  Created by recep daban on 5.08.2019.
//  Copyright © 2019 com. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailTrackViewUrl: UITextView!
    @IBOutlet weak var detailArtistName: UILabel!
    @IBOutlet weak var detailCollectionName: UILabel!
    @IBOutlet weak var detailCollectionPrice: UILabel!
    @IBOutlet weak var detailTrackPrice: UILabel!
    @IBOutlet weak var detailKind: UILabel!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailImg: UIImageView!
    
    var detailedData : [String : Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setDataToView()
    }
    
    func setDataToView() {
        
        if detailedData["artworkUrl100"] != nil {
             detailImg.sd_setImage(with: URL(string:detailedData["artworkUrl100"] as! String), placeholderImage: nil)
        }
        if detailedData["trackName"] != nil {
             detailTitle.text = (detailedData["trackName"] as! String)
        }
        if detailedData["kind"] != nil {
               detailKind.text = (detailedData["kind"] as! String)
        }
        if detailedData["artistName"] != nil {
             detailArtistName.text = (detailedData["artistName"] as! String)
             detailArtistName.isHidden = false
        } else {
            detailArtistName.isHidden = true
        }
        if detailedData["collectionName"] != nil {
            detailCollectionName.text = (detailedData["collectionName"] as! String)
            detailCollectionName.isHidden = false
        } else {
            detailCollectionName.isHidden = true
        }
        if detailedData["collectionPrice"] != nil && detailedData["currency"] != nil {
             detailCollectionPrice.text = ((detailedData["collectionPrice"] as? NSNumber)! .stringValue) + " " + (detailedData["currency"] as! String)
             detailCollectionPrice.isHidden = false
        } else {
            detailCollectionPrice.isHidden = true
        }
        if detailedData["trackPrice"] != nil && detailedData["currency"] != nil {
              detailTrackPrice.text = ((detailedData["trackPrice"] as? NSNumber)! .stringValue) + " " + (detailedData["currency"] as! String)
            detailTrackPrice.isHidden = false
        } else {
            detailTrackPrice.isHidden = true
        }
        if detailedData["trackViewUrl"] != nil {
            detailTrackViewUrl.text = (detailedData["trackViewUrl"] as! String)
            detailTrackViewUrl.isHidden = false
        } else {
            detailTrackViewUrl.isHidden = true
        }
      
    }
}
