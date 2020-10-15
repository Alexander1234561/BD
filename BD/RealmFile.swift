//
//  RealmFile.swift
//  BD
//
//  Created by Александр on 14.10.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import RealmSwift
import Foundation

class ToDo: Object{
    @objc dynamic var nameDo = ""
    @objc dynamic var todo = false
}
