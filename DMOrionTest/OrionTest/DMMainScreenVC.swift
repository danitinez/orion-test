//
//  ViewController.swift
//  OrionTest
//
//  Created by Daniel Martinez on 6/6/16.
//  Copyright © 2016 DM. All rights reserved.
//

import UIKit
import PKHUD
import SnapKit
import CoreLocation

class DMMainScreenVC: UIViewController {
  
  var contacts: Array<DMContact>?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.lightGrayColor()
    initializeUI()
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
      self.contacts = contacts
    }
  }
  
}

extension DMMainScreenVC {
  
  func initializeUI() {
    
    self.title = "Contacts"
    
    let table = UITableView()
    self.view.addSubview(table)
    table.snp_makeConstraints { (make) in
      make.edges.equalTo(self.view)
    }
    
  }
  
}