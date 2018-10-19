//
//  User.swift
//  grainChainTest-ios
//
//  Created by Alfredo Fregoso  on 10/18/18.
//  Copyright © 2018 Alfredo Fregoso . All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class Usuario: Object {
    @objc dynamic var name = ""
    @objc dynamic var lastName = ""
    @objc dynamic var edad = 0
    @objc dynamic var phoneNumber = 0
    var fullName: String {
        return "\(name) \(lastName)"
    }
}



