//
//  DMContact.swift
//  OrionTest
//
//  Created by Daniel Martinez on 6/6/16.
//  Copyright © 2016 DM. All rights reserved.
//

import Foundation
import CoreLocation

struct DMContact {
  
  let id: Int
  let firstName: String
  let lastName: String?
  let email: String?
  let username: String?
  let phone: String?
  let website: String?
  let address: DMAddress?
  let company: DMCompany?
  
  init?(dictionary: NSDictionary) {
    
    if let id = dictionary["id"], firstName = dictionary["firstName"] {
      self.id = id as! Int
      self.firstName = firstName as! String
    } else {
      return nil
    }
    
    lastName = dictionary["lastName"] as? String
    email = dictionary["email"] as? String
    username = dictionary["username"] as? String
    phone = dictionary["phone"] as? String
    website = dictionary["website"] as? String
    
    address = DMAddress(dictionary: dictionary["address"] as? NSDictionary)
    company = DMCompany(dictionary: dictionary["company"] as? NSDictionary)
  }
}

struct DMAddress {
  let street: String
  let suit: String?
  let city: String?
  let zipcode: String?
  let geo: CLLocationCoordinate2D?
  
  init?(dictionary: NSDictionary?) {
    guard let dictionary = dictionary, street = dictionary["street"] else {
      return nil
    }
    
    self.street = street as! String
    self.suit = dictionary["suit"] as? String
    self.city = dictionary["city"] as? String
    self.zipcode = dictionary["zipcode"] as? String
    
    if let geo = dictionary["geo"], lat = geo["lat"], lng = geo["lng"] {
      self.geo = CLLocationCoordinate2D(latitude: lat as! Double, longitude: lng as! Double)
    }else{
      self.geo = nil
    }
  }
  
}

struct DMCompany {
  let name: String
  let catchPhrase: String?
  let bs: String?
  
  init?(dictionary: NSDictionary?) {
    guard let dictionary = dictionary, name = dictionary["name"] else {
      return nil
    }
    self.name = name as! String
    catchPhrase = dictionary["catchPhrase"] as? String
    bs = dictionary["bs"] as? String
  }
  
}