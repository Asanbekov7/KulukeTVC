//
//  MainViewController.swift
//  KulukeTVC
//
//  Created by Темирлан Асанбеков on 20/2/23.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    private let searchController = UISearchController(searchResultsController: nil)
    private var storages: Results<Storage>!
    private var filteredStorages: Results<Storage>!
    private var ascendingSorting = true
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var reversSortingButton: UIBarButtonItem!
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        storages = realm.objects(Storage.self)
 
        // Setup search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    // MARK: - Table view data source


//
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if isFiltering {
             return filteredStorages.count
         }
         
        return storages.isEmpty ? 0 : storages.count
    }

//
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

         var storageArray = Storage()
         if isFiltering {
             storageArray = filteredStorages[indexPath.row]
         } else {
             storageArray = storages[indexPath.row]
         }
        
        cell.nameLabel.text = storageArray.name
        cell.sizeLabel.text = storageArray.size
        cell.manufactureLabel.text = storageArray.manufacture
        cell.imageOfProducts.image = UIImage(data: storageArray.imageData!)
     

        cell.imageOfProducts.layer.cornerRadius = cell.imageOfProducts.frame.size.height / 2
        cell.imageOfProducts.clipsToBounds = true


        return cell
    }
    //MARK: Table View Delegate метод протокола позволяющая вызывать различные пункты меню свайпом по ячейке с право в лево

     func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let storage = storages[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            // Удаление ячейки
            StorageManager.deleteObject(storage)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }


    

    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let storage: Storage
            if isFiltering {
                storage = filteredStorages[indexPath.row]
            } else {
                storage = storages[indexPath.row]
            }
            let newStorageVC = segue.destination as! NewStorageViewController
            newStorageVC.currentStorage = storage
        }
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        guard let newStorageVC = segue.source as? NewStorageViewController else {return}
        newStorageVC.saveStorage()
        
        tableView.reloadData()
    }
    
    @IBAction func sortSelection(_ sender: UISegmentedControl) {
        
        sorting()
    }
    
    @IBAction func reversSorting(_ sender: Any) {
        ascendingSorting.toggle()
        
        if ascendingSorting {
            reversSortingButton.image = UIImage(imageLiteralResourceName: "AZ")
        } else {
            reversSortingButton.image = UIImage(imageLiteralResourceName: "ZA")
        }
        sorting()
    }
    
    private func sorting() {
        if segmentedControl.selectedSegmentIndex == 0 {
            storages = storages.sorted(byKeyPath: "date", ascending: ascendingSorting)
        } else {
            storages = storages.sorted(byKeyPath: "name", ascending: ascendingSorting)
        }
        
        tableView.reloadData()
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    private func filterContentForSearchText(_ searchText: String) {
        filteredStorages = storages.filter("name CONTAINS[c] %@ or manufacture CONTAINS[c] %@", searchText, searchText)
        tableView.reloadData()
    }
    
}
