//
//  TaskController.swift
//  Task
//
//  Created by William Moody on 5/8/19.
//  Copyright © 2019 William Moody. All rights reserved.
//

import Foundation
import CoreData

class TaskController{
    
    static let shared = TaskController()
    
    var taskList: [Tasks]{
        let request: NSFetchRequest<Tasks> = Tasks.fetchRequest()
        return try! CoreDataStack.context.fetch(request)
    }
    
    //CRUD
    func createTask(name: String, note: String, due: Date){
        Tasks(name: name, note: note, due: due)
        saveData()
    }
    func updateTask(task: Tasks, with name: String, note: String, due: Date){
        task.name = name
        task.note = note
        task.due = due
        saveData()
    }
    func deleteTask(task: Tasks){
        if let moc = task.managedObjectContext{
            moc.delete(task)
        }
        saveData()
    }

    func toggleIsComplete(task: Tasks) {
        task.iscomplete = !task.iscomplete
    }
    
    //MARK: Data Storage
    func saveData(){
        let moc = CoreDataStack.context
        do{
            try moc.save()
        }catch{
            print("save Error \(error)")
        }
    }
}


