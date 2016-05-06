//  Copyright © 2016 HB. All rights reserved.

class MainTableViewController: UITableViewController,ModalReminderViewControllerDelegate {
    
    @IBOutlet var mainTableView: UITableView!
    let menuTableViewCellId = "MenuTableViewCell"
    let addTableViewCellId = "AddReminderTableViewCell"
    let reminderViewControllerId = "ReminderViewController"
    var reminderArray: [Reminder] = []
    var displayTitle: [String] = []
    var displayDesc: [String] = []
    
    var numberOfRows = 0
    
    override func viewDidLoad() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.reloadData()
    }
    
    override func tableView(
        tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        return numberOfRows+1
    }
    
    override func tableView(
        tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell?
        
        switch indexPath.row {
        case 0 where numberOfRows == 0, numberOfRows:
            cell = tableView.dequeueReusableCellWithIdentifier(addTableViewCellId)
        default:
            cell = tableView.dequeueReusableCellWithIdentifier(menuTableViewCellId)
            
            if let cell = cell {
                cell.textLabel?.text = displayTitle[indexPath.row]
                cell.detailTextLabel?.text = displayDesc[indexPath.row]
            }
        }
        return cell!
    }
    
    override func tableView(
        tableView: UITableView,
        didSelectRowAtIndexPath indexPath: NSIndexPath) {
        /*
         if indexPath.row == 1 {
         let viewController = storyboard?.instantiateViewControllerWithIdentifier("ReminderViewController")
         if let viewController = viewController as? ModalReminderViewController {
         viewController.delegate = self
         
         presentViewController(viewController, animated: true, completion: nil)
         }
         }
         */
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier=="modalSegue"{
            let modalView: ModalReminderViewController = segue.destinationViewController as! ModalReminderViewController
            modalView.delegate = self
        }
    }
    
    func passDataModalView(reminderModal: Reminder) {
        if reminderArray.count==0{
            reminderArray.append(reminderModal)
        }
        else{
            var doesExist = false
            for index1 in 0..<reminderArray.count{
                if reminderArray[index1].title==reminderModal.title{
                    reminderArray[index1].tasks = reminderModal.tasks
                    doesExist = true
                }
            }
            if doesExist == false {
                reminderArray.append(reminderModal)
            }
        }
        displayTitle=[]
        displayDesc=[]
        for index1 in 0..<reminderArray.count{
            for index2 in 0..<reminderArray[index1].tasks.count{
                displayTitle.append(reminderArray[index1].title!)
                displayDesc.append(reminderArray[index1].tasks[index2].description!)
            }
        }
        print(reminderArray.count)
        numberOfRows=displayDesc.count
        mainTableView.reloadData()
    }
    
}

import UIKit
