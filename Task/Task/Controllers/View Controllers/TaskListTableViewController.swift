//
//  TaskListTableViewController.swift
//  Task
//
//  Created by William Moody on 5/8/19.
//  Copyright © 2019 William Moody. All rights reserved.
//

import UIKit


class TaskListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("these work")
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TaskController.shared.taskList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! ButtonTableViewCell

        let task = TaskController.shared.taskList[indexPath.row]

        cell.updateCell(task: task)
        cell.delegate = self
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = TaskController.shared.taskList[indexPath.row]
            TaskController.shared.deleteTask(task: task)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "taskSegue",
            let indexPath = tableView.indexPathForSelectedRow {
            let task = TaskController.shared.taskList[indexPath.row]
            let taskVC = segue.destination as? TaskDetailViewController
            taskVC?.task = task
        }
    }
}

extension TaskListTableViewController: ButtonViewCellDelegate{
    func toggleBoxButton(cell: ButtonTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        let task = TaskController.shared.taskList[indexPath.row]
        TaskController.shared.toggleIsComplete(task: task)
        cell.updateButton(task.iscomplete)
        }
    }
