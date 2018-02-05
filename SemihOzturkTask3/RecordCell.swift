//
//  RecordCell.swift
//  SemihOzturkTask3
//
//  Created by ismail on 05/02/2018.
//  Copyright © 2018 teqwise. All rights reserved.
//

import UIKit

class RecordCell: UITableViewCell {
    
    @IBOutlet weak var _id: UILabel!
    @IBOutlet weak var key: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    @IBOutlet weak var totalCount: UILabel!

    func configureCell(record: Record) {
        _id.text = "_id: " + record.id
        key.text = "key: " + record.key
        value.text = "value: " + record.value
        createdAt.text = "createdAt: " + record.createdAt
        totalCount.text = "totalCount: \(record.totalCount)"
    }

}
