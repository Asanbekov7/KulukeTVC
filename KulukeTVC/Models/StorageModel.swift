//
//  StorageModel.swift
//  KulukeTVC
//
//  Created by Темирлан Асанбеков on 20/2/23.
//

import UIKit

struct Storage {
    var name: String
    var size: String?
    var manufacture: String?
    var image: UIImage?
    var storageImage: String?
    
   static let storageMaterials = ["Armatura", "Profilnaya Truba", "Listi", "Kruglie Trubi", "Shvelleri", "Fanera 18", "Dvutavr", "Ugolki"]
    
    
   static func getStorage() -> [Storage] {
        
       var storages = [Storage]()
        
        for storage in storageMaterials {
            storages.append(Storage(name: storage, size: "Размер продукта", manufacture: "made in Russia", image: nil, storageImage: storage))
        }
        return storages
    }
}
