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
        let button1 = UIButton(frame:CGRectMake(0, 0, 60,30))
        button1.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        button1.setTitle("注销按钮！", forState: UIControlState.Normal)
        button1.addTarget(self, action: "okLogout:", forControlEvents: UIControlEvents.TouchUpInside)
        self.stackView.addSubview(button1)
        //let tapGR = UITapGestureRecognizer(target: self, action: "tapHandler:")
        //self.view.addGestureRecognizer(tapGR)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBAction func okMenu(sender: AnyObject) {
        print("点击了个人菜单按钮！")
        self.stackView.hidden = false
    }
    
    func okLogout(sender: UIButton) {
        //测试按钮响应
        print("点击了注销按钮！！")
        /*
        NSUserDefaults.standardUserDefaults().setObject("", forKey: "UID")
        NSUserDefaults.standardUserDefaults().setObject("", forKey: "KEY")
        NSUserDefaults.standardUserDefaults().setObject("", forKey: "USER")
        NSUserDefaults.standardUserDefaults().setObject("", forKey: "PWD")
        NSUserDefaults.standardUserDefaults().setObject("", forKey: "FLAG")
        self.performSegueWithIdentifier("PresonalGoLoginSegue", sender: self)
*/
    }
    
    func tapHandler(sender: UITapGestureRecognizer) {
        self.stackView.hidden = true
    }
    
    @IBAction func goWay(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setObject("", forKey: "UID")
        NSUserDefaults.standardUserDefaults().setObject("", forKey: "KEY")
        NSUserDefaults.standardUserDefaults().setObject("", forKey: "USER")
        NSUserDefaults.standardUserDefaults().setObject("", forKey: "PWD")
        NSUserDefaults.standardUserDefaults().setObject("", forKey: "FLAG")
        self.performSegueWithIdentifier("PresonalGoLoginSegue", sender: self)
    }
    
    
}
