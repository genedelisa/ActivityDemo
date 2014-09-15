//
//  ViewController.swift
//  ActivityDemo
//
//  Created by Gene De Lisa on 7/10/14.
//  Copyright (c) 2014 Gene De Lisa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var toolbar: UIToolbar!
    
    @IBOutlet var textView: UITextView!
    
    var activityViewController:UIActivityViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // the "share" icon
        var share = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: "share:")
        
        var spacer = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace,
            target: self, action: nil)
        self.toolbar.items=[share]
        self.textView.text = "This is some text."
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func buttonAction(sender: AnyObject) {
        share(sender)
    }
    
    func share(sender: AnyObject) {
        let someText:String = textView.text
        
        let google:NSURL = NSURL(string:"http://google.com/")
        
        
        // let's add a String and an NSURL
        activityViewController = UIActivityViewController(
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
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            self.navigationController?.presentViewController(activityViewController, animated: true, completion: nil)
        } else if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            // actually, you don't have to do this. But if you do want a popover, this is how to do it.
            iPad(sender)
        }
    }
    
    lazy var activityPopover:UIPopoverController = {
        return UIPopoverController(contentViewController: self.activityViewController)
        }()
    
    func iPad(sender: AnyObject) {
        if !self.activityPopover.popoverVisible {
            if sender is UIBarButtonItem {
                self.activityPopover.presentPopoverFromBarButtonItem(sender as UIBarButtonItem,
                    permittedArrowDirections:.Any,
                    animated:true)
            } else {
                var b = sender as UIButton
                self.activityPopover.presentPopoverFromRect(b.frame,
                    inView: self.view,
                    permittedArrowDirections:.Any,
                    animated:true)
            }
        } else {
            self.activityPopover.dismissPopoverAnimated(true)
        }
    }
    
    
}

