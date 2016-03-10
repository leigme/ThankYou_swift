//
//  StudyViewController.swift
//  ThankYou
//
//  Created by leig-imac on 16/3/9.
//  Copyright © 2016年 leig. All rights reserved.
//

import UIKit

class StudyHomeViewController: UIViewController{
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var seatCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bgBuleColor = UIColor(red: 38/255, green: 109/255, blue: 227/255, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = bgBuleColor
//        self.getStudents()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.stackView.hidden = true
        self.seatCollectionView.backgroundColor = UIColor.clearColor()
    }
    
    @IBOutlet weak var rightItme: UIButton!
    
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
    
    //发送班级请求获取JSON对象
    /*
    func getStudents() {
        let apiurl = ApiOperating()
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
*/
}
