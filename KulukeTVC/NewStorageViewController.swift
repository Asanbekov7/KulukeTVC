//
//  NewStorageViewController.swift
//  KulukeTVC
//
//  Created by Темирлан Асанбеков on 20/2/23.
//

import UIKit

class NewStorageViewController: UITableViewController, UINavigationControllerDelegate {
    
    var currentStorage: Storage?
  
    var imageIsChange = false
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var placeSize: UITextField!
    @IBOutlet weak var placeManufacture: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // данный метод нужен для избавление от лишей разлиновки где нет контента под TableVIewCell
        tableView.tableFooterView = UIView()
  
        saveButton.isEnabled = false
        
        placeName.addTarget(self, action: #selector(textFieldChanged) , for: .editingChanged)
        setupEditScreen()
    }
    
    //MARK: - Table View Delegate
    // данный метод нужен для работы с ячейками где по нажатию клавиатура будет скрываться относительно логики метода
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cameraIcon = UIImage(imageLiteralResourceName: "camera")
        let photoIcon = UIImage(imageLiteralResourceName: "photo")
        
        if indexPath.row == 0 {
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
            }
            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            photo.setValue(photoIcon, forKey: "image")
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            
            present(actionSheet, animated: true)
            
            
        } else {
            view.endEditing(true)
        }
        }
    func saveStorage() {
        
        
        
        var image: UIImage?
        
        if imageIsChange {
            image = placeImage.image
        } else {
            image = UIImage(imageLiteralResourceName: "photomat")
        }
        
        
        let imageData = image?.pngData()
        
        let newStorage = Storage(name: placeName.text!, size: placeSize.text, manufacture: placeManufacture.text, imageData: imageData)
        
        if currentStorage != nil {
            try! realm.write {
                currentStorage?.name = newStorage.name
                currentStorage?.manufacture = newStorage.manufacture
                currentStorage?.size = newStorage.size
                currentStorage?.imageData = newStorage.imageData
            }
        } else {
            StorageManager.saveObject(newStorage)
        }
    }
    
    private func setupEditScreen() {
        if currentStorage != nil {
            
            setupNavigationBar()
            imageIsChange = true
            
            guard let data = currentStorage?.imageData, let image = UIImage(data: data) else {return}
            placeImage.image = image
            placeImage.contentMode = .scaleAspectFit
            placeName.text = currentStorage?.name
            placeManufacture.text = currentStorage?.manufacture
            placeSize.text = currentStorage?.size
        }
    }
 
    private func setupNavigationBar() {
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        navigationItem.leftBarButtonItem = nil
        title = currentStorage?.name
        saveButton.isEnabled = true
    }
    
    @IBAction func cancelAtion(_ sender: Any) {
        dismiss(animated: true)
    }
}

//MARK: - Text Field Delegate

extension NewStorageViewController: UITextFieldDelegate {
    // Скрываем клавиатуру по нажатию на Done
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChanged() {
        
        if placeName.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
}

//MARK: Данный метод позволяет юзеру редактировать изображение

extension NewStorageViewController: UIImagePickerControllerDelegate {
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    //MARK: Данный метод нужен для того что бы присвоить реадктированное изображение в imageOfStorage
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        placeImage.image = info[.editedImage] as? UIImage
        placeImage.contentMode = .scaleAspectFill
        placeImage.clipsToBounds = true
        
        imageIsChange = true
        
        dismiss(animated: true)
    }
}
