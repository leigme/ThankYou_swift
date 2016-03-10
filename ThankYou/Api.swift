//
//  ApiUrl.swift
//  ThankYou
//
//  Created by leig-imac on 16/3/3.
//  Copyright © 2016年 leig. All rights reserved.
//

import UIKit

struct ApiOperating {
    
    let ServerIP: String
    let LoginUrl : String
    let FriendCircleUrl : String
    let UserInfoUrl : String
    
    let ClassSeatUrl : String
    let FriendListUrl : String
    let SliderBarUrl : String
    
    init() {
        ServerIP = "http://192.168.0.139/"
        LoginUrl =  ServerIP + "edu/m17/Login/Index"
        
        UserInfoUrl = ServerIP + "edu/m17/UserInfo/Index"
        
        SliderBarUrl = ServerIP + "edu/m17/UserSliderBar/Index"
        ClassSeatUrl = ServerIP + "edu/m17/Seat/Index"
        
        FriendListUrl = ServerIP + "edu/m17/FriendList/Index"
        FriendCircleUrl = ServerIP + "edu/m17/FriendCircle/GetAllFriendCircle"
    }
    
    //同步请求
    func getJsonDataBySynchronous(apiurl: String,body: String) -> AnyObject? {
        var jsonData: AnyObject?
        let url = NSURL(string : apiurl)!
        let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
        let session = NSURLSession.sharedSession()
        let semaphore = dispatch_semaphore_create(0)
        let dataTask = session.dataTaskWithRequest(request,completionHandler:{(data,response,error)->Void in
            if error != nil {
                print(error?.code)
                print(error?.description)
            } else {
                jsonData = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                if jsonData != nil {
                    print("Json Object:"); print(jsonData)
                } else {
                    print("服务器没有返回JSON对象！")
                }
            }
            dispatch_semaphore_signal(semaphore)
        }) as NSURLSessionTask
        dataTask.resume()
        dispatch_semaphore_wait(semaphore,DISPATCH_TIME_FOREVER)
        print("数据加载完毕！")
        return jsonData
    }
    
    //异步请求
    func getJsonDataByAsynchronous(apiurl: String,body: String) -> AnyObject? {
        var jsonData: AnyObject?
        let url = NSURL(string : apiurl)!
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
                    jsonData = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                    print("Json Object:"); print(jsonData)
                }
        }) as NSURLSessionTask
        task.resume()
        return jsonData
    }
}
