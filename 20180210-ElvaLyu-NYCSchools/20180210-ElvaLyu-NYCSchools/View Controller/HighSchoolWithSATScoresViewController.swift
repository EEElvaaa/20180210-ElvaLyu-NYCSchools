//
//  HighSchoolWithSATScoresViewController.swift
//  20180210-ElvaLyu-NYCSchools
//
//  Created by Elva Lyu on 2/10/18.
//  Copyright © 2018 Elva Lyu. All rights reserved.
//  @Description: This class is the detail screen that provide SAT avverage sccore, some school does not have give the score, display one static message instead. Also display the overview, location and contact information.

import UIKit
import CoreLocation
import MapKit

enum HighSchoolTableViewCell{
    
}

struct HighSchoolWithSATScoresConstant {
    static let schoolWithSATScoreCellIdentifier =  "HighSchoolSATScoresTableViewCell"
    static let schoolWithOverviewCellIdentifier = "HighSchoolOverViewTableViewCell"
    static let shoolWithAddressCellIdentifier = "HighSchoolAddressTableViewCell"
    static let schoolWithContactCellIdentifier = "HighSchoolContactTableViewCell"
    static let noSATScoreInfomationText = "There is no SAT score information for this high school"
    static let averageSATReadingScore = "SAT Average Critical Reading Score:  "
    static let averageSATMathScore = "SAT Average Math Score:   "
    static let averageSATWritingScore = "SAT Average Writing Score:   "
}
class HighSchoolWithSATScoresViewController: UIViewController {

    @IBOutlet weak var highSchoolWithSATScoresTableView: UITableView!
    var highSchoolWithSatScore: NYCHighSchools!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.highSchoolWithSATScoresTableView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /// This function fetch the coodinate for the selected high school location
    ///
    /// - Returns: CLLocationCoordinate2D, coodinate of high school location
    private func getCoodinateForSelectedHighSchool() -> CLLocationCoordinate2D?{
        if let schoolAddress = self.highSchoolWithSatScore.schoolAddress{
            let coordinateString = schoolAddress.slice(from: "(", to: ")")
            let coordinates = coordinateString?.components(separatedBy: ",")
            if let coordinateArray = coordinates{
                let latitude = (coordinateArray[0] as NSString).doubleValue
                let longitude = (coordinateArray[1] as NSString).doubleValue
                return CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
            }
        }
        return nil
    }
    
    /// This function get the normal address without coodinates
    ///
    /// - Returns: Stirng, address of the high school
    private func getCompleteAddressWithoutCoordinate() -> String{
        if let schoolAddress = self.highSchoolWithSatScore.schoolAddress{
            let address = schoolAddress.components(separatedBy: "(")
            return address[0]
        }
        return ""
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension HighSchoolWithSATScoresViewController: UITableViewDataSource, UITableViewDelegate{
    //MARK: UITableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return self.getTableViewCellForSATScore()
        case 1:
            return self.getTableViewCellForOverView()
        case 2:
            return self.getTableViewCellForAddress()
        default:
            return self.getTableViewCellForContact()
        }
    }

