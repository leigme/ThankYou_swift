	//
//  TeacherFindViewController.swift
//  ThankYou
//
//  Created by leig-imac on 16/3/7.
//  Copyright © 2016年 leig. All rights reserved.
//

import UIKit

class TeacherFindViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var teacherFindTableView: UITableView!
    
    var teacherFindList: [String] = ["学校公告","学校活动","今日菜谱"]; 
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teacherFindList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.teacherFindTableView.dequeueReusableCellWithIdentifier("teacherFindCell")! as UITableViewCell
        let tfl = teacherFindList[indexPath.row]
        let title = cell.viewWithTag(101) as! UILabel
        title.text = tfl
        return cell
    }
    
}
