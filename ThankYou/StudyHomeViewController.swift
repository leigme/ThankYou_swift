//
//  StudyViewController.swift
//  ThankYou
//
//  Created by leig-imac on 16/3/9.
//  Copyright © 2016年 leig. All rights reserved.
//

import UIKit

class StudyHomeViewController: UIViewController,UICollectionViewDataSource {
    
    @IBOutlet weak var stackView: UIStackView!
    var pjd: NSData = NSData()
    override func viewDidLoad() {
        super.viewDidLoad()
        let bgBuleColor = UIColor(red: 38/255, green: 109/255, blue: 227/255, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = bgBuleColor
        let body: String = "uid=3237&classid=3023"
        if let jd = apiOperating.getJsonDataByAsynchronous(apiOperating.ClassSeatUrl, body: body){
            print(jd)
            print("+++++")
            pjd = jd as! NSData
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.stackView.hidden = true
        self.studentCollectionView.showsHorizontalScrollIndicator = false
        self.studentCollectionView.showsVerticalScrollIndicator = false
       // self.seatCollectionView.backgroundColor = UIColor.clearColor()
        if let url: NSURL = NSURL(string: classSeat.teacherheadimg) {
            if let data: NSData = NSData(contentsOfURL: url) {
                let image = UIImage(data: data, scale: 1.0)
                teacherHeadImg = UIImageView(image: image)
            }
        }
        className.text = classSeat.classname
        teacherName.text = classSeat.teachername
        teacherNum.text = classSeat.teachercount
        studentNum.text = classSeat.studentcount
        print("========")
        print(pjd)
    }
    
    let students: [Student] = classSeat.students
    
    @IBOutlet weak var studentCollectionView: UICollectionView!
    @IBOutlet weak var rightItme: UIButton!
    
    @IBOutlet weak var teacherHeadImg: UIImageView!
    
    @IBOutlet weak var className: UILabel!
    
    @IBOutlet weak var teacherName: UILabel!
    
    @IBOutlet weak var teacherNum: UILabel!
    
    @IBOutlet weak var studentNum: UILabel!
    
    @IBAction func okRightItme(sender: AnyObject) {
        self.view.backgroundColor = UIColor.redColor()
        self.stackView.hidden = false
        let button1 = UIButton(frame:CGRectMake(0, 0, 80,30))
        let button2 = UIButton(frame:CGRectMake(0, 35, 80,30))
        let button3 = UIButton(frame:CGRectMake(0, 70, 80,30))
        button1.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        button2.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        button3.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        button1.setTitle("班级课表", forState: UIControlState.Normal)
        button2.setTitle("班级通知", forState: UIControlState.Normal)
        button3.setTitle("家长留言", forState: UIControlState.Normal)
        self.stackView.addSubview(button1)
        self.stackView.addSubview(button2)
        self.stackView.addSubview(button3)
        print("点击了班级菜单按钮！")
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return students.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = studentCollectionView.dequeueReusableCellWithReuseIdentifier("CollectionCell", forIndexPath: indexPath)
        let headImg = cell.viewWithTag(101) as! UIImageView
        let name = cell.viewWithTag(102) as! UILabel
        name.text = students[indexPath.row].studentname
        if let url: NSURL = NSURL(string: students[indexPath.row].studentheadimg) {
            if let data: NSData = NSData(contentsOfURL: url) {
                let image = UIImage(data: data, scale: 1.0)
                headImg.image = apiOperating.ResizeImage(image!, targetSize: CGSizeMake(80.0, 80.0))
            }
        }
        return cell
    }
}
