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
  let tableView: UITableView = UITableView()
  var orderAlphabeticallyReversed: Bool = false;
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initializeUI()
    HUD.show(.LabeledProgress(title: "Loading Contacts", subtitle: "Please wait..."))
    loadTestdata()
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  
  private func loadTestdata() {
    
    DMTestController.sharedInstance.retrieveAndParseContacts { (contacts, error) in
      HUD.hide()
      self.contacts = contacts
      
      dispatch_async(dispatch_get_main_queue(), { 
        self.tableView.reloadData()
      })
      
    }
  }
  
}


extension DMMainScreenVC {
  
  func initializeUI() {
    
    view.backgroundColor = UIColor.lightGrayColor()
    
    title = "Contacts"
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("A...Z", comment:""),
          style: UIBarButtonItemStyle.Plain, target: self, action: #selector(onOrderPressed))
    
    let table = self.tableView
    table.tableFooterView = UIView()
    table.dataSource = self
    view.addSubview(table)
    table.snp_makeConstraints { (make) in
      make.edges.equalTo(self.view)
    }
    
  }
  
  func onOrderPressed() {
    orderAlphabeticallyReversed = !self.orderAlphabeticallyReversed
    navigationItem.rightBarButtonItem?.title = orderAlphabeticallyReversed ? "A...Z" : "Z...A"
    tableView.reloadData()
  }
  
}


extension DMMainScreenVC : UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if let count = self.contacts?.count {
      return count
    } else {
      return 0
    }

  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("contactCellId")
    if cell == nil {
      cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "contactCellId")
    }
    
    if let contacts = orderedContacts(orderAlphabeticallyReversed) {
      let contact = contacts[indexPath.row]
      cell!.textLabel?.text = contact.name
      cell!.detailTextLabel?.text = contact.email
    }
    
    return cell!
  }
  
  func orderedContacts(reverse:Bool) -> Array<DMContact>? {
    if let contacts = self.contacts {
      return reverse ? contacts.sort({$0.name > $1.name}) : contacts.sort({$0.name < $1.name})
    }
    return nil
  }
  
}