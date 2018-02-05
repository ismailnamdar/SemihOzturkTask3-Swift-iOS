//
//  RecordListVC.swift
//  SemihOzturkTask3
//
//  Created by ismail on 04/02/2018.
//  Copyright © 2018 teqwise. All rights reserved.
//

import UIKit
import Alamofire

class RecordListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var containerView: UIView!
    
    var params: Dictionary<String, AnyObject> = [:]
    var records = [Record]()
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Records")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
        refreshControl.beginRefreshing()
        refresh()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getRecords()
    }
    
    func refresh() {
        getRecords()
    }
    
    func getRecords() {
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        
        manager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { response in
                switch (response.result) {
                case .success:
                    if let result = response.result.value {
                        if let JSON = result as? NSDictionary {
                            if let records = JSON["records"] as? NSArray {
                                for data in records {
                                    if let data = data as? Dictionary<String, AnyObject> {
                                        let record = Record(data: data)
                                        self.records.append(record)
                                    }
                                }
                                self.refreshControl.endRefreshing()
                                self.tableView.reloadData()
                            }
                            else {
                                self.present(alertDisplay(title: "Error", message: "", buttonTitle: ok, buttonStyle: UIAlertActionStyle.default, sender: self), animated: true, completion: nil)
                            }
                        }
                        else {
                            self.present(alertDisplay(title: "Error", message: "", buttonTitle: ok, buttonStyle: UIAlertActionStyle.default, sender: self), animated: true, completion: nil)
                        }
                    }
                    else {
                        self.present(alertDisplay(title: "Error", message: "", buttonTitle: ok, buttonStyle: UIAlertActionStyle.default, sender: self), animated: true, completion: nil)
                    }
                    break
                case .failure(let error):
                    if error._code == NSURLErrorTimedOut {
                    }
                    self.present(alertDisplay(title: "Time out!", message: "", buttonTitle: ok, buttonStyle: UIAlertActionStyle.default, sender: self), animated: true, completion: nil)
                    break
                }
                
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell") as? RecordCell{
            let record = records[indexPath.row]
            cell.configureCell(record: record)
            return cell
        }
        else {
            return RecordCell()
        }
    }

}
