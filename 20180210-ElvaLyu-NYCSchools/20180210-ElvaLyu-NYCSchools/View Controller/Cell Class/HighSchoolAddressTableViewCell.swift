//
//  HighSchoolAddressTableViewCell.swift
//  20180210-ElvaLyu-NYCSchools
//
//  Created by Elva Lyu on 2/11/18.
//  Copyright © 2018 Elva Lyu. All rights reserved.
//  @Description: This cell class is for displaying the selected NYC hgig school's location with the annotation added on the map in the detail page.


import UIKit
import MapKit

class HighSchoolAddressTableViewCell: UITableViewCell {

    @IBOutlet weak var highSchoolAddressMapView: MKMapView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func addHighSchoolAnnotaionWithCoordinates(_ highSchoolCoordinates: CLLocationCoordinate2D){

        let highSchoolAnnotation = MKPointAnnotation()
        highSchoolAnnotation.coordinate = highSchoolCoordinates
        self.highSchoolAddressMapView.addAnnotation(highSchoolAnnotation)
        let span = MKCoordinateSpanMake(0.001, 0.001)
        let region = MKCoordinateRegion(center: highSchoolAnnotation.coordinate, span: span)
        let adjustRegion = self.highSchoolAddressMapView.regionThatFits(region)
        self.highSchoolAddressMapView.setRegion(adjustRegion, animated:true)
    }

}
