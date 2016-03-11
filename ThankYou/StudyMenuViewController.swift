//
//  FindMenuViewController.swift
//  ThankYou
//
//  Created by leig-imac on 16/3/10.
//  Copyright © 2016年 leig. All rights reserved.
//

import UIKit

class StudyMenuViewController: UIViewController,UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clearColor()
        self.stackView1.backgroundColor = UIColor.clearColor()
        self.stackView2.backgroundColor = UIColor.clearColor()
        self.view3.backgroundColor = UIColor.clearColor()
        self.menuTableView.backgroundColor = UIColor.clearColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"SidebarBackground.jpg")!)
        if let url: NSURL = NSURL(string: sideMenu.headimg) {
            print(url)
            if let data: NSData = NSData(contentsOfURL: url) {
                let image = UIImage(data: data, scale: 1.0)
                defaultHeadImg = UIImageView(image: image)
            }
            print("没有头像！")
        }
        print("开始打印")
        print(classList)
        print("结束打印")
        userName.text = sideMenu.defaultteachername
        defaultClassName.text = sideMenu.defaultclassname
        
        let body = "uid=\(userInfo.id)&classid=\(sideMenu.defaultclassid)"
        if let classSeatData = apiOperating.getJsonDataByAsynchronous(apiOperating.ClassSeatUrl, body: body) {
            classSeat.classname = classSeatData["classname"] as! String
            classSeat.teachername = classSeatData["teachername"] as! String
            classSeat.teacherheadimg = classSeatData["teacherheadimg"] as! String
            classSeat.studentcount = String(classSeatData["studentcount"] as! Int)
            let jsonItme: [NSDictionary] = classSeatData["studentinfo"] as! [NSDictionary]
            for temp in jsonItme {
                student.id = temp["id"] as! String
                student.studentname = temp["studentname"] as! String
                student.studentheadimg = temp["studentheadimg"] as! String
                students.append(student)
            }
            classSeat.students = students
            self.viewDidLoad()
        }
        
    }
    
    @IBOutlet weak var stackView1: UIStackView!
    
    @IBOutlet weak var stackView2: UIStackView!
    
    @IBOutlet weak var view3: UIView!
 
    @IBOutlet weak var menuTableView: UITableView!
    
    @IBOutlet weak var defaultHeadImg: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var defaultClassName: UILabel!
    
    struct sidebar {
        var cid: String
        var classname: String
    }
    
    let cls: [ClassInfo] = sideMenu.classlist
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cls.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.menuTableView.dequeueReusableCellWithIdentifier("StudyMenuCell")! as UITableViewCell
        let cl = cls[indexPath.row]
        let title = cell.viewWithTag(101) as! UILabel
        title.text = cl.classname
        return cell
    }
}
