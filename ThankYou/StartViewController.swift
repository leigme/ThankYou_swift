//
//  StartViewController.swift
//  ThankYou
//
//  Created by leig-imac on 16/3/9.
//  Copyright © 2016年 leig. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let uid = NSUserDefaults.standardUserDefaults().valueForKey("UID") {
            let suid = uid as! String
            if suid != "" {
                self.performSegueWithIdentifier("StartGoFindSegue", sender: self)
                print(suid)
            } else {
                self.performSegueWithIdentifier("StartGoLoginSegue", sender: self)
            }
        }
        self.performSegueWithIdentifier("StartGoLoginSegue", sender: self)
    }
}
