//
//  FindViewController.swift
//  ThankYou
//
//  Created by leig-imac on 16/3/9.
//  Copyright © 2016年 leig. All rights reserved.
//

import UIKit

class FindViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bgBuleColor = UIColor(red: 38/255, green: 109/255, blue: 227/255, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = bgBuleColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let tapGR = UITapGestureRecognizer(target: self, action: "tapHandler:")
        self.view.addGestureRecognizer(tapGR)
    }
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBAction func okMenu(sender: AnyObject) {
        print("点击了发现按钮菜单！")
    }
    
    @IBAction func okButton1(sender: AnyObject) {
        print("点击了发现按钮1")
    }
  
    func tapHandler(sender: UIPanGestureRecognizer) {
        self.stackView.hidden = true
    }
}
