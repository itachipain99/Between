//
//  DBManager.swift
//  Between
//
//  Created by Nguyễn Minh Hiếu on 3/11/20.
//  Copyright © 2020 Nguyễn Minh Hiếu. All rights reserved.
//

import Foundation
import RealmSwift

let queue = DispatchQueue(label: "queue")

class DBManager{
    //bien chua tham chieu csdl
    
    private var database : Realm
    //bien chua thuc the duy nhat cua DB
    static let shared = DBManager()
    
    private init() {
        database = try! Realm()
    }
    
    func getData() -> Results<User>? {
        let result : Results<User> = database.objects(User.self)
        return result
    }
    
//    func addData(_ dataEmail : String,_ dataPassword : String,_ dataName : String,_ dataNamepathner : String,_ dataDayBegin : Date,_ dataDaysLove : Int) {
//        let object = User()
//        object.email = dataEmail
//        object.password = dataPassword
//        object.name = dataName
//        object.namePathner = dataNamepathner
//        object.dayBegin = dataDayBegin
//        object.dayloves = dataDaysLove
//        
//        try! database.write {
//            database.add(object)
//            print("success")
//        }
//    }
    func search(_ object : Object.Type ,filter : String,key : String) -> Results<Object> {
        let predicate = NSPredicate(format: "\(key) = '\(filter)'")
        var result  = try database.objects(object).filter(predicate)
        return result
    }
    
    func uppdate(_ object : Object , update:() -> ()){
        update()
        do{
            try! database.write {
                database.add(object, update: true)
                print("done")
            }
        }catch{}
    }
    
    func add(_ object : Object, addf:() -> () ) {
        addf()
        try! database.write {
            database.add(object)
            print("success")
        }
    }
}
