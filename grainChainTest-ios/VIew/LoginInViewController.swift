//
//  LoginInViewController.swift
//  grainChainTest-ios
//
//  Created by Alfredo Fregoso  on 10/18/18.
//  Copyright © 2018 Alfredo Fregoso . All rights reserved.
//

import UIKit

class LoginInViewController: UIViewController {
    lazy var imageLogo: UIImageView = {
        let i = UIImageView(frame: .zero)
        i.translatesAutoresizingMaskIntoConstraints = false
        i.image = UIImage(named: "grainChain")
        i.contentMode = .scaleAspectFit
        return i
    }()
    
    lazy var userTextField: UITextField = {
        let t = UITextField(frame: .zero)
        t.translatesAutoresizingMaskIntoConstraints = false
        t.placeholder = "Enter username"
        t.text = "harvx_190878"
        t.textAlignment = .center
        t.borderStyle = .roundedRect
        
        return t
    }()
    
    lazy var passwordTextField: UITextField = {
        let t = UITextField(frame: .zero)
        t.translatesAutoresizingMaskIntoConstraints = false
        t.placeholder = "Enter password"
        t.text = "supersecretpassword"
        t.isSecureTextEntry = true
        t.textAlignment = .center
        t.borderStyle = .roundedRect

        return t
    }()
    
    lazy var logInButton: UIButton = {
        let b = UIButton(frame: .zero)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(logInButtonClicked), for: .touchUpInside)
        b.setTitle("Log in", for: .normal)
        b.backgroundColor = UIColor.orange
        
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addGestures()
        setUpViews()
    }
    
    func setUpViews() {
        [userTextField, passwordTextField, logInButton, imageLogo].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            
            imageLogo.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 40.0),
            imageLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageLogo.widthAnchor.constraint(equalToConstant: 150.0),
            imageLogo.heightAnchor.constraint(equalToConstant: 150.0),
            
            userTextField.topAnchor.constraint(equalTo: imageLogo.bottomAnchor, constant: 30.0),
            userTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 30.0),
            userTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -30.0),
            
            passwordTextField.topAnchor.constraint(equalTo: userTextField.bottomAnchor, constant: 10.0),
            passwordTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 30.0),
            passwordTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -30.0),
            
            logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30.0),
            logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logInButton.widthAnchor.constraint(equalToConstant: 80.0),
            logInButton.heightAnchor.constraint(equalToConstant: 40.0)
            
            
            ])
    }
    
    func addGestures() {
        let hideKeyboard = UITapGestureRecognizer(target: self, action: #selector(tappedToHideKeyboard))
        view.addGestureRecognizer(hideKeyboard)
    }
    
    @objc func tappedToHideKeyboard() {
        view.endEditing(true)
    }
    
    func loginToTheViewController() {
        if let user = userTextField.text, let password = passwordTextField.text {
            APIService().signIn(userName: user, password: password) {
                let mainTabController = MainTabBarController()
                self.present(mainTabController, animated: true, completion: nil)
            }
        }
    }
    
    @objc func logInButtonClicked() {
        loginToTheViewController()
    }
}
