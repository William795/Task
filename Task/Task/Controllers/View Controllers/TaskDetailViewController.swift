//
//  TaskDetailViewController.swift
//  Task
//
//  Created by William Moody on 5/8/19.
//  Copyright © 2019 William Moody. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {

    @IBOutlet weak var barTitleLabel: UINavigationItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dueTextField: UITextField!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var noteTextBlock: UITextView!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    
    var task: Tasks?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        barTitleLabel.title = task?.name
        nameTextField.text = task?.name
        noteTextBlock.text = task?.note
        guard let taskDue = task?.due else {return}
        dueDatePicker.date = taskDue
        dueTextField.text = task?.TimeAsString
        dueTextField.inputView = dueDatePicker
        // Do any additional setup after loading the view.
    }

    @IBAction func saveBarButtonTapped(_ sender: Any) {
        guard let taskName = nameTextField.text, let taskNote = noteTextBlock.text, !taskName.isEmpty else {return}
        
        if let task = self.task{
            TaskController.shared.updateTask(task: task, with: taskName, note: taskNote, due: dueDatePicker.date)
            navigationController?.popViewController(animated: true)
        }else{
            TaskController.shared.createTask(name: taskName, note: taskNote, due: dueDatePicker.date)
            navigationController?.popViewController(animated: true)
        }
    }
}
