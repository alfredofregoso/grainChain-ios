//
//  MainTabBarController.swift
//  grainChainTest-ios
//
//  Created by Alfredo Fregoso  on 10/18/18.
//  Copyright © 2018 Alfredo Fregoso . All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    var userName = String()
    private lazy var firstViewController: UINavigationController = {
        let v = FirstViewController()
        v.title = userName
        let n = UINavigationController(rootViewController: v)
        n.tabBarItem = UITabBarItem(title: "Users", image: UIImage(named: "user"), selectedImage: UIImage(named:"user-select"))
        n.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        n.navigationBar.isTranslucent = false
        n.navigationBar.barTintColor = UIColor(red: 28/255, green: 31/255, blue: 55/255, alpha: 1.0)
        
        return n
    }()
    
    private lazy var secondViewController: UINavigationController = {
        let v = SecondViewController()
        v.title = userName
        let n = UINavigationController(rootViewController: v)
        n.tabBarItem = UITabBarItem(title: "Form", image: UIImage(named: "form"), selectedImage: UIImage(named: "form-select"))
        n.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        n.navigationBar.isTranslucent = false
        n.navigationBar.barTintColor = UIColor(red: 28/255, green: 31/255, blue: 55/255, alpha: 1.0)
        
        
        return n
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = UserDefaults.standard.string(forKey: "userName") {
            userName = user
        }
        viewControllers = [firstViewController,secondViewController]
    }

}
