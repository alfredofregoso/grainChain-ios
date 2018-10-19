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
    lazy var infoLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Create a new user"
        l.textAlignment = .center
        l.font = UIFont.boldSystemFont(ofSize: 20.0)
        l.numberOfLines = 2
        return l
    }()
    
    lazy var nameTextField: UITextField = {
        let t = UITextField(frame: .zero)
        t.translatesAutoresizingMaskIntoConstraints = false
        t.placeholder = "Name"
        t.textAlignment = .center
        t.borderStyle = .roundedRect
        return t
    }()
    
    lazy var lastNameTextField: UITextField = {
        let t = UITextField(frame: .zero)
        t.translatesAutoresizingMaskIntoConstraints = false
        t.placeholder = "Lastname"
        t.textAlignment = .center
        t.borderStyle = .roundedRect
        return t
    }()
    
    lazy var ageTextField: UITextField = {
        let t = UITextField(frame: .zero)
        t.translatesAutoresizingMaskIntoConstraints = false
        t.placeholder = "Age"
        t.textAlignment = .center
        t.borderStyle = .roundedRect
        return t
    }()
    
    lazy var phoneTextField: UITextField = {
        let t = UITextField(frame: .zero)
        t.translatesAutoresizingMaskIntoConstraints = false
        t.placeholder = "Phone Number"
        t.textAlignment = .center
        t.borderStyle = .roundedRect
        return t
    }()
    
    lazy var stackView: UIStackView = {
        let s = UIStackView(frame: .zero)
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .vertical
        s.distribution = .equalSpacing
        s.alignment = .center
        s.spacing = 1.0
        
        return s
    }()
    
    lazy var newUserButton: UIButton = {
        let b = UIButton(frame: .zero)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(createNewUser), for: .touchUpInside)
        b.setTitle("Create user", for: .normal)
        b.backgroundColor = UIColor.orange
        
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        addGestures()
        setUpViews()
    }
    
    func setUpViews() {
        [nameTextField,lastNameTextField,phoneTextField,ageTextField].forEach(stackView.addArrangedSubview)
        [infoLabel,stackView,newUserButton].forEach(view.addSubview)
        

        
        NSLayoutConstraint.activate([
            
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30.0),
            infoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40.0),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30.0),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30.0),
            stackView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 20.0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30.0),
            stackView.heightAnchor.constraint(equalToConstant: 150),
            
            newUserButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20.0),
            newUserButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newUserButton.widthAnchor.constraint(equalToConstant: 150.0)
            
            ])
    }
    
    @objc func createNewUser() {
        let user = Usuario()
        if let name = nameTextField.text, let lastName = lastNameTextField.text, let phoneNumber = phoneTextField.text, let age = ageTextField.text {
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
            self.phoneTextField.text = ""
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
