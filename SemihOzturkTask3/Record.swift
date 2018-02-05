//
//  Record.swift
//  SemihOzturkTask3
//
//  Created by ismail on 31/01/2018.
//  Copyright © 2018 teqwise. All rights reserved.
//

import Foundation

class Record {
    private var _id: String!
    private var _createdAt: String!
    private var _key: String!
    private var _value: String!
    private var _totalCount: Int!
    
    var id: String {
        return _id
    }
    
    var createdAt: String {
        return _createdAt
    }
    
    var key: String {
        return _key
    }
    
    var value: String {
        return _value
    }
    
    var totalCount: Int {
        return _totalCount
    }
    
    init(data: Dictionary<String, AnyObject>) {
        if let count = data["totalCount"] as? Int {
            _totalCount = count
        }
        
        if let data = data["_id"] as? Dictionary<String, AnyObject> {
            if let id = data["_id"] as? String {
                _id = id
            }
            
            if let createdAt = data["createdAt"] as? String {
                _createdAt = createdAt
            }
            
            if let key = data["key"] as? String {
                _key = key
            }
            
            if let val = data["value"] as? String {
                _value = val
            }
        }
    }
}
