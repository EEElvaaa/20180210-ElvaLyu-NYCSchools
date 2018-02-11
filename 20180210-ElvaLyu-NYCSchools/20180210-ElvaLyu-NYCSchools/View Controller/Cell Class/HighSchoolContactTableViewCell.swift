//
//  HighSchoolContactTableViewCell.swift
//  20180210-ElvaLyu-NYCSchools
//
//  Created by Elva Lyu on 2/11/18.
//  Copyright © 2018 Elva Lyu. All rights reserved.
//  @Description: This cell class is for displaying the selected NYC hgig school's contact with address, tel and website in the detail page.

import UIKit

class HighSchoolContactTableViewCell: UITableViewCell {

    @IBOutlet weak var highSchoolAddressLabel: UILabel!
    @IBOutlet weak var highSchoolTelephoneLabel: UILabel!
    @IBOutlet weak var highSchoolWebsiteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
