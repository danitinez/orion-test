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
  
  
  func retrieveAndParseContacts( completionHandled:(NSArray?, NSError?)->Void ) {
    
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
        guard let json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSArray else {
          let error = NSError(domain: self.bundleId(), code: -1, userInfo: ["description":"No data on response"])
          completionHandled(nil, error)
          return
        }
        
        
        print(json)
        
      }
      catch let error as NSError {
        completionHandled(nil, error)
        return
      }
      
      
    }
    .resume()
    
  }
  
  
  private func bundleId() -> String {
    return NSBundle.mainBundle().bundleIdentifier!
  }
  
}