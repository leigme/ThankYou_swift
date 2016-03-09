//
//  PersonalViewController.swift
//  ThankYou
//
//  Created by leig-imac on 16/3/9.
//  Copyright © 2016年 leig. All rights reserved.
//

import UIKit

class PersonalViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bgBuleColor = UIColor(red: 38/255, green: 109/255, blue: 227/255, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = bgBuleColor
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.stackView.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBAction func okMenu(sender: AnyObject) {
        print("点击了菜单按钮！")
        self.stackView.hidden = false
        self.button1.setTitle("注销", forState: UIControlState.Normal)
        self.stackView.addSubview(button1)
    }

    @IBAction func okLogout(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setObject("", forKey: "UID")
        NSUserDefaults.standardUserDefaults().setObject("", forKey: "KEY")
        NSUserDefaults.standardUserDefaults().setObject("", forKey: "USER")
        NSUserDefaults.standardUserDefaults().setObject("", forKey: "PWD")
        NSUserDefaults.standardUserDefaults().setObject("", forKey: "FLAG")
        self.performSegueWithIdentifier("PersonalGoLogin", sender: self)
    }
    
}
