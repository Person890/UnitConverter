//
//  HistoryTableViewCell.swift
//  ConV
//
//  Created by Yi Qian on 11/20/21.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var conversionType: UILabel!
    @IBOutlet weak var conversionText: UILabel!
    
    override func layoutSubviews(){
        super.layoutSubviews();
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }

}
