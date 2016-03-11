//
//  StartViewController.swift
//  ThankYou
//
//  Created by leig-imac on 16/3/9.
//  Copyright © 2016年 leig. All rights reserved.
//

import UIKit

struct UserInfo {
    var id: String
    var flag: String
    var key: String
}

struct SideMenu {
    var defaultteachername: String
    var headimg: String
    var defaultclassid: String
    var defaultclassname: String
    var classlist: [ClassInfo]
}

struct ClassInfo {
    var classid: String
    var classname: String
}

struct Student {
    var id: String
    var studentname: String
    var studentheadimg: String
}

struct ClassSeat {
    var classname: String
    var teachername: String
    var teacherheadimg: String
    var teachercount: String
    var studentcount: String
    var students: [Student]
}

var apiOperating = ApiOperating()

var userInfo = UserInfo(id: "", flag: "", key: "")

var sideMenu = SideMenu(defaultteachername: "", headimg: "", defaultclassid: "", defaultclassname: "", classlist: classList)

var classInfo = ClassInfo(classid: "", classname: "")

var classList: [ClassInfo] = []

var classSeat = ClassSeat(classname: "", teachername: "", teacherheadimg: "", teachercount: "", studentcount: "", students: students)

var student = Student(id: "", studentname: "", studentheadimg: "")

var students: [Student] = []

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
                userInfo.id = suid
                userInfo.flag = NSUserDefaults.standardUserDefaults().valueForKey("FLAG") as! String
                userInfo.key = NSUserDefaults.standardUserDefaults().valueForKey("KEY") as! String
                print(suid)
                self.performSegueWithIdentifier("StartGoFindSegue", sender: self)
                //获取老师侧滑菜单
                /*
                http://blog.csdn.net/qinlicang/article/details/42221585
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                // 耗时的操作
                dispatch_async(dispatch_get_main_queue(), ^{
                // 更新界面
                });
                });
                如果这样还不清晰的话，那我们还是用上两篇博客中的下载图片为例子，代码如下：
                [cpp] view plaincopy
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSURL * url = [NSURL URLWithString:@"http://avatar.csdn.net/2/C/D/1_totogo2010.jpg"];
                NSData * data = [[NSData alloc]initWithContentsOfURL:url];
                UIImage *image = [[UIImage alloc]initWithData:data];
                if (data != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{  
                self.imageView.image = image;  
                });  
                }  
                });
*/
                if let sideMenuData = apiOperating.getJsonDataByAsynchronous(apiOperating.SliderBarUrl, body: "suid") {
                    sideMenu.defaultteachername = sideMenuData["username"] as! String
                    sideMenu.headimg = sideMenuData["headimg"] as! String
                    sideMenu.defaultclassid = sideMenuData["classid"] as! String
                    sideMenu.defaultclassname = sideMenuData["classname"] as! String
                    let classInfoData: [NSDictionary] = sideMenuData["classlist"] as! [NSDictionary]
                    for temp in classInfoData {
                        classInfo.classid = temp["id"] as! String
                        classInfo.classname = temp["classname"] as! String
                        classList.append(classInfo)
                    }
                    sideMenu.classlist = classList
                }

                            /*for temp in jsonItem {
                            let id = temp["id"] as! String
                            //获取学生座位信息
                            let classInfoUrl = NSURL(string : apiOperating.ClassSeatUrl)!
                            let classInforequest: NSMutableURLRequest = NSMutableURLRequest(URL: classInfoUrl)
                            classInforequest.HTTPMethod = "POST"
                            classInforequest.HTTPBody = "uid=\(suid)&classid=\(id)".dataUsingEncoding(NSUTF8StringEncoding)
                            let classInfosession = NSURLSession.sharedSession()
                            let classInfotask = classInfosession.dataTaskWithRequest(classInforequest,
                            completionHandler: {(data, response, error) -> Void in
                            if error != nil{
                            print(error?.code)
                            print(error?.description)
                            }else{
                            let jsonData = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                            //print("Json Object:@@@@"); print(jsonData)
                            classInfo.classname = jsonData!["classname"] as! String
                            classInfo.teachername = jsonData!["teachername"] as! String
                            classInfo.teacherheadimg = jsonData!["teacherheadimg"] as! String
                            classInfo.teachercount = jsonData!["teachercount"] as! String
                            classInfo.studentcount = jsonData!["studentcount"] as! Int
                            let jsonItem: [NSDictionary] = jsonData!.objectForKey("studentinfo")! as! [NSDictionary]
                            for temp in jsonItem {
                            let sid = temp["id"] as! String
                            let studentname = temp["studentname"] as! String
                            let studentheadimg = temp["studentheadimg"] as! String
                            let student = Student(id: sid, studentname: studentname, studentheadimg: studentheadimg)
                            students.append(student)
                            }
                            classInfo.students = students
                            }
                            classList.append(classInfo)
                            }) as NSURLSessionTask
                            classInfotask.resume()
                            }
                            sideMenu.classlist = classList
                            print("====")
                            print(sideMenu)
                            //获取默认学生座位信息
                            let classSeatUrl = NSURL(string : apiOperating.ClassSeatUrl)!
                            let classSeatrequest: NSMutableURLRequest = NSMutableURLRequest(URL: classSeatUrl)
                            classSeatrequest.HTTPMethod = "POST"
                            classSeatrequest.HTTPBody = "uid=\(suid)&classid=\(classid)".dataUsingEncoding(NSUTF8StringEncoding)
                            let classSeatsession = NSURLSession.sharedSession()
                            let classSeattask = classSeatsession.dataTaskWithRequest(classSeatrequest,
                            completionHandler: {(data, response, error) -> Void in
                            if error != nil{
                            print(error?.code)
                            print(error?.description)
                            }else{
                            let jsonData = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                            //print("Json Object:"); print(jsonData)
                            classInfo.classname = jsonData!["classname"] as! String
                            classInfo.teachername = jsonData!["teachername"] as! String
                            classInfo.teacherheadimg = jsonData!["teacherheadimg"] as! String
                            classInfo.teachercount = jsonData!["teachercount"] as! String
                            classInfo.studentcount = jsonData!["studentcount"] as! Int
                            let jsonItem: [NSDictionary] = jsonData!.objectForKey("studentinfo")! as! [NSDictionary]
                            for temp in jsonItem {
                            let sid = temp["id"] as! String
                            let studentname = temp["studentname"] as! String
                            let studentheadimg = temp["studentheadimg"] as! String
                            let student = Student(id: sid, studentname: studentname, studentheadimg: studentheadimg)
                            students.append(student)
                            }
                            classInfo.students = students
                            }
                            }) as NSURLSessionTask
                            classSeattask.resume()
                            
                            }
                            }) as NSURLSessionTask
                            classmenutask.resume()
                            
                            */
                            

                
            } else {
                self.performSegueWithIdentifier("StartGoLoginSegue", sender: self)
            }
        }
        self.performSegueWithIdentifier("StartGoLoginSegue", sender: self)
    }
}
