//
//  NYCHighSchoolsViewController.swift
//  20180210-ElvaLyu-NYCSchools
//
//  Created by Elva Lyu on 2/10/18.
//  Copyright © 2018 Elva Lyu. All rights reserved.
// @Description: This class is the landing screnn that display NYC high schoolls' list, click the name will navigate to new screen and show more information

import UIKit

struct NYCHighSchoolsConstant {
    static let highSchoolsURL = "https://data.cityofnewyork.us/resource/97mf-9njv.json"
    static let schoolWithSATScoreURL = "https://data.cityofnewyork.us/resource/734v-jeq5.json"
    static let highSchoolsCellIdentifier = "nycHighSchoolsCell"
    static let highSchoolWithSATScoreSegue = "HghSchoolWithSATScoreSegue"
}

class NYCHighSchoolsViewController: UIViewController {
    //UI Components
    @IBOutlet weak var nycHighSchoolsTableView: UITableView!
    //variables
    var nycHighSchoolsList: [NYCHighSchools]?
   
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "NYC High Schools"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchNYCHighSchoolInformation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Fetch API and parse json payloads
    private func fetchNYCHighSchoolInformation(){
        guard let highSchoolsURL = URL(string: NYCHighSchoolsConstant.highSchoolsURL) else {
            return
        }
        let request = URLRequest(url:highSchoolsURL)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { [weak self] (highSchoolsData, response, error)  in
            if highSchoolsData != nil{
                do{
                    let highSchoolsObject = try JSONSerialization.jsonObject(with: highSchoolsData!, options: [])
                    self?.nycHighSchoolsList = self?.fetchNYCHighSchoolsWithJsonData(highSchoolsObject)
                    self?.fetchHighSchoolSATSore()
                }catch{
                    debugPrint("nyc high schools json error: \(error.localizedDescription)")
                }
            }
                
        }
        task.resume()
    }
    
    /// Pass the json and configure to the model type
    ///
    /// - Parameter highSchoolsData: data of array composed with Dictionary
    /// - Returns: Array of model class
    private func fetchNYCHighSchoolsWithJsonData(_ highSchoolsData: Any) -> [NYCHighSchools]?{
        guard let highSchoolsDictionaryArray = highSchoolsData as? [[String: Any]] else{
            return nil
        }
        var highSchoolModelArray = [NYCHighSchools]()
        for highSchoolsDictionary in highSchoolsDictionaryArray{
            if let highSchoolModels = NYCHighSchools.getHighSchoolsWithJSON(highSchoolsDictionary){
                highSchoolModelArray.append(highSchoolModels)
            }
        }
        return highSchoolModelArray
    }

    /// This function is call the API to get all the high school with sat score, and add to the exist model array according to the common parameter dbn.
    private func fetchHighSchoolSATSore(){
        guard let highSchoolsSATScoreURL = URL(string: NYCHighSchoolsConstant.schoolWithSATScoreURL) else {
            return
        }
        let requestForSATScore = URLRequest(url:highSchoolsSATScoreURL)
        let session = URLSession.shared
        let task = session.dataTask(with: requestForSATScore) {[weak self] (schoolsWithSATScoreData, response, error) in
            if schoolsWithSATScoreData != nil{
                do{
                    let satScoreObject = try JSONSerialization.jsonObject(with: schoolsWithSATScoreData!, options: [])
                    self?.addSatScoreToHighSchool(satScoreObject)
                    DispatchQueue.main.async {[weak self] in
                       self?.nycHighSchoolsTableView.reloadData()
                    }
                }catch{
                    debugPrint("high school with sat score json error: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }

    /// This function is used to add the sat score to the each high school
    ///
    /// - Parameter satScoreObject: data of array composed with Dictionary
    private func addSatScoreToHighSchool(_ satScoreObject: Any){
        guard let highSchoolsWithSatScoreArray = satScoreObject as? [[String: Any]] else{
            return
        }
        for  highSchoolsWithSatScore in highSchoolsWithSatScoreArray{
            if let matchedDBN = highSchoolsWithSatScore["dbn"] as? String{
                //get the high schhool with the common dbn
                let matchedHighSchools = self.nycHighSchoolsList?.first(where: { (nycHighSchool) -> Bool in
                    return nycHighSchool.dbn == matchedDBN
                })
                guard matchedHighSchools != nil else{
                    continue
                }

                if let satReadingScoreObject =  highSchoolsWithSatScore["sat_critical_reading_avg_score"] as? String{
                    matchedHighSchools!.satCriticalReadingAvgScore = satReadingScoreObject
                }
                if let satMathScoreObject = highSchoolsWithSatScore["sat_math_avg_score"] as? String{
                    matchedHighSchools!.satMathAvgScore = satMathScoreObject
                }
                if let satWritingScoreObject =  highSchoolsWithSatScore["sat_writing_avg_score"] as? String{
                    matchedHighSchools!.satWritinAvgScore = satWritingScoreObject
                }
            }
        }
    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       //Pass the selected school with sat score to the destinatiion view controller
        if segue.identifier == NYCHighSchoolsConstant.highSchoolWithSATScoreSegue{
            let highSchoolWithSATScoreVC = segue.destination as! HighSchoolWithSATScoresViewController
            if let highSchoolWithSATScore = sender as? NYCHighSchools {
                highSchoolWithSATScoreVC.highSchoolWithSatScore = highSchoolWithSATScore
            }
        }
    }
    
}

extension NYCHighSchoolsViewController: UITableViewDataSource, UITableViewDelegate{

    //MARK: - UITableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nycHighSchoolsList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nycHighSchoolCell = self.nycHighSchoolsTableView.dequeueReusableCell (withIdentifier: NYCHighSchoolsConstant.highSchoolsCellIdentifier, for: indexPath) as! NYCHighSchoolsTableViewCell
        nycHighSchoolCell.selectionStyle = UITableViewCellSelectionStyle.none
        if let nycHighSchoolsArray = self.nycHighSchoolsList{
            nycHighSchoolCell.schoolNameLabel.text = nycHighSchoolsArray[indexPath.row].schoolName
           
        }
        return nycHighSchoolCell
    }
    
    //MARK: - UITable View Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let nycHighSchoolsArray = self.nycHighSchoolsList{
            let selectedHighSchool = nycHighSchoolsArray[indexPath.row]
            self.performSegue(withIdentifier: NYCHighSchoolsConstant.highSchoolWithSATScoreSegue, sender: selectedHighSchool)
        }
    }
    

}
