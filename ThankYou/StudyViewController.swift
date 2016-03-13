//
//  FindHomeViewController.swift
//  ThankYou
//
//  Created by leig-imac on 16/3/10.
//  Copyright © 2016年 leig. All rights reserved.
//

import UIKit

class StudyViewController: UIViewController {
    
    var studyHomeViewController: StudyHomeViewController!
    
    var studyMenuViewController: StudyMenuViewController?
    
    var currentState = MenuState.Collapsed {
        didSet {
            //菜单展开的时候，给主页面边缘添加阴影
            let shouldShowShadow = currentState != .Collapsed
            showShadowForMainViewController(shouldShowShadow)
        }
    }
    
    //菜单打开后主页在屏幕右侧露出部分的宽度
    let menuViewExpandedOffset: CGFloat = 150
    

    
    func handlePanGesture(recognizer:UIPanGestureRecognizer) {
        switch(recognizer.state) {
            //刚刚开始滑动
        case .Began:
            //判断拖动方向
            let dragFromLeftToRight = (recognizer.velocityInView(view).x > 0)
            if (currentState == .Collapsed && dragFromLeftToRight) {
                currentState = .Expanding
                addMenuViewController()
            }
            //如果是正在滑动，则偏移主视图的坐标实现跟随手指位置移动
        case .Changed:
            let positionX = recognizer.view!.frame.origin.x + recognizer.translationInView(view).x
            //页面滑动到最左侧的话就不需要继续往左移动
            recognizer.view!.frame.origin.x = positionX < 0 ? 0 : positionX
            recognizer.setTranslation(CGPointZero, inView: view)
            //如果滑动结束
        case .Ended:
            //根据页面滑动是否过半，判断后面是自动展开还是收缩
            let hasMovehanHalfway = recognizer.view!.center.x > view.bounds.size.width
            animateMainView(hasMovehanHalfway)
        default:
            break
        }
    }
    
    func handlePanGesture() {
        //如果菜单页是展开的点击主页部分则会收起
        if currentState == .Expanded {
            animateMainView(false)
            print("点击其他页收起菜单！")
        }
    }
    
    func addMenuViewController() {
        if (studyMenuViewController == nil) {
            studyMenuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("StudyMenuViewController") as? StudyMenuViewController
            //插入当前视图并置顶
            view.insertSubview(studyMenuViewController!.view, atIndex: 0)
            
            //建立父子关系
            addChildViewController(studyMenuViewController!)
            studyMenuViewController!.didMoveToParentViewController(self)
        }
    }
    
    func animateMainView(shouldExpand: Bool) {
        //如果是用来展开
        if (shouldExpand) {
            currentState = .Expanded
            //动画
            animateMainViewXPosition(CGRectGetWidth(studyHomeViewController.view.frame) - menuViewExpandedOffset)
        } else {
            animateMainViewXPosition(0) { finished in
                self.currentState = .Collapsed
                self.studyMenuViewController?.view.removeFromSuperview()
                self.studyMenuViewController = nil;
            }
        }
    }
    
    func animateMainViewXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {self.studyHomeViewController.view.frame.origin.x = targetPosition}, completion: completion)
    }
    
    func showShadowForMainViewController(shouldShowShadow: Bool){
        if(shouldShowShadow) {
            studyHomeViewController.view.layer.shadowOpacity = 0.8
        } else {
            studyHomeViewController.view.layer.shadowOpacity = 0.0
        }
    }
    
    enum MenuState {
        case Collapsed
        case Expanding
        case Expanded
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bgBuleColor = UIColor(red: 38/255, green: 109/255, blue: 227/255, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = bgBuleColor
        //添加主页面
        studyHomeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("StudyHomeViewController") as! StudyHomeViewController
        self.view.addSubview(studyHomeViewController.view)
        
        //建立父子关系
        addChildViewController(studyHomeViewController)
        studyHomeViewController.didMoveToParentViewController(self)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
        studyHomeViewController.view.addGestureRecognizer(panGestureRecognizer)
        
        //单击收起菜单手势
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handlePanGesture")
        studyHomeViewController.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
}
