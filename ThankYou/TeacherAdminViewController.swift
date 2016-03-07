//
//  TeacherAdminViewController.swift
//  ThankYou
//
//  Created by leig-imac on 16/3/7.
//  Copyright © 2016年 leig. All rights reserved.
//

import UIKit

class TeacherAdminViewController: UIViewController,UITableViewDataSource {
    
    @IBOutlet weak var teacherAdminTableView: UITableView!
    
    let teacherAdminList:[String] = ["个人信息","学习圈子","平台简介"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teacherAdminList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = teacherAdminTableView.dequeueReusableCellWithIdentifier("teacherAdminCell")! as UITableViewCell
        //let image = cell.viewWithTag(101) as! UIImage
        let title = cell.viewWithTag(102) as! UILabel
        //let prompt = cell.viewWithTag(103) as! UILabel
        title.text = teacherAdminList[indexPath.row]
        return cell
    }
}
