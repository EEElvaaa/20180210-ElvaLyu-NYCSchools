//
//  NYCHighSchools.swift
//  20180210-ElvaLyu-NYCSchools
//
//  Created by Elva Lyu on 2/10/18.
//  Copyright © 2018 Elva Lyu. All rights reserved.
// @Description: This the model class for the NYC high school indcluding the parameter name, SAT score and address, contact that will be showed in the detail page.

import UIKit

class NYCHighSchools: NSObject {
    
    var dbn: String?
    var schoolName: String?
    var overviewParagraph: String?
    var schoolAddress: String?
    var schoolWebsite:String?
    var schoolTelephoneNumber: String?
    var satCriticalReadingAvgScore: String?
    var satMathAvgScore: String?
    var satWritinAvgScore: String?
    
    /// This functions is used to fetch json payload and assign parameter to the NYCHighSchools model
    ///
    /// - Parameter json: dictionany with schools detail
    /// - Returns: high school model type
    class func getHighSchoolsWithJSON(_ json: [String: Any]) -> NYCHighSchools?{
        if !json.isEmpty{
            let nycHighSchools = NYCHighSchools()
            if let dbnObject = json["dbn"] as? String{
                nycHighSchools.dbn = dbnObject
            }
            
            if let schoolNameOnject = json["school_name"] as? String{
                nycHighSchools.schoolName = schoolNameOnject
            }
            
            if let overviewParagraphObject = json["overview_paragraph"] as? String{
                nycHighSchools.overviewParagraph = overviewParagraphObject
            }
            if let schoolAddressObject = json["location"] as? String{
                nycHighSchools.schoolAddress = schoolAddressObject
            }
            if let schoolTelObject = json["phone_number"] as? String{
                nycHighSchools.schoolTelephoneNumber = schoolTelObject
            }
            
            if let websiteObject = json["website"] as? String{
                nycHighSchools.schoolWebsite = websiteObject
            }
            return nycHighSchools
        }
        return nil
    }
}
