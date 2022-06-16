//
//  ListTable.swift
//  todo_list
//
//  Created by Rakha A on 16/06/22.
//

import Foundation
import UIKit
class ListTable:UITableViewCell{
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var taskLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
