//
//  HighSchoolSATScoresTableViewCell.swift
//  20180210-ElvaLyu-NYCSchools
//
//  Created by Elva Lyu on 2/10/18.
//  Copyright © 2018 Elva Lyu. All rights reserved.
//  @Description: This cell class is for displaying the selected NYC hgig school name with the SAT score in the detail page.

import UIKit

class HighSchoolSATScoresTableViewCell: UITableViewCell {

    @IBOutlet weak var highSchoolNameLabel: UILabel!
    @IBOutlet weak var satReadingAvgScoreLabel: UILabel!
    @IBOutlet weak var satMathAvgScoreLabel: UILabel!
    @IBOutlet weak var satWritingAvgScoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
