//
//  User.swift
//  Between
//
//  Created by Nguyễn Minh Hiếu on 3/11/20.
//  Copyright © 2020 Nguyễn Minh Hiếu. All rights reserved.
//

import Foundation
import RealmSwift

class User : Object {
    @objc dynamic var email : String?
    @objc dynamic var password : String?
    @objc dynamic var name : String?
    @objc dynamic var namePartner : String?
    @objc dynamic var gender : Bool = false
    @objc dynamic var dayBegin : Date?
    
    override static func primaryKey() -> String? {
        return "email"
    }
}
class Partner : Object {
    @objc dynamic var key : String?
    @objc dynamic var photoPathner : Data?
    @objc dynamic var birthDayPartner : Date?
    @objc dynamic var emailPartner : String?
    @objc dynamic var number : String?
    override static func primaryKey() -> String? {
        return "key"
    }
}
class YourSelf : Object {
    @objc dynamic var key : String?
    @objc dynamic var photoYourself : Data?
    @objc dynamic var birthDayYourself : Date?
    
    override static func primaryKey() -> String? {
        return "key"
    }
}
