//
//  ViewController.swift
//  ThankYou
//
//  Created by leig-imac on 16/3/3.
//  Copyright © 2016年 leig. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //账号控件
    @IBOutlet weak var nameField: UITextField!
    //密码控件
    @IBOutlet weak var pwdField: UITextField!

    struct ApiLoginResponse {
        var Uid : String
        var Key : String
        var User : String
        var Pwd : String
        var Flag : String
        
        init () {
            Uid = ""
            Key = ""
            User = ""
            Pwd = ""
            Flag = ""
        }
    }
    
    let SUser = "username"
    let SUid = "uid"
    let SPwd = "pwd"
    let SKey = "key"
    let SFlag = "flag"
    let IsFirstLaunch = "ifl"
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    var apiurl = ApiOperating()
    var loginResponse = ApiLoginResponse()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let ifl = NSUserDefaults.standardUserDefaults().valueForKey("IsFirstLaunch") {
            print(ifl)
            if let sflag = NSUserDefaults.standardUserDefaults().valueForKey("SFlag") {
                let s : String = sflag as! String
                print(s)
                switch s {
                case "teacher" : self.performSegueWithIdentifier("loginTeacher", sender: self)
                case "student" : self.performSegueWithIdentifier("loginStudent", sender: self)
                case "parent" : self.performSegueWithIdentifier("loginParent", sender: self)
                default : "登录跳转失败！"
                }
            }
        }
        pwdField.secureTextEntry = true
        /*
        self.nameField.text =
            NSUserDefaults.standardUserDefaults().valueForKey("user") as! String!
        self.pwdField.text = NSUserDefaults.standardUserDefaults().valueForKey("pwd") as! String!
        self.rmbField.on = NSUserDefaults.standardUserDefaults().boolForKey("rmb") as Bool!
        if (self.rmbField.on){
            self.pwdField.text = NSUserDefaults.standardUserDefaults().valueForKey("pwd") as! String!
        }
        
        //判断是否第一次启动：
        if((NSUserDefaults.standardUserDefaults().boolForKey("IsFirstLaunch") as Bool!) == false){
            //第一次启动，播放引导页面
            print("第一次启动")
            //设置为非第一次启动
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "IsFirstLaunch")
        }else{
            print("不是第一次启动")
            self.performSegueWithIdentifier("login", sender: self)
        }
*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        nameField.resignFirstResponder()
        pwdField.resignFirstResponder()
    }
    
    //修改密码跳转页面方法
    @IBAction func forgetpassword(sender: AnyObject) {
        if let url = NSURL(string:"http://www.k12chn.com/m00/ForgetPassword/Index") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    //登录JSON服务器后台响应
    func login(User : String, Pwd : String) -> Bool {
        
        let body = "user=\(User)&pwd=\(Pwd)"
        let url = NSURL(string : apiurl.LoginUrl)!
        let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
        print(body)
        
        //var response : NSURLResponse?
        //同步请求
        
        let session = NSURLSession.sharedSession()
        let semaphore = dispatch_semaphore_create(0)
        let dataTask = session.dataTaskWithRequest(request,completionHandler:{(data,response,error)->Void in
            if error != nil {
                print(error?.code)
                print(error?.description)
            } else {
                let jsonData: AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                if jsonData != nil {
                    print("Json Object:"); print(jsonData)
                    let uid: String = jsonData.objectForKey("uid")! as! String
                    let key: String = jsonData.objectForKey("key")! as! String
                    let user: String = jsonData.objectForKey("user")! as! String
                    let pwd: String = jsonData.objectForKey("pwd")! as! String
                    let flag: String = jsonData.objectForKey("flag")! as! String
                    self.loginResponse.Uid = uid
                    self.loginResponse.Key = key
                    self.loginResponse.User = user
                    self.loginResponse.Pwd = pwd
                    self.loginResponse.Flag = flag
                } else {
                    print("======")
                }
        
            }
            dispatch_semaphore_signal(semaphore)
        }) as NSURLSessionTask
        dataTask.resume()
        dispatch_semaphore_wait(semaphore,DISPATCH_TIME_FOREVER)
        print("数据加载完毕！")
        
        /*
        do{
            let data : NSData? = try NSURLConnection.sendSynchronousRequest(request,
            returningResponse: &response)
                let jsonData: AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
            if jsonData != nil {
                print("Json Object:"); print(jsonData)
                let uid: String = jsonData.objectForKey("uid")! as! String
                let key: String = jsonData.objectForKey("uid")! as! String
                let user: String = jsonData.objectForKey("uid")! as! String
                let pwd: String = jsonData.objectForKey("uid")! as! String
                let flag: String = jsonData.objectForKey("uid")! as! String
                loginResponse.Uid = uid
                loginResponse.Key = key
                loginResponse.User = user
                loginResponse.Pwd = pwd
                loginResponse.Flag = flag
            } else {
                print("=====")
            }
        }catch let error as NSError{
            //打印错误消息
            print(error.code)
            print(error.description)
        }
        */
        if self.loginResponse.Uid == "" {
            return false
        } else {
            return true
        }
        /* 异步请求
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
                        let uid: String = jsonData.objectForKey("uid")! as! String
                        let key: String = jsonData.objectForKey("uid")! as! String
                        let user: String = jsonData.objectForKey("uid")! as! String
                        let pwd: String = jsonData.objectForKey("uid")! as! String
                        let flag: String = jsonData.objectForKey("uid")! as! String
                    print(uid)
                        loginResponse.Uid = uid
                        loginResponse.Key = key
                        loginResponse.User = user
                        loginResponse.Pwd = pwd
                        loginResponse.Flag = flag
                    print(loginResponse.Uid)
                }
            }) as NSURLSessionTask
        task.resume()
        */
    }
    
    //登录判断跳转页面方法
    @IBAction func oklogin(sender: AnyObject) {
        let user : String = nameField.text!
        let pwd : String = pwdField.text!
        if user != "" && pwd != "" {
            if login(user, Pwd:pwd) {

                    NSUserDefaults.standardUserDefaults().setObject(self.loginResponse.User, forKey: "SUser")
                    NSUserDefaults.standardUserDefaults().setObject(self.loginResponse.Uid, forKey: "SUid")
                    NSUserDefaults.standardUserDefaults().setObject(self.loginResponse.Pwd, forKey: "SPwd")
                    NSUserDefaults.standardUserDefaults().setObject(self.loginResponse.Key, forKey: "SKey")
                    NSUserDefaults.standardUserDefaults().setObject(self.loginResponse.Flag, forKey: "SFlag")
                    NSUserDefaults.standardUserDefaults().setObject(self.IsFirstLaunch, forKey: "IsFirstLaunch")
           

                /*
                if rmbField.on == true {
                    print("rmbSwitch选定！")
                //设置用户登录信息存储在NSUserDefaultslet SUser = "username"
                let SUid = "uid"
                let SPwd = "pwd"
                let SKey = "key"
                let SFlag = "flag"
                let IsFirstLaunch = "ifl"
                    NSUserDefaults.standardUserDefaults().setObject(self.nameField.text, forKey: "NameKey")
                    NSUserDefaults.standardUserDefaults().setObject(self.pwdField.text, forKey: "PwdKey")
                    NSUserDefaults.standardUserDefaults().setObject(self.rmbField.on, forKey: "RmbKey")
                    //设置同步
                    NSUserDefaults.standardUserDefaults().synchronize()
                }
                */
                //构建用户角色菜单Cell
                print(self.loginResponse.Flag)
                switch self.loginResponse.Flag {
                case "teacher" : self.performSegueWithIdentifier("loginTeacher", sender: self)
                case "student" : self.performSegueWithIdentifier("loginStudent", sender: self)
                case "parent" : self.performSegueWithIdentifier("loginParent", sender: self)
                default : "登录跳转失败！"
                }
            } else {
                let alertController = UIAlertController(title: "系统提示",
                    message: "您的账号或者密码错误！", preferredStyle: .Alert)
                let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
                /*
                let okAction = UIAlertAction(title: "好的", style: .Default,
                    handler: {
                        action in
                })
                */
                alertController.addAction(cancelAction)
               // alertController.addAction(okAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        } else {
            let alertController = UIAlertController(title: "系统提示",
                message: "请您的填写账号和密码！", preferredStyle: .Alert)
            //let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
            let okAction = UIAlertAction(title: "好的", style: .Default,
                handler: {
                    action in
            })
            //alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
}

