//
//  ViewController.swift
//  PicSearch
//
//  Created by Russell Archer on 22/08/2018.
//  Copyright © 2018 Russell Archer. All rights reserved.
//

import UIKit
import Intents
import CoreSpotlight
import CoreServices

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    fileprivate let _imageNames = ["Owl", "Parrot", "Penguin"]
    fileprivate var _imageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func donateShortcut() {
        // Search attributes
        let attributes = CSSearchableItemAttributeSet(itemContentType: kUTTypeItem as String)
        attributes.contentDescription = "See the pretty picture!"
        attributes.thumbnailData = UIImage(named: "Owl")?.pngData()  // This doesn't seem to work for some reason in iOS 12 betas

        let activity = NSUserActivity(activityType: "com.rarcher.PicSearch.showPic")
        activity.title = "Show Pic"                         // The shortcut's title
        activity.userInfo = ["key" : "value"]               // Dictionary of additional user data as key/value pairs
        activity.isEligibleForSearch = true                 // If true shortcut is shown in search view
        activity.isEligibleForPrediction = true             // Siri can suggest the shortcut to the user (reqs isEligibleForSearch to be true)
        activity.isEligibleForHandoff = true                // The shortcut is available on all my devices
        activity.suggestedInvocationPhrase = "Show Picture" // Text suggested to the user when they create a shortcut
        activity.contentAttributeSet = attributes           // Add the search attributes

        userActivity = activity
    }
    
    public func showPic() {
        imageView.image = UIImage(named: _imageNames[_imageIndex])
        
        // We rotate between three example images
        if _imageIndex == 2 { _imageIndex = 0 }
        else { _imageIndex += 1 }
        
        donateShortcut()
    }
    
    @IBAction func showPictureTapped(_ sender: Any) {
        showPic()
    }
}

