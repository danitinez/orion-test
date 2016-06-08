//
//  DMContactDetailVC.swift
//  OrionTest
//
//  Created by Daniel Martinez on 6/7/16.
//  Copyright © 2016 DM. All rights reserved.
//

import UIKit
import SnapKit
import MapKit

class DMContactDetailVC: UIViewController {
  
  var contact:DMContact?
  
  private var lastView: UIView?
  
  convenience init(contact: DMContact) {
    self.init(nibName:nil, bundle:nil)
    self.contact = contact
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initializeUI()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  
  func initializeUI() {
    
    self.view.backgroundColor = UIColor.whiteColor()
    
    self.title = contact!.name
    //Add view items
    //Username
    if let username = contact?.username {
      addItem("Username", body: username)
      
    }
    
    if let phone = contact?.phone {
      addItem("Phone", body: phone)
    }
    
    if let address = contact?.address?.description {
      addItem("Address", body: address)
    }
    
    if let website = contact?.website {
      addItem("Website", body: website)
    }
    
    if let company = contact?.company?.description {
      addItem("Company", body: company)
    }
    
    //Location point are not configured on fake data
    
//    if let geo = contact?.address?.geo {
//      let map = MKMapView()
//      let span = MKCoordinateSpanMake(0.5, 0.5)
//      let region = MKCoordinateRegion(center: geo, span: span)
//      map.setRegion(region, animated: false)
//      let annotation = MKPointAnnotation()
//      annotation.coordinate = geo
//      map.addAnnotation(annotation)
//      
//      self.view.addSubview(map)
//      map.snp_makeConstraints(closure: { (make) in
//        make.left.equalTo(self.view).offset(5)
//        make.top.equalTo(lastView!.snp_bottom).offset(30)
//        make.right.equalTo(self.view).offset(-30)
//        make.height.equalTo(150)
//      })
//    }
    
    
  }
  
  
  func addItem(title:String, body:String){
    let view = DMInfoView(title: title, body: body, superview:self.view)
    self.view.addSubview(view)
    
    var constraintItem: ConstraintItem
    if let lastView = lastView {
      constraintItem = lastView.snp_bottom
    }
    else {
      constraintItem = self.snp_topLayoutGuideBottom
    }
    
    view.snp_makeConstraints { (make) in
      make.left.equalTo(self.view.snp_left)
      make.right.equalTo(self.view.snp_right)
      make.top.equalTo(constraintItem).offset(20)
    }
    
    lastView = view
  }
  
}

class DMInfoView: UIView {
  
  let lblTitle: UILabel = UILabel()
  let lblBody:  UILabel = UILabel()
  
  convenience init(title:String, body:String, superview:UIView) {
    self.init()
    
    self.addSubview(lblTitle)
    lblTitle.font = UIFont.boldSystemFontOfSize(16)
    lblTitle.textColor = UIColor.grayColor()
    lblTitle.text = title;
    lblTitle.snp_makeConstraints { (make) in
      make.left.equalTo(self.snp_left).offset(10)
      make.top.equalTo(self.snp_top)
    }
    
    lblBody.lineBreakMode = NSLineBreakMode.ByWordWrapping
    lblBody.numberOfLines = 0
    lblBody.font = UIFont.systemFontOfSize(13)
    lblBody.textColor = UIColor.blackColor()
    lblBody.preferredMaxLayoutWidth = superview.frame.size.width
    lblBody.text = body
    self.addSubview(lblBody)
    lblBody.snp_makeConstraints { (make) in
      make.left.equalTo(self.snp_left).offset(15)
      make.top.equalTo(lblTitle.snp_bottom).offset(4)
      make.right.equalTo(self.snp_right)
      make.bottom.equalTo(self.snp_bottom)
    }
    
    
  }
  
}