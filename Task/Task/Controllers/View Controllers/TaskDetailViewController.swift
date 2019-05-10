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
        
        dueTextField.inputView = dueDatePicker
        updateView()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func saveBarButtonTapped(_ sender: Any) {
        guard let taskName = nameTextField.text, let taskNote = noteTextBlock.text, !taskName.isEmpty else {return}
        
        if let task = self.task{
            TaskController.shared.updateTask(task: task, with: taskName, note: taskNote, due: dueDatePicker.date)
            navigationController?.popViewController(animated: true)
            print("updated")
        }else{
            TaskController.shared.createTask(name: taskName, note: taskNote, due: dueDatePicker.date)
            navigationController?.popViewController(animated: true)
            print("saved")
        }
    }
    
    func updateView(){
        guard let task = task else {return}
        nameTextField.text = task.name
        noteTextBlock.text = task.note
        dueTextField.text = task.due?.stringValue()
    }
}




extension Date {
    func stringValue() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        return formatter.string(from: self)
    }
}
