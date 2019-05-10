//
//  TasksListTableViewController.swift
//  Task
//
//  Created by William Moody on 5/9/19.
//  Copyright © 2019 William Moody. All rights reserved.
//

import UIKit
import CoreData

class TasksListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        TaskController.shared.fetchedResultsController.delegate = self
  }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return TaskController.shared.fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        // MARK: naming sections
        
        if section == 0 {
            return "Incomplete"
        } else {
            return "Complete"
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TaskController.shared.fetchedResultsController.fetchedObjects?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! ButtonTableViewCell

        guard let task = TaskController.shared.fetchedResultsController.fetchedObjects?[indexPath.row] else {return ButtonTableViewCell()}
        // Configure the cell...

        
        cell.updateButton(task.iscomplete)
        cell.CellNameLabel.text = task.name
        cell.delegate = self
        
        return cell
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) { print("delete1")
        if editingStyle == .delete {
            let task = TaskController.shared.fetchedResultsController.object(at: indexPath) 
            print("delete2")
            TaskController.shared.deleteTask(task: task)
            print("delete3")
        }
    }


    // MARK: - Navigation

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "taskSegue" {
            guard let selectedIdexPath = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? TaskDetailViewController else {return}
            let task = TaskController.shared.fetchedResultsController.fetchedObjects?[selectedIdexPath.row]
            destinationVC.task = task
        }
    }


}


extension TasksListTableViewController: ButtonViewCellDelegate{
    func toggleBoxButton(cell: ButtonTableViewCell) { print("ssss")
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        let task = TaskController.shared.fetchedResultsController.fetchedObjects?[indexPath.row]
        TaskController.shared.toggleIsComplete(task: task!)
        cell.updateButton(task!.iscomplete)
        print("extension")
    }
}


extension TasksListTableViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
            
        case .delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        case .insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
        case .move:
            guard let oldIndexPath = indexPath, let newIndexPath = newIndexPath else {return}
            tableView.moveRow(at: oldIndexPath, to: newIndexPath)
            
        case .update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRows(at: [indexPath], with: .automatic)
        @unknown default:
            fatalError()
        }
    }
}
