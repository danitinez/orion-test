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


class DMContactListVC: UIViewController {
  
  var contacts: Array<DMContact>?
  let tableView: UITableView = UITableView()
  var orderAlphabeticallyReversed: Bool = false;
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initializeUI()
    loadTestdata()
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  
  private func loadTestdata() {
    
    HUD.show(.LabeledProgress(title: NSLocalizedString("Loading Contacts", comment:""), subtitle: NSLocalizedString("Please wait...", comment:"")))
    DMTestController.sharedInstance.retrieveAndParseContacts { (contacts, error) in
      HUD.hide()
      self.contacts = contacts
      dispatch_async(dispatch_get_main_queue(), { 
        self.tableView.reloadData()
      })
    }
  
  }
  
}


extension DMContactListVC {
  
  func initializeUI() {
    
    view.backgroundColor = UIColor.lightGrayColor()
    self.navigationController?.navigationBar.tintColor = UIColor.blueColor()
    
    title = "Contacts"
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString(Constants.az, comment:""),
          style: UIBarButtonItemStyle.Plain, target: self, action: #selector(onOrderPressed))
    
    let table = self.tableView
    table.tableFooterView = UIView()
    table.dataSource = self
    table.delegate = self
    view.addSubview(table)
    table.snp_makeConstraints { (make) in
      make.edges.equalTo(self.view)
    }
    
  }
  
  func onOrderPressed() {
    orderAlphabeticallyReversed = !self.orderAlphabeticallyReversed
    navigationItem.rightBarButtonItem?.title = orderAlphabeticallyReversed ? Constants.za : Constants.az
    tableView.reloadData()
  }

  func orderedContacts(reverse:Bool) -> Array<DMContact>? {
    if let contacts = self.contacts {
      return reverse ? contacts.sort({$0.name > $1.name}) : contacts.sort({$0.name < $1.name})
    }
    return nil
  }
  
}


extension DMContactListVC : UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if let count = self.contacts?.count {
      return count
    } else {
      return 0
    }

  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier(Constants.cellId)
    if cell == nil {
      cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: Constants.cellId)
    }
    
    if let contacts = orderedContacts(orderAlphabeticallyReversed) {
      let contact = contacts[indexPath.row]
      cell!.textLabel?.text = contact.name
      cell!.detailTextLabel?.text = contact.email
    }
    
    return cell!
  }
  
}

extension DMContactListVC : UITableViewDelegate {
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    let contacts = orderedContacts(orderAlphabeticallyReversed)
    let selectedContact: DMContact = contacts![indexPath.row]
    showContactDetails(selectedContact)
  }
  
  func showContactDetails(contact: DMContact) {
    let detailVC = DMContactDetailVC(contact: contact)
    self.navigationController?.pushViewController(detailVC, animated: true)
//    detailVC.
  }

}

struct Constants {
  static let az = "A...Z"
  static let za = "Z...A"
  static let cellId = "contactCellId"
}