//
//  ViewController.swift
//  SwiftLoggerInspector
//
//  Created by Hadar on 4/27/16.
//  Copyright © 2016 hlandao. All rights reserved.
//

import UIKit
import XCGLogger

class ViewController: UIViewController {

    var logger = XCGLogger.defaultInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logger.debug("View controller was loaded and logger was initialized!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func showInspectorPressed(sender: AnyObject) {
        logger.info("Show inspector pressed!")
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.loggerInspectorDestination.presentInspector()
    }
    
}

