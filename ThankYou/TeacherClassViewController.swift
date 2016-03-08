//
//  TeacherClassViewController.swift
//  ThankYou
//
//  Created by leig-imac on 16/3/7.
//  Copyright © 2016年 leig. All rights reserved.
//

import UIKit

class TeacherClassViewController: UIViewController,UICollectionViewDataSource {
    
    @IBOutlet var panGesture: UIPanGestureRecognizer!
    
    @IBOutlet weak var teacherClassTableView: UICollectionView!

    @IBOutlet weak var editButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teacherClassTableView.backgroundColor = UIColor.whiteColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = teacherClassTableView.dequeueReusableCellWithReuseIdentifier("TeacherClassCell", forIndexPath: indexPath)
        let tfl = cell.viewWithTag(102) as! UILabel
        tfl.text = "测试名字"
        cell.backgroundColor = UIColor.blueColor()
        return cell
    }
    
    func getClassJsonData() {
    
    }
}
