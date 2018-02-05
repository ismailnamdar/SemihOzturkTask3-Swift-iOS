//
//  Common.swift
//  SemihOzturkTask3
//
//  Created by ismail on 05/02/2018.
//  Copyright © 2018 teqwise. All rights reserved.
//

import Foundation
import UIKit

func popUpToParent(sender: UIViewController) -> (){
    sender.navigationController?.popViewController(animated: true)
}

func alertDisplay(title: String, message: String?, buttonTitle: String, buttonStyle: UIAlertActionStyle, sender: UIViewController?) -> UIAlertController{
    
    let alert = UIAlertController(title: title,message: message, preferredStyle: UIAlertControllerStyle.alert)

    if sender != nil{
        alert.addAction(UIAlertAction(title: buttonTitle, style: buttonStyle, handler:{action in popUpToParent(sender: sender!)}))
    }else{
        alert.addAction(UIAlertAction(title: buttonTitle, style: buttonStyle, handler: nil))
    }
    
    return alert
}
