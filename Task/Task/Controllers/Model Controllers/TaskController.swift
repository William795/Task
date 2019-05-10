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
    
//    var taskList: [Tasks]{
//        let request: NSFetchRequest<Tasks> = Tasks.fetchRequest()
//        return try! CoreDataStack.context.fetch(request)
//    }
    var fetchedResultsController: NSFetchedResultsController<Tasks>
    
    init() {
        
        let fetchRequest: NSFetchRequest<Tasks> = Tasks.fetchRequest()
        
        let isCompletedDescriptor = NSSortDescriptor(key: "iscomplete", ascending: false)
        //second key needed
        fetchRequest.sortDescriptors = [isCompletedDescriptor]
        
        let resultsController:NSFetchedResultsController<Tasks> = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        
        self.fetchedResultsController = resultsController
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("There was an error preforming the fetch!! \(error.localizedDescription) ")
        }
    }
    
    //CRUD
    func createTask(name: String, note: String, due: Date){
        Tasks(name: name, note: note, due: due)
        saveToPersistence()
    }
    func updateTask(task: Tasks, with name: String, note: String, due: Date){
        task.name = name
        task.note = note
        task.due = due
        saveToPersistence()
    }
    func deleteTask(task: Tasks){ print("aaaaa")
        let moc = CoreDataStack.context
        print("bbbbb")
        moc.delete(task)
        print("CCCCC")
        saveToPersistence()
        print("DDDDD")
    }

    func toggleIsComplete(task: Tasks) {
        task.iscomplete = !task.iscomplete
        saveToPersistence()
    }
    
    //MARK: Data Storage
    func saveToPersistence(){
        let moc = CoreDataStack.context
        do{
            try moc.save()
        }catch{
            print("save Error \(error)")
        }
    }
}


