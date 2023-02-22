//
//  MainViewController.swift
//  KulukeTVC
//
//  Created by Темирлан Асанбеков on 20/2/23.
//

import UIKit

class MainViewController: UITableViewController {
   


    
    var storages = Storage.getStorage()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

 
    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storages.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        let storageArray = storages[indexPath.row]
        cell.nameLabel.text = storageArray.name
        cell.sizeLabel.text = storageArray.size
        cell.manufactureLabel.text = storageArray.manufacture
        
        if storageArray.image == nil {
            cell.imageOfProducts.image = UIImage(named: storageArray.storageImage!)
        } else {
            cell.imageOfProducts.image = storageArray.image
        }
        
        
        cell.imageOfProducts.layer.cornerRadius = cell.imageOfProducts.frame.size.height / 2
        cell.imageOfProducts.clipsToBounds = true

        
        return cell
    }

    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        guard let newStorageVC = segue.source as? NewStorageViewController else {return}
        newStorageVC.saveNewStorage()
        storages.append(newStorageVC.newStorage!)
        tableView.reloadData()
    }
    
    

}
