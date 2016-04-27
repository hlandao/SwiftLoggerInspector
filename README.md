# SwiftLoggerInspector

[![Swift 2.2](https://img.shields.io/badge/Swift-2.2-orange.svg?style=flat)](https://swift.org/)
[![Platforms OS X | iOS | watchOS](https://img.shields.io/badge/Platforms-OS%20X%20%7C%20iOS%20%7C%20tvOS%20%7C%20watchOS-lightgray.svg?style=flat)](https://swift.org/)
[![License MIT](https://img.shields.io/badge/License-MIT-lightgrey.svg?style=flat)](https://github.com/DaveWoodCom/XCGLogger/blob/master/LICENSE.txt)

**Please note that this will also log your logs to a local file - USE ONLY IN DEBUG**

## tl;dr
Show [XCGLogger](https://github.com/DaveWoodCom/XCGLogger) logs on a running device.
## Install
1. Add the following to your podfile ``` pod 'XCGLogger', '~> 3.3'```
2. run ```pod install```
## Integrate
1. ```import SwiftLoggerInspector``` in any file you want to use it.
2. Add ```LoggerInspectorDestination``` as a log destination to your XCGLogger.
    ```
    import XCGLogger
    import SwiftLoggerInspector
    ...
    var logger = XCGLogger.defaultInstance()
    var loggerInspectorDestination: LoggerInspectorDestination!

    loggerInspectorDestination = LoggerInspectorDestination(owner: logger, writeToFile: logFilePath())
    logger.addLogDestination(loggerInspectorDestination)
    ```
3. Call ```loggerInspectorDestination.presentInspector()```
4. Use XCGLogger as you'd always do.

## Example: Init in AppDelegate
Bonus: Present the inspector when shaking the device!
```
    var logger = XCGLogger.defaultInstance()
    var loggerInspectorDestination: LoggerInspectorDestination!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        loggerInspectorDestination = LoggerInspectorDestination(owner: logger, writeToFile: logFilePath())
        logger.addLogDestination(loggerInspectorDestination)

        logger.debug("App delefate launched!")
        return true
    }

    // Log file path url
    func logFilePath() -> NSURL {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask)
        let url = urls[urls.endIndex - 1]
        return url.URLByAppendingPathComponent("myLogFile.log")
    }

    // Detect shaking gesture
    override func motionBegan(motion: UIEventSubtype,
                              withEvent event: UIEvent?) {
        if motion == .MotionShake{
            let logger = XCGLogger.defaultInstance()
            if let loggerInspectorDestination = logger.logDestinations.last as? LoggerInspectorDestination {
                loggerInspectorDestination.presentInspector()
            }
        }
    }
```
