//
//  LogTableViewCell.swift
//  SwiftLoggerInspector
//
//  Created by Hadar on 4/27/16.
//  Copyright © 2016 hlandao. All rights reserved.
//

import UIKit
import XCGLogger

class LogTableViewCell: UITableViewCell {
    
    let textView = UITextView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(textView)
        textView.snp_makeConstraints { (make) in
            make.right.equalTo(self.contentView)
            make.left.equalTo(self.contentView)
            make.top.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView)
        }
        textView.font = UIFont.systemFontOfSize(16.0)
        textView.scrollEnabled = false
        textView.editable = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func renderString(str: String) {
        textView.text = str
        textView.textColor = getColorForLogMessage(str)
        textView.sizeToFit()
    }
    
    private func getColorForLogMessage(str: String) -> UIColor {
        guard let logLevel = getLogLevelForLogMessage(str) else {
            return UIColor.grayColor()
        }
        
        switch logLevel {
        case .Verbose:
            return UIColor.lightGrayColor()
        case .Debug:
            return UIColor.darkGrayColor()
        case .Info:
            return UIColor.blueColor()
        case .Warning:
            return UIColor.yellowColor()
        case .Error:
            return UIColor.orangeColor()
        case .Severe:
            return UIColor.redColor()
        default:
            return UIColor.grayColor()
        }
    }
    
    private func getLogLevelForLogMessage(str: String) -> XCGLogger.LogLevel? {
        if str.containsString("[Verbose]") {
            return XCGLogger.LogLevel.Verbose
        } else if str.containsString("[Debug]") {
            return XCGLogger.LogLevel.Debug
        } else if str.containsString("[Info]") {
            return XCGLogger.LogLevel.Info
        } else if str.containsString("[Warning]") {
            return XCGLogger.LogLevel.Warning
        } else if str.containsString("[Error]") {
            return XCGLogger.LogLevel.Error
        } else if str.containsString("[Severe]") {
            return XCGLogger.LogLevel.Severe
        } else {
            return nil
        }
    }
}