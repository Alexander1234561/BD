//
//  NameUserDefaultViewController.swift
//  BD
//
//  Created by Александр on 14.10.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import UIKit

class NameUserDefaultViewController: UIViewController {
    
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var surnameLabel: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let fn = FullName.shared.fullName { lastNameLabel.text = fn }
        else { lastNameLabel.text = "Full Name" }
    }
    
    @IBAction func submitAction(_ sender: UIButton) {
        if let n = nameLabel.text,
            let s = surnameLabel.text{
            let fN = FullName(fn: "Last submit: \(n) \(s)")
            lastNameLabel.text = fN.fullName
        }
        
    }
    
}
