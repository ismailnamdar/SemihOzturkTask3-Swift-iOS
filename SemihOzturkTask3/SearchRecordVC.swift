//
//  SearchRecordVC.swift
//  SemihOzturkTask3
//
//  Created by ismail on 04/02/2018.
//  Copyright © 2018 teqwise. All rights reserved.
//

import UIKit
import Alamofire

class SearchRecordVC: UIViewController {

    @IBOutlet weak var startDate: UIButton!
    @IBOutlet weak var endDate: UIButton!
    @IBOutlet weak var minCount: UITextField!
    @IBOutlet weak var maxCount: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var chooseButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var datePickerView: UIView!

    var datePickerHidden: Bool!
    var isStartDate: Bool!
    
    var params: [String: AnyObject] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePickerHidden = true
        isStartDate = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
       params = [
            "startDate": "2016-01-26" as AnyObject,
            "endDate": "2017-02-02" as AnyObject,
            "minCount" : 2700 as AnyObject,
            "maxCount" : 3000 as AnyObject
        ]
    }
    
    func toggleDatePickerView() {
        datePickerView.isHidden = !datePickerHidden
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale.init(identifier: "en_GB")
        
        let dateString = dateFormatter.string(from:date as Date)
        
        return dateString
    }
    
    @IBAction func startDatePressed(_ sender: Any) {
        toggleDatePickerView()
        isStartDate = true
    }
    
    @IBAction func endDatePressed(_ sender: Any) {
        toggleDatePickerView()
        isStartDate = false
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        if let minCount = minCount.text, let maxCount = maxCount.text {
            if Int(minCount) != nil && Int(maxCount) != nil{
                params["minCount"] = minCount as AnyObject
                params["maxCount"] = maxCount as AnyObject
                
                self.performSegue(withIdentifier: "goToRecordListVC", sender: params)
            }
            else {
                // Error
                self.present(alertDisplay(title: "Min count and max count must be integer", message: "", buttonTitle: ok, buttonStyle: UIAlertActionStyle.default, sender: nil), animated: true, completion: nil)
            }
        }
        else {
            // Error
            self.present(alertDisplay(title: "Error", message: "", buttonTitle: ok, buttonStyle: UIAlertActionStyle.default, sender: nil), animated: true, completion: nil)
        }

    }
    
    @IBAction func chooseButtonPressed(_ sender: Any) {
        datePickerView.isHidden = true
        let dateString = formatDate(date: datePicker.date)
        
        if isStartDate {
            startDate.setTitle(dateString, for: .normal)
            params["startDate"] = dateString as AnyObject
        }
        else {
            endDate.setTitle(dateString, for: .normal)
            params["endDate"] = dateString as AnyObject
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        datePickerView.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RecordListVC{
            
            if let parameters = sender as? Dictionary<String, AnyObject>{
                destination.params = parameters
            }
        }
    }
    
}
