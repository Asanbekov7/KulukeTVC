//
//  StorageManager.swift
//  KulukeTVC
//
//  Created by Темирлан Асанбеков on 27/2/23.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveObject(_ storage: Storage) {
        
        
        try! realm.write {
            realm.add(storage)
        }
    }
    
//    теперь надо создать метод который будет возвращать данные из базы данных в распарсенном виде твоей модели Storage
//    распарсить данные модели для realm
//    что такое распарсить - парсинг данных json
}
