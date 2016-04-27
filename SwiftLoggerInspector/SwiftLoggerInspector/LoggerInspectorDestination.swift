//
//  LoggerInspectorDestination.swift
//  SwiftLoggerInspector
//
//  Created by Hadar on 4/27/16.
//  Copyright © 2016 hlandao. All rights reserved.
//

import Foundation
import XCGLogger

class LoggerInspectorDestination: XCGFileLogDestination {
    
    var fileUrl: NSURL?
    
    override init(owner: XCGLogger, writeToFile: AnyObject, identifier: String = "") {
        super.init(owner: owner, writeToFile: writeToFile, identifier: identifier)
        
        if writeToFile is NSString {
            fileUrl = NSURL.fileURLWithPath(writeToFile as! String)
        }
        else if writeToFile is NSURL {
            fileUrl = writeToFile as? NSURL
        }
        else {
            fileUrl = nil
        }
        
    }
    
    func presentInspector() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        guard let rootViewController = appDelegate.window?.rootViewController else {
            return
        }
        
        let inspectorViewController = LoggerInspectorViewController(fileUrl: self.fileUrl)
        rootViewController.presentViewController(inspectorViewController, animated: true, completion: nil)
    }
}


