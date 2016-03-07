//
//  TeacherFindAnnouncement .swift
//  ThankYou
//
//  Created by leig-imac on 16/3/7.
//  Copyright © 2016年 leig. All rights reserved.
//

import UIKit

class TeacherFindAnnouncement: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var teacherFindAnnouncementTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.teacherFindAnnouncementTableView.dequeueReusableCellWithIdentifier("teacherFindAnnouncementCell")! as UITableViewCell
        return cell
    }
}
