//
//  Task+Convience.swift
//  Task
//
//  Created by William Moody on 5/8/19.
//  Copyright © 2019 William Moody. All rights reserved.
//

import Foundation
import CoreData

extension Tasks {
    
    
    @discardableResult
    convenience init(name: String, note: String, due: Date, iscomplete: Bool = false, context: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: context)
        self.name = name
        self.note = note
        self.due = due
        self.iscomplete = iscomplete
    }
}
