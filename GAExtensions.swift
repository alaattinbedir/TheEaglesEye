//
//  GAExtensions.swift
//  EaglesEye
//
//  Created by Alaattin Bedir on 11/2/16.
//  Copyright © 2016 Magic Lump Games. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setScreeName(name: String) {
        self.title = name
        self.sendScreenView()
    }
    
    func sendScreenView() {
        let tracker = GAI.sharedInstance().defaultTracker
        tracker?.set(kGAIScreenName, value: self.title)
        let build = (GAIDictionaryBuilder.createScreenView().build() as NSDictionary) as! [AnyHashable: Any]
        tracker?.send(build)
    }
    
    func trackEvent(category: String, action: String, label: String, value: NSNumber?) {
        let tracker = GAI.sharedInstance().defaultTracker
        let trackDictionary = (GAIDictionaryBuilder.createEvent(withCategory: category, action: action, label: label, value: value).build() as NSDictionary) as! [AnyHashable: Any]
        
        tracker?.send(trackDictionary)
    }
    
}
