//
//  NextViewController.swift
//  MapApp
//
//  Created by poti on 2020/04/13.
//  Copyright © 2020 kaoru. All rights reserved.
//

import UIKit

protocol SearchLocationDelegete{
    func searchLocation(idoValue: String, keidoValue: String)
}

class NextViewController: UIViewController {


    @IBOutlet weak var idoTextField: UITextField!
    
    @IBOutlet weak var keidoTextField: UITextField!
    
    var delegate: SearchLocationDelegete?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    @IBAction func sendAction(_ sender: Any) {
        let idoValue = idoTextField.text!
        
        let keidoValue = keidoTextField.text!
        
        
        if idoTextField.text != nil && keidoTextField.text != nil{
            
            delegate?.searchLocation(idoValue: idoValue, keidoValue: keidoValue)
            dismiss(animated: true, completion: nil)
        }
        
    }
    
}
