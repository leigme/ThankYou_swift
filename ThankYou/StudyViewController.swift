//
//  StudyViewController.swift
//  ThankYou
//
//  Created by leig-imac on 16/3/9.
//  Copyright © 2016年 leig. All rights reserved.
//

import UIKit

class StudyViewController: UIViewController{
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet weak var button3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bgBuleColor = UIColor(red: 38/255, green: 109/255, blue: 227/255, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = bgBuleColor
        self.getStudents()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.stackView.hidden = true
    }
    
    @IBOutlet weak var rightItme: UIButton!
    
    @IBAction func okRightItme(sender: AnyObject) {
        self.view.backgroundColor = UIColor.redColor()
        self.stackView.hidden = false
        self.button1.setTitle("班级课表", forState: UIControlState.Normal)
        self.button2.setTitle("班级通知", forState: UIControlState.Normal)
        self.button3.setTitle("家长留言", forState: UIControlState.Normal)
        self.stackView.addSubview(button1)
        self.stackView.addSubview(button2)
        self.stackView.addSubview(button3)
    }
    
    //发送班级请求获取JSON对象
    func getStudents() {
        let apiurl = ApiUrl()
        // 异步请求
        let UID = NSUserDefaults.standardUserDefaults().valueForKey("UID")
        //let CLASSID = NSUserDefaults.standardUserDefaults().valueForKey("")
        let body = "uid=\(UID)&classid=3023"
        let url = NSURL(string : apiurl.ClassSeatUrl)!
        let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request,
        completionHandler: {(data, response, error) -> Void in
        if error != nil{
        print(error?.code)
        print(error?.description)
        }else{
        /*
        let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
        print(str)
        */
        let jsonData: AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
        print("Json Object:"); print(jsonData)
            
        }
        }) as NSURLSessionTask
        task.resume()
    }
}
