//
//  ViewController.swift
//  ThankYou
//
//  Created by leig-imac on 16/3/3.
//  Copyright © 2016年 leig. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate, UITextViewDelegate {
    
    //控件获取账号
    @IBOutlet weak var username: UITextField!
    
    //控件获取密码
    @IBOutlet weak var password: UITextField!
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    var apiurl = ApiUrl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        password.secureTextEntry = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        username.resignFirstResponder()
        password.resignFirstResponder()
    }
    
    //修改密码跳转页面方法
    @IBAction func forgetpassword(sender: AnyObject) {
        if let url = NSURL(string:"http://www.k12chn.com/m00/ForgetPassword/Index") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    //登录JSON服务器后台响应
    func login(user: String , pwd: String) -> Bool {
        var loginResponse = ApiLoginResponse()
        let body = "user=\(user)&pwd=\(pwd)"
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
        if loginResponse.Uid == "" {
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
                    result = false
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
                    result = true
                }
            }) as NSURLSessionTask
        task.resume()
        */
    }
    
    //登录判断跳转页面方法
    @IBAction func oklogin(sender: AnyObject) {
        let uiuser : String = username.text!
        let uipwd : String = password.text!
        if uiuser != "" && uipwd != "" {
            if login(uiuser,pwd: uipwd) {
                self.performSegueWithIdentifier("login", sender: self)
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

