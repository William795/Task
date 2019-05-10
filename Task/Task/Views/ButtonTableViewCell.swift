//
//  ButtonTableViewCell.swift
//  Task
//
//  Created by William Moody on 5/8/19.
//  Copyright © 2019 William Moody. All rights reserved.
//

import UIKit
import CoreData

class ButtonTableViewCell: UITableViewCell {
        
    @IBOutlet weak var CellNameLabel: UILabel!
    @IBOutlet weak var BoxButton: UIButton!
    
    weak var delegate: ButtonViewCellDelegate?
    
    @IBAction func boxButtonPressed(_ sender: Any) {
        delegate?.toggleBoxButton(cell: self)
        print("button pressed")
    }
    
    func updateButton(_ isComplete: Bool){
        if isComplete == true{
            BoxButton.setImage(UIImage(named: "CheckedBox"), for: .normal)
            print("On")
        }else{
            BoxButton.setImage(UIImage(named: "BlankBox"), for: .normal)
            print("Off")
        }
    }
    
}

protocol ButtonViewCellDelegate: class {
    func toggleBoxButton(cell: ButtonTableViewCell)
}
