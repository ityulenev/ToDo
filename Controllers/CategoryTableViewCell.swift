//
//  CategoryTableViewCell.swift
//  ToDo
//
//  Created by Ilya Tyulenev on 24/02/2019.
//  Copyright © 2019 Ilya Tyulenev. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


