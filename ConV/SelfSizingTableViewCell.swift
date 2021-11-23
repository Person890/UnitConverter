//
//  SelfSizingTableViewCell.swift
//  ConV
//
//  Created by Yi Qian on 11/22/21.
//

import UIKit

class SelfSizingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
