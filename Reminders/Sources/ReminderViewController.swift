//  Copyright © 2016 HB. All rights reserved.
protocol ReminderViewControllerDelegate
{
    func passData(reminder: Reminder)
}

class ReminderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tasksTableView: UITableView!
    @IBOutlet weak var titleTextField: UITextField!
    
    let taskTableViewCellIdentifier = "TaskTableViewCell"
    let addTaskTableViewCellIdentifier = "AddTaskTableViewCell"
    var delegate: ReminderViewControllerDelegate?
    
    var reminder: Reminder?
    
    var descriptionArray: [String] = []
    var titleText: [String] = []
    var radioButtonArray: [Bool] = []
    var selectedTitle: String?
    
    var numberOfRows = 0
    
    // MARK: ViewController Lifecycle
    
    override func viewDidAppear(animated: Bool) {
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
        tasksTableView.reloadData()
    }
    
    // Mark: TableView Delegate and DataSource
    
    func tableView(
        tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        return numberOfRows + 1
    }
    
    func tableView(
        tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell?
        
        switch indexPath.row {
        case 0 where numberOfRows == 0, numberOfRows:
            cell = tableView.dequeueReusableCellWithIdentifier(addTaskTableViewCellIdentifier)
            
        default:
            cell = tableView.dequeueReusableCellWithIdentifier(taskTableViewCellIdentifier)
            let cell = cell as? TaskTableViewCell
            let isIndexValid = descriptionArray.indices.contains(indexPath.row)
            if isIndexValid == true{
                cell?.txtDescription.text = descriptionArray[indexPath.row]
                cell?.completed = radioButtonArray[indexPath.row]
            }
        }
        
        return cell!
    }
    
    func tableView(
        tableView: UITableView,
        didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0 where numberOfRows == 0, numberOfRows:
            numberOfRows += 1
            tableView.reloadData()
        default:
            break
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func viewDidDisappear(animated: Bool) {
        //let cells = tasksTableView.visibleCells as! Array<TaskTableViewCell>
        var taskTempArray: [Task] = []
        for cell in tasksTableView.visibleCells {
            if let cellTemp = cell as? TaskTableViewCell{
                let taskTemp: Task = Task (completed: cellTemp.completed, description: cellTemp.txtDescription.text!)
                taskTempArray.append(taskTemp)
            }
        }
        reminder = Reminder(title: titleTextField.text!, tasks: taskTempArray)
        if reminder!.title != nil && reminder!.tasks.count != 0 {
            delegate?.passData(reminder!)
        }
    }
}

import UIKit
