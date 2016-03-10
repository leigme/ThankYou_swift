//
//  StartViewController.swift
//  ThankYou
//
//  Created by leig-imac on 16/3/9.
//  Copyright © 2016年 leig. All rights reserved.
//

import UIKit

struct ClassInfo {
    var cid: String
    var classname: String
}

struct ClassSeat {
    var classname: String
    var teachername: String
    var teacherheadimg: String
    var teachercount: String
    var studentcount: Int
    var students:[Student]
}

struct Student {
    var id: String
    var studentname: String
    var studentheadimg: String
}

var apiOperating = ApiOperating()

var classLists: [ClassInfo] = []

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
                print(suid)
                self.performSegueWithIdentifier("StartGoFindSegue", sender: self)
                
                //获取老师侧滑菜单
                let classmenuurl = NSURL(string : apiOperating.SliderBarUrl)!
                let classmenurequest: NSMutableURLRequest = NSMutableURLRequest(URL: classmenuurl)
                classmenurequest.HTTPMethod = "POST"
                classmenurequest.HTTPBody = "uid=\(suid)".dataUsingEncoding(NSUTF8StringEncoding)
                let classmenusession = NSURLSession.sharedSession()
                let classmenutask = classmenusession.dataTaskWithRequest(classmenurequest,
                    completionHandler: {(data, response, error) -> Void in
                        if error != nil{
                            print(error?.code)
                            print(error?.description)
                        }else{
                            let jsonData = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                            print("Json Object:"); print(jsonData)
                            let classInfo = ClassInfo(cid: jsonData!["classid"] as! String, classname: jsonData!["classname"] as! String)
                            print(classInfo.cid)
                            
                            classLists.append(classInfo)
                            let jsonItem: [NSDictionary] = jsonData!.objectForKey("classlist")! as! [NSDictionary]
                            for temp in jsonItem {
                                let id = temp["id"] as! String
                                let classname = temp["classname"] as! String
                                let classInfo = ClassInfo(cid: id, classname: classname)
                                classLists.append(classInfo)
                                print("++++++++")
                                //获取学生座位信息
                            }
                            print("====")
                            print(classLists)
                        }
                }) as NSURLSessionTask
                classmenutask.resume()
            } else {
                self.performSegueWithIdentifier("StartGoLoginSegue", sender: self)
            }
        }
        self.performSegueWithIdentifier("StartGoLoginSegue", sender: self)
    }
}