    /// This function get the selected high school name the average sat scrore
    ///
    /// - Returns: UITableViewCell
    private func getTableViewCellForSATScore() -> UITableViewCell{
        let schoolWithSATScoresCell = self.highSchoolWithSATScoresTableView.dequeueReusableCell(withIdentifier: HighSchoolWithSATScoresConstant.schoolWithSATScoreCellIdentifier) as! HighSchoolSATScoresTableViewCell
        schoolWithSATScoresCell.selectionStyle = UITableViewCellSelectionStyle.none
       
        schoolWithSATScoresCell.highSchoolNameLabel.text = self.highSchoolWithSatScore.schoolName
        //For some high school, there is no information of the average SAT score, display the static mesaage to the customers
        schoolWithSATScoresCell.satReadingAvgScoreLabel.text = (self.highSchoolWithSatScore.satCriticalReadingAvgScore != nil) ?  (HighSchoolWithSATScoresConstant.averageSATReadingScore + self.highSchoolWithSatScore.satCriticalReadingAvgScore!) : HighSchoolWithSATScoresConstant.noSATScoreInfomationText
        schoolWithSATScoresCell.satMathAvgScoreLabel.isHidden = (self.highSchoolWithSatScore.satMathAvgScore != nil) ? false : true
        schoolWithSATScoresCell.satMathAvgScoreLabel.text = (self.highSchoolWithSatScore.satMathAvgScore != nil) ? (HighSchoolWithSATScoresConstant.averageSATMathScore + self.highSchoolWithSatScore.satMathAvgScore!) : nil
        schoolWithSATScoresCell.satWritingAvgScoreLabel.isHidden =  (self.highSchoolWithSatScore.satWritinAvgScore != nil) ? false : true
        schoolWithSATScoresCell.satWritingAvgScoreLabel.text = (self.highSchoolWithSatScore.satWritinAvgScore != nil) ? (HighSchoolWithSATScoresConstant.averageSATWritingScore + self.highSchoolWithSatScore.satWritinAvgScore!) : nil
        return schoolWithSATScoresCell
    }
    
    /// This function get the selected high school's overview
    ///
    /// - Returns: UITableViewCell
    private func getTableViewCellForOverView() -> UITableViewCell{
        let schoolWithOverviewCell = self.highSchoolWithSATScoresTableView.dequeueReusableCell(withIdentifier: HighSchoolWithSATScoresConstant.schoolWithOverviewCellIdentifier) as! HighSchoolOverviewTableViewCell
        schoolWithOverviewCell.selectionStyle = UITableViewCellSelectionStyle.none
        schoolWithOverviewCell.highSchoolOverviewLabel.text = self.highSchoolWithSatScore.overviewParagraph
        return schoolWithOverviewCell
    }
    
    /// This function get the high school's location with annotaion on the map
    ///
    /// - Returns: UITableViewCell
    private func getTableViewCellForAddress() -> UITableViewCell{
        let schoolWithAddressCell = self.highSchoolWithSATScoresTableView.dequeueReusableCell(withIdentifier: HighSchoolWithSATScoresConstant.shoolWithAddressCellIdentifier) as! HighSchoolAddressTableViewCell
        schoolWithAddressCell.selectionStyle = UITableViewCellSelectionStyle.none
        if let highSchoolCoordinate = self.getCoodinateForSelectedHighSchool(){
            schoolWithAddressCell.addHighSchoolAnnotaionWithCoordinates(highSchoolCoordinate)
        }
        return schoolWithAddressCell
    }
    
    /// This function get the high school contact information with address, tel and website.
    ///
    /// - Returns: UITableViewCell
    private func getTableViewCellForContact() -> UITableViewCell{
        let schoolWithContactCell = self.highSchoolWithSATScoresTableView.dequeueReusableCell(withIdentifier: HighSchoolWithSATScoresConstant.schoolWithContactCellIdentifier) as! HighSchoolContactTableViewCell
        schoolWithContactCell.selectionStyle = UITableViewCellSelectionStyle.none
        schoolWithContactCell.highSchoolAddressLabel.text = "Address: " + self.getCompleteAddressWithoutCoordinate()
        schoolWithContactCell.highSchoolTelephoneLabel.text = (self.highSchoolWithSatScore.schoolTelephoneNumber != nil) ? "Tel:  " + self.highSchoolWithSatScore.schoolTelephoneNumber! : ""
        schoolWithContactCell.highSchoolWebsiteLabel.text = self.highSchoolWithSatScore.schoolWebsite
        return schoolWithContactCell
    }
    
    //MARK: - UITable View Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0,1,3:
            return UITableViewAutomaticDimension
            
        default:
            return UIScreen.main.bounds.width * 0.7
        }
    }
}

extension String {
    func slice(from: String, to: String) -> String? {
        
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                substring(with: substringFrom..<substringTo)
            }
        }
    }
}

