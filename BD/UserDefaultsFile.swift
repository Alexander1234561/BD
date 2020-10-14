//
//  UserDefaultsFile.swift
//  BD
//
//  Created by Александр on 14.10.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import Foundation


class FullName {
    
    static let shared = FullName()
    
    let kUserNameKey = "FullName.kUserNameKey"
    var fullName: String? {
        set{ UserDefaults.standard.set(newValue, forKey: kUserNameKey) }
        get{ return UserDefaults.standard.string(forKey: kUserNameKey) }
    }
    
    init(fn: String) {
        self.fullName = fn
    }
    init() { }
}
