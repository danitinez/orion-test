//
//  ViewController.swift
//  OrionTest
//
//  Created by Daniel Martinez on 6/6/16.
//  Copyright © 2016 DM. All rights reserved.
//

import UIKit
import PKHUD
import CoreLocation

class DMMainScreenVC: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    HUD.show(.LabeledProgress(title: "Loading Contacts", subtitle: "Please wait..."))
    loadTestdata()
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  private func loadTestdata() {
    DMTestController.sharedInstance.retrieveAndParseContacts { (contacts, error) in
      HUD.hide()
      print(contacts)
      let  location: CLLocation
      location.coordinate
    }
  }
  
  
}

