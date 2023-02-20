//
//  MainViewController.swift
//  KulukeTVC
//
//  Created by Темирлан Асанбеков on 20/2/23.
//

import UIKit

class MainViewController: UITableViewController {


    
    let storage = Storage.getStorage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

 
    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storage.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        cell.nameLabel.text = storage[indexPath.row].name
        cell.sizeLabel.text = storage[indexPath.row].size
        cell.manufactureLabel.text = storage[indexPath.row].manufacture
        cell.imageOfProducts.image = UIImage(named: storage[indexPath.row].image)
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

}
