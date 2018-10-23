//
//  LoginInViewController.swift
//  grainChainTest-ios
//
//  Created by Alfredo Fregoso  on 10/18/18.
//  Copyright © 2018 Alfredo Fregoso . All rights reserved.
//

import UIKit

class LoginInViewController: UIViewController {
    
    @IBOutlet weak var userNameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextfield.text = "harvx_190878"
        passwordTextfield.text = "supersecretpassword"
        addGestures()
    }

    @IBAction func logInButtonClicked(_ sender: Any) {
        if let user = userNameTextfield.text, let password = passwordTextfield.text {
            APIService().signIn(userName: user, password: password) {
                if (user == "harvx_190878" && password == "supersecretpassword") {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "MainTabController")
                         self.present(vc, animated: true, completion: nil)
                }else {
                    self.presentAlert()
                }
                
            }
            
        }
    }
    
    func addGestures() {
        let hideKeyboard = UITapGestureRecognizer(target: self, action: #selector(tappedToHideKeyboard))
        view.addGestureRecognizer(hideKeyboard)
    }
    
    @objc func tappedToHideKeyboard() {
        view.endEditing(true)
    }
    
    func loginToTheViewController() {
    
    }
    
    func presentAlert() {
        let alertController = UIAlertController(title: "Acceso denegado", message: "Tu usuario o contraseña son incorrectos", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default) { (_) in
            self.userNameTextfield.text = ""
            self.passwordTextfield.text = ""
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func logInButtonClicked() {
        loginToTheViewController()
    }
}
