//
//  DMTestController.swift
//  OrionTest
//
//  Created by Daniel Martinez on 6/6/16.
//  Copyright © 2016 DM. All rights reserved.
//

import Foundation

public class DMTestController {
  
  static var sharedInstance = DMTestController()
  
  
  /// Retrieve data from server, parse it and returns an array of contacts
  func retrieveAndParseContacts( completionHandled:(Array<DMContact>?, NSError?)->Void ) {
    
    let endpointUrl = NSURL(string: "http://jsonplaceholder.typicode.com/users")
    
    NSURLSession.sharedSession().dataTaskWithURL(endpointUrl!) { ( data, response, error) in
    
      if let error = error {
        completionHandled(nil, error)
        return
      }
      
      guard let data = data else {
        let error = NSError(domain: self.bundleId(), code: -1, userInfo: ["description":"No data on response"])
        completionHandled(nil, error)
        return
      }
      
      do {
        let json = try NSJSONSerialization.JSONObjectWithData(data, options: [])
        
        if let jsonArray = json as? NSArray {
          let contacts: Array<DMContact> = jsonArray.flatMap {DMContact(dictionary:$0 as! NSDictionary)}
          completionHandled(contacts, nil)
        }
        else if let jsonDict = json as? NSDictionary, contact = DMContact(dictionary:jsonDict) {
          let contacts: Array<DMContact> = [contact]
          completionHandled(contacts, nil)
        }
        
      }
      catch let error as NSError {
        completionHandled(nil, error)
      }
      
    }
    .resume()
    
  }
  
  
  private func bundleId() -> String {
    return NSBundle.mainBundle().bundleIdentifier!
  }
  
}