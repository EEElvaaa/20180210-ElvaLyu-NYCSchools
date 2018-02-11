//
//  NYCHighSchoolsTableViewCell.swift
//  20180210-ElvaLyu-NYCSchools
//
//  Created by Elva Lyu on 2/10/18.
//  Copyright © 2018 Elva Lyu. All rights reserved.
//  @Description: This cell class is for displaying the NYC hgig school list name in the landing screen.

import UIKit

class NYCHighSchoolsTableViewCell: UITableViewCell {

    @IBOutlet weak var schoolNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
