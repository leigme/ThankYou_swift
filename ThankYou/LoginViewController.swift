
//
//  LoginViewController.swift
//  ThankYou
//
//  Created by leig-imac on 16/3/9.
//  Copyright © 2016年 leig. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"侧栏背景1080-1920.jpg")!)
        username.placeholder = "请输入账号"
        password.secureTextEntry = true
        password.placeholder = "请输入密码"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    let apiurl = ApiOperating()
    var loginResponse = ApiLoginResponse()
    
    @IBAction func okLogin(sender: AnyObject) {
        if let name = username.text {
            if name == "" {
                print("请您填写账号！")
            } else {
                if let pwd = password.text {
                    if pwd == "" {
                        print("请您填写密码！")
                    } else {
                        if login(name, Pwd: pwd) {
                            self.performSegueWithIdentifier("LoginGoFindSegue", sender: self)
                            print(login(name, Pwd: pwd))
                        } else {
                            print("账号或密码错误！")
                        }
                    }
                }
            }
        }
    }
    
    //登录功能JSON请求
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
                    NSUserDefaults.standardUserDefaults().setObject(uid, forKey: "UID")
                    NSUserDefaults.standardUserDefaults().setObject(key, forKey: "KEY")
                    NSUserDefaults.standardUserDefaults().setObject(user, forKey: "USER")
                    NSUserDefaults.standardUserDefaults().setObject(pwd, forKey: "PWD")
                    NSUserDefaults.standardUserDefaults().setObject(flag, forKey: "FLAG")
                    self.loginResponse.Uid = uid
                    self.loginResponse.Key = key
                    self.loginResponse.User = user
                    self.loginResponse.Pwd = pwd
                    self.loginResponse.Flag = flag
                } else {
                    print("服务器没有返回JSON对象！")
                }
            }
            dispatch_semaphore_signal(semaphore)
        }) as NSURLSessionTask
        dataTask.resume()
        dispatch_semaphore_wait(semaphore,DISPATCH_TIME_FOREVER)
        print("数据加载完毕！")
        if self.loginResponse.Uid == "" {
            return false
        } else {
            return true
        }
    }
}