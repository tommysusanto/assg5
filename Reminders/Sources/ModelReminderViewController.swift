//  Copyright © 2016 HB. All rights reserved.

protocol ModalReminderViewControllerDelegate {
    func passDataModalView(result: [String],title: [String],radio: [Bool])
}

class ModalReminderViewController: UIViewController, ReminderViewControllerDelegate {
    
    var delegate: ModalReminderViewControllerDelegate? = nil
    var descriptionModalView: [String] = []
    var radioButtonModalView: [Bool] = []
    
    @IBAction func addButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier=="sbSegueModal"{
            let reminderVC: ReminderViewController = segue.destinationViewController as! ReminderViewController
            
            reminderVC.delegate = self
        }
    }
    // Delegates
    func passData(content: [String],title: [String],radio: [Bool]) {
        descriptionModalView = content
        delegate?.passDataModalView(descriptionModalView,title: title,radio: radio)
    }
}

import UIKit
