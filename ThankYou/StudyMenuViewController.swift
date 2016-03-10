//
//  FindMenuViewController.swift
//  ThankYou
//
//  Created by leig-imac on 16/3/10.
//  Copyright © 2016年 leig. All rights reserved.
//

import UIKit

class StudyMenuViewController: UIViewController,UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"SidebarBackground.jpg")!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.menuTableView.backgroundColor = UIColor.clearColor()
        
    }
    
    @IBOutlet weak var menuTableView: UITableView!
    
    struct sidebar {
        var cid: String
        var classname: String
    }
    
    let cls: [ClassInfo] = classLists
    
    var sidebars: [sidebar] = []
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classLists.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.menuTableView.dequeueReusableCellWithIdentifier("StudyMenuCell")! as UITableViewCell
        for cl in cls {
            let title = cell.textLabel
            title!.text = cl.classname
        }
        return cell
    }
}
