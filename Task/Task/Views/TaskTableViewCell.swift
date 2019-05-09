//
//  TaskTableViewCell.swift
//  Task
//
//  Created by William Moody on 5/8/19.
//  Copyright © 2019 William Moody. All rights reserved.
//

import UIKit

extension ButtonTableViewCell{

    func updateCell(task: Tasks){
        CellNameLabel.text = task.name
    }
}
