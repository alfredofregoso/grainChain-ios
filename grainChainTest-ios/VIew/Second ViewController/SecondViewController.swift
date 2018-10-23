//
//  SecondViewController.swift
//  grainChainTest-ios
//
//  Created by Alfredo Fregoso  on 10/18/18.
//  Copyright © 2018 Alfredo Fregoso . All rights reserved.
//

import UIKit
import RealmSwift

class SecondViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberLabel: UITextField!
    @IBOutlet weak var ageTextField: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        addGestures()
    }
    
    @IBAction func createNewUserClicked(_ sender: Any) {
        let user = Usuario()
        if let name = nameTextField.text, let lastName = lastNameTextField.text, let phoneNumber = nameTextField.text, let age = ageTextField.text {
            user.name = name
            user.lastName = lastName
            user.edad = Int(age) ?? 0
            user.phoneNumber = Int(phoneNumber) ?? 0000000
            
            RealmService.shared.create(user)
        }
        showCompleteAlert()
    }
 
    func showCompleteAlert() {
        view.endEditing(true)
        let alertController = UIAlertController(title: "Usuario creado", message: "Has creado un nuevo usuario", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true) {
            self.nameTextField.text = ""
            self.lastNameTextField.text = ""
            self.ageTextField.text = ""
            self.phoneNumberLabel.text = ""
        }
    }
    
    func addGestures() {
        let hideKeyboard = UITapGestureRecognizer(target: self, action: #selector(tappedToHideKeyboard))
        view.addGestureRecognizer(hideKeyboard)
    }
    
    @objc func tappedToHideKeyboard() {
        view.endEditing(true)
    }
    
}
