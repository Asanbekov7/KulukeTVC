//
//  StorageModel.swift
//  KulukeTVC
//
//  Created by Темирлан Асанбеков on 20/2/23.
//

import RealmSwift
import UIKit

class Storage: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var size: String?
    @objc dynamic var manufacture: String?
    @objc dynamic var imageData: Data?
   
    convenience init(name: String, size: String?, manufacture: String?, imageData: Data?) {
    
        self.init()
        self.name = name
        self.size = size
        self.manufacture = manufacture
        self.imageData = imageData
    }
}
