//
//  TeacherClassSideViewController.swift
//  ThankYou
//
//  Created by leig-imac on 16/3/8.
//  Copyright © 2016年 leig. All rights reserved.
//

import UIKit

class TeacherClassSideViewController: UIViewController,UITableViewDataSource {
    
    var teacherClassViewController: TeacherClassViewController!
    var distance: CGFloat = 0
    
    let FullDistance: CGFloat = 0.78
    let Proportion: CGFloat = 0.77
    
    @IBOutlet weak var teacherClassSideTableView: UITableView!
    
    let teacherSideMenu:[String] = ["测试菜单一","测试菜单二","测试菜单三","测试菜单四"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teacherClassViewController = UIStoryboard(name:"Main", bundle: nil).instantiateViewControllerWithIdentifier("TeacherClassViewController") as! TeacherClassViewController
        self.view.addSubview(teacherClassViewController.view)
        teacherClassViewController.panGesture.addTarget(self, action: Selector("pan:"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 响应 UIPanGestureRecognizer 事件
    func pan(recongnizer: UIPanGestureRecognizer) {
        let x = recongnizer.translationInView(self.view).x
        let trueDistance = distance + x // 实时距离
        
        // 如果 UIPanGestureRecognizer 结束，则激活自动停靠
        if recongnizer.state == UIGestureRecognizerState.Ended {
            
            if trueDistance > Common.screenWidth * (Proportion / 3) {
                showLeft()
            } else if trueDistance < Common.screenWidth * -(Proportion / 3) {
                showRight()
            } else {
                showHome()
            }
            
            return
        }
        
        // 计算缩放比例
        var proportion: CGFloat = recongnizer.view!.frame.origin.x >= 0 ? -1 : 1
        proportion *= trueDistance / Common.screenWidth
        proportion *= 1 - Proportion
        proportion /= 0.6
        proportion += 1
        if proportion <= Proportion { // 若比例已经达到最小，则不再继续动画
            return
        }
        // 执行平移和缩放动画
        recongnizer.view!.center = CGPointMake(self.view.center.x + trueDistance, self.view.center.y)
        recongnizer.view!.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion)
    }
    
    // 封装三个方法，便于后期调用
    
    // 展示左视图
    func showLeft() {
        distance = self.view.center.x * (FullDistance + Proportion / 2)
        doTheAnimate(self.Proportion)
    }
    // 展示主视图
    func showHome() {
        distance = 0
        doTheAnimate(1)
    }
    // 展示右视图
    func showRight() {
        distance = self.view.center.x * -(FullDistance + Proportion / 2)
        doTheAnimate(self.Proportion)
    }
    
    func doTheAnimate(proportion: CGFloat) {
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.teacherClassViewController.view.center = CGPointMake(self.view.center.x + self.distance, self.view.center.y)
            self.teacherClassViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion)
            }, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teacherSideMenu.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.teacherClassSideTableView.dequeueReusableCellWithIdentifier("TeacherClassSideCell")! as UITableViewCell
        let tfl = teacherSideMenu[indexPath.row]
        let title = cell.viewWithTag(101) as! UILabel
        title.text = tfl
        return cell
    }
}
