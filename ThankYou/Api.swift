//
//  ApiUrl.swift
//  ThankYou
//
//  Created by leig-imac on 16/3/3.
//  Copyright © 2016年 leig. All rights reserved.
//

import UIKit

struct ApiOperating {
    
    let ServerAddress: String
    let LoginUrl: String
    let ForgetPwdUrl: String
    let FriendCircleUrl: String
    let UserInfoUrl: String
    
    let ClassSeatUrl: String
    let FriendListUrl: String
    let SliderBarUrl: String
    
    init() {
        ServerAddress = "http://192.168.0.139/"
        LoginUrl =  ServerAddress + "edu/m17/Login/Index"
        ForgetPwdUrl = ServerAddress + "edu/m00/ForgetPassword/Index"
    
        UserInfoUrl = ServerAddress + "edu/m17/UserInfo/Index"
        
        SliderBarUrl = ServerAddress + "edu/m17/UserSliderBar/Index"
        ClassSeatUrl = ServerAddress + "edu/m17/Seat/Index"
        
        FriendListUrl = ServerAddress + "edu/m17/FriendList/Index"
        FriendCircleUrl = ServerAddress + "edu/m17/FriendCircle/GetAllFriendCircle"
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
    
    //修改图片尺寸
    func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
