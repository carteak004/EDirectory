//
//  TableViewCell.swift
//  EDirectory
//
//  Created by Kartheek chintalapati on 29/09/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//
/************************************************************************************
 This swift file contains connections to elements of a Table View cell.
 ************************************************************************************/

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailPic: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
