//
//  MyViewController.swift
//  ThankYou
//
//  Created by leig-imac on 16/3/4.
//  Copyright © 2016年 leig. All rights reserved.
//

import UIKit

class MyViewController: UIViewController,UITableViewDataSource {
    
    @IBOutlet weak var mytableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.mytableview.dequeueReusableCellWithIdentifier("FriendCircleCell")! as UITableViewCell
        return cell
    }
}
