//
//  ViewController.swift
//  ActivityDemo
//
//  Created by Gene De Lisa on 7/10/14.
//  Copyright (c) 2014 Gene De Lisa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var toolbar: UIToolbar
    
    @IBOutlet var textView: UITextView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // the "share" icon
        var share = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: "share:")
        
        var spacer = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace,
            target: self, action: nil)
        self.toolbar.items=[share]
        self.textView.text = "This is some text."

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func share(sender: AnyObject) {
        let someText:String = textView.text
        
        let google:NSURL = NSURL(string:"http://google.com/")
        
        let activityViewController = UIActivityViewController(
            activityItems: [someText, google],
            applicationActivities: nil)
        
        activityViewController.completionHandler = {(activityType, completed:Bool) in
            if !completed {
                println("cancelled")
                return
            }
            
            if activityType == UIActivityTypePostToTwitter {
                println("twitter")
            }
            
            if activityType == UIActivityTypeMail {
                println("mail")
            }
        }
        
        
//        activityViewController.excludedActivityTypes =  [
//            UIActivityTypePostToTwitter,
//            UIActivityTypePostToFacebook,
//            UIActivityTypePostToWeibo,
//            UIActivityTypeMessage,
//            UIActivityTypeMail,
//            UIActivityTypePrint,
//            UIActivityTypeCopyToPasteboard,
//            UIActivityTypeAssignToContact,
//            UIActivityTypeSaveToCameraRoll,
//            UIActivityTypeAddToReadingList,
//            UIActivityTypePostToFlickr,
//            UIActivityTypePostToVimeo,
//            UIActivityTypePostToTencentWeibo
//        ]
        
        
        self.navigationController.presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    
}

