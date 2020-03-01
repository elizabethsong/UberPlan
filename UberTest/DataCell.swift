//
//  DataCell.swift
//  UberTest
//
//  Created by Elizabeth Song on 3/1/20.
//  Copyright © 2020 Elizabeth. All rights reserved.
//

import UIKit

class DataCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(text: String) {
        
        label.text = text
    }
    
}
