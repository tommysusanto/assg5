//  Copyright © 2016 HB. All rights reserved.

class TaskTableViewCell: UITableViewCell {

  var completed = false

    @IBOutlet weak var txtDescription: UITextField!
    
    @IBOutlet weak var buttonImage: UIButton!
    
  @IBAction func radioButtonPressed(sender: AnyObject) {
    if let button = sender as? UIButton {
      button.setImage(
        UIImage(named: completed ? "radio-off" : "radio-on"),
        forState: .Normal)
      completed = !completed
    }
  }
}

import UIKit
