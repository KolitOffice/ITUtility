//
//  ITUtility.swift
//  AISCamp
//
//  Created by Itsaraporn Chaichayanon on 3/9/2558 BE.
//  Copyright (c) 2558 AIS (SAND-DLD). All rights reserved.
//

import UIKit

private var _callback: (() -> Void)?

class ITUtility: NSObject {
    
    class func writeLogData (tag: String, data: NSData?, file:String, function:String, line:Int)  {
        
        #if DEBUG
            var message: NSString = "Data nil"
            if let dataValue = data {
               message = NSString(data: dataValue, encoding: NSUTF8StringEncoding)!
            }
            print("")
            print("+\(tag)+++++++++ : \(NSDate())")
            print("File : \(file)")
            print("Function : \(function)")
            print("Line : \(line)")
            print("Message : \(message)")
            print("----------")
            print("")
        #endif
    }
    
    class func writeLogString (tag: String, message: NSString, file:String = __FILE__, fnc:String = __FUNCTION__, line:(Int)=__LINE__)  {
        
        #if DEBUG
            print("")
            print("+\(tag)+++++++++ : \(NSDate())")
            print("File : \(file)")
            print("Function : \(fnc)")
            print("Line : \(line)")
            print("Message : \(message)")
            print("----------")
            print("")
        #endif
    }
    
    class func convertStringToDate(datestring: NSString, format: NSString, timezone: NSString, locale: NSString) -> NSDate{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format as String
        dateFormatter.timeZone = NSTimeZone(name: timezone as String)
        dateFormatter.locale = NSLocale(localeIdentifier: locale as String)
        return dateFormatter.dateFromString(datestring as String)!
    }
    
    class func convertDateToString(date: NSDate, format: NSString, timezone: NSString, locale: NSString) -> NSString{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format as String
        dateFormatter.timeZone = NSTimeZone(name: timezone as String)
        dateFormatter.locale = NSLocale(localeIdentifier: locale as String)
        return dateFormatter.stringFromDate(date)
    }
        
    class func downloadImage(urlstring: NSString, completion: ((data: NSData?) -> Void)) -> NSURLSessionDataTask? {
        
        if(urlstring == "") {
            completion(data: nil)
            return nil
        }
        let url: NSURL = NSURL(string: urlstring as String)!
        let sessionDataTask = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {
            (data, response, error) -> Void in
            
            dispatch_async(dispatch_get_main_queue()) {
                completion(data: NSData(data: data!))
            }
            
        })
        sessionDataTask.resume()
        return sessionDataTask
    }
    
    class func isValidEmail(testStr:String) -> Bool {
        let regex = try? NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$", options: .CaseInsensitive)
        return regex?.firstMatchInString(testStr, options: [], range: NSMakeRange(0, testStr.characters.count)) != nil
    }
    
    class func getCurrentVersionNumber() -> NSString {
        let mainBundle = NSBundle.mainBundle()
        let buildNumber: NSString = mainBundle.objectForInfoDictionaryKey("CFBundleVersion") as! NSString
        let versionNumber: NSString = mainBundle.objectForInfoDictionaryKey("CFBundleShortVersionString") as! NSString
        
        return NSString(format: "v.%@ (%@)", versionNumber , buildNumber)
    }
    
    class func setDropShadowOnBottom (view onview: UIView?, color: UIColor, radius: CGFloat, opacity: Float) {
        if let view = onview {
            view.layer.shadowColor = color.CGColor
            view.layer.shadowOffset = CGSizeMake(0, 1.0)
            view.layer.shadowOpacity = opacity
            view.layer.shadowRadius = radius
        }
    }
}
