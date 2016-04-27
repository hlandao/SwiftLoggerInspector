//
//  LoggerInspectorViewController.swift
//  SwiftLoggerInspector
//
//  Created by Hadar on 4/27/16.
//  Copyright © 2016 hlandao. All rights reserved.
//

import Foundation
import SnapKit
import XCGLogger

class LoggerInspectorViewController: UIViewController {
    
    // MARK: Properties
    let titleLabel = UILabel()
    let tableView = UITableView()
    let copyToClipboard = UIButton()
    
    let fileUrl: NSURL?
    let LOG_CELL_IDENTIFIER = "LogTableViewCell"
    var logs: [String]?
    
    init(fileUrl: NSURL?) {
        self.fileUrl = fileUrl
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        view.backgroundColor = UIColor.darkGrayColor()
        initViews()
        logs = readFileToArray(fileUrl)
        setupDismissKeyboardViewTap()
        setupLongTapHandler()
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    // MARK: Setup
    private func initViews() {
        initTitleLabel()
        initTableView()
    }
    
    private func initTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.backgroundColor = UIColor.darkGrayColor()
        titleLabel.textColor = UIColor.whiteColor()
        view.addSubview(titleLabel)
        let label = fileUrl?.lastPathComponent ?? ""
        titleLabel.text = "Logs: \(label)"
        titleLabel.textAlignment = .Center
        titleLabel.snp_makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.centerX.equalTo(self.view)
            make.height.equalTo(44)
            make.top.equalTo(self.view.snp_top).offset(20)
        }
    }
    
    private func initTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.top.equalTo(self.titleLabel.snp_bottom)
            make.bottom.equalTo(self.view)
            make.centerX.equalTo(self.view)
        }
        tableView.registerClass(LogTableViewCell.self, forCellReuseIdentifier: LOG_CELL_IDENTIFIER)
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50.0
    }
    
    func setupDismissKeyboardViewTap() {
        let mainViewTap = UITapGestureRecognizer(target: self, action: #selector(LoggerInspectorViewController.tapOnMainView(_:)))
        view.userInteractionEnabled = true
        view.addGestureRecognizer(mainViewTap)
    }
    
    func setupLongTapHandler() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(LoggerInspectorViewController.longTapOnMainView(_:)))
        self.view.addGestureRecognizer(longPressRecognizer)
    }
    
    func tapOnMainView(sender: UITapGestureRecognizer) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func longTapOnMainView(sender: UITapGestureRecognizer) {
        if let str = readFileToString(fileUrl) {
            UIPasteboard.generalPasteboard().string = str
            let alert = UIAlertView(title: "Log was copied to clipboard", message: "", delegate: nil, cancelButtonTitle: nil)
            alert.show()
            alert.dismissWithClickedButtonIndex(0, animated: true)
        } else {
            let alert = UIAlertView(title: "Cannot copy log to clipboard", message: "", delegate: nil, cancelButtonTitle: nil)
            alert.show()
            alert.dismissWithClickedButtonIndex(0, animated: true)
        }
        
    }
    
    
    private func readFileToArray(fileUrl: NSURL?) -> [String]? {
        guard let fileUrl = fileUrl else {
            return nil
        }
        
        do {
            let fileStr = try String(contentsOfURL: fileUrl)
            let myStrings = fileStr.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
            return myStrings
        } catch {
            return nil
        }
    }
    
    private func readFileToString(fileUrl: NSURL?) -> String? {
        guard let fileUrl = fileUrl else {
            return nil
        }
        
        do {
            let fileStr = try String(contentsOfURL: fileUrl)
            return fileStr
        } catch {
            return nil
        }
    }
}

extension LoggerInspectorViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let logs = self.logs else {
            return 0
        }
        
        return logs.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(LOG_CELL_IDENTIFIER, forIndexPath: indexPath) as! LogTableViewCell
        
        cell.renderString(logs![indexPath.row])
        return cell
    }
}
