//  Copyright © 2016 HB. All rights reserved.

protocol ModalReminderViewControllerDelegate {
    func passDataModalView(reminderModal: Reminder)
}

class ModalReminderViewController: UIViewController, ReminderViewControllerDelegate {
    
    var delegate: ModalReminderViewControllerDelegate? = nil
    
    @IBAction func addButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier=="sbSegueModal"{
            let reminderVC = segue.destinationViewController as! ReminderViewController
            reminderVC.delegate = self
        }
    }
    // Delegates
    func passData(reminder: Reminder) {
        delegate?.passDataModalView(reminder)
    }
}

import UIKit
