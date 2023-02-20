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
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
            }
            
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            
            present(actionSheet, animated: true)
            
            
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

//MARK: Работа над картинкой 1 ячейки

extension NewStorageViewController {
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
}
