//
//  PushReminderViewControler.swift
//  Reminders
//
//  Created by Tommy Susanto on 6/05/2016.
//  Copyright © 2016 HB. All rights reserved.
//

protocol PushReminderViewControllerDelegate{
    func passDataPushView(reminderPush: Reminder)
    func deleteData(reminderPush: Reminder)
}
class PushReminderViewController: UIViewController,ReminderViewControllerDelegate{
    
    var delegate: PushReminderViewControllerDelegate?
    var reminderPush: Reminder?
    
    @IBAction func deleteClicked(sender: AnyObject) {
        delegate?.deleteData(reminderPush!)
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "sbSeguePush"{
            let reminderVC = segue.destinationViewController as! ReminderViewController
            reminderVC.delegate = self
            reminderVC.reminder = reminderPush
        }
    }
    
    func passData(reminder: Reminder) {
        delegate?.passDataPushView(reminder)
    }
}

import UIKit
