//
//  NewStorageViewController.swift
//  KulukeTVC
//
//  Created by Темирлан Асанбеков on 20/2/23.
//

import UIKit

class NewStorageViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // данный метод нужен для избавление от лишей разлиновки где нет контента под TableVIewCell
        tableView.tableFooterView = UIView()
  
    }
    
    //MARK: - Table View Delegate
    // данный метод нужен для работы с ячейками где по нажатию клавиатура будет скрываться относительно логики метода
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
        } else {
            view.endEditing(true)
        }
    }

 
}

//MARK: - Text Field Delegate

extension NewStorageViewController: UITextFieldDelegate {
    // Скрываем клавиатуру по нажатию на Done
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
