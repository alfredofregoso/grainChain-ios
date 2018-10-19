//
//  FirstViewController.swift
//  grainChainTest-ios
//
//  Created by Alfredo Fregoso  on 10/18/18.
//  Copyright © 2018 Alfredo Fregoso . All rights reserved.
//

import UIKit
import RealmSwift

class FirstViewController: UIViewController {
    let cellId = "cellId"
    var users: Results<Usuario>!
    var filteredUsers: Results<Usuario>!
    var isSearching = false
  
    lazy var tableView: UITableView = {
        let t = UITableView(frame: .zero)
        t.translatesAutoresizingMaskIntoConstraints = false
        t.register(UserTableViewCell.self, forCellReuseIdentifier: cellId)
        t.tableHeaderView = searchController.searchBar
        t.delegate = self
        t.dataSource = self
        
        return t
    }()
    
    lazy var searchController: UISearchController = {
        let s = UISearchController(searchResultsController: nil)
        s.hidesNavigationBarDuringPresentation = false
        s.searchBar.delegate = self
        return s
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditing))
        navigationItem.rightBarButtonItem = editButton
        createUsers()
        
        UserDefaults.standard.set(true, forKey: "loggedInBefore")
        let realm = RealmService.shared.realm
        users = realm.objects(Usuario.self)
        //creatingSearhBar()
        
        view.backgroundColor = UIColor.gray
        setUpViews()
        addGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func setUpViews() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
            ])
    }
    
    @objc func toggleEditing() {
        if tableView.isEditing == true {
            tableView.setEditing(false, animated: true)
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditing))
        } else {
            tableView.setEditing(true, animated: true)
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(toggleEditing))
        }
    }
    
    func addGestures() {
        let hideKeyboard = UITapGestureRecognizer(target: self, action: #selector(tappedToHideKeyboard))
        view.addGestureRecognizer(hideKeyboard)
    }
    
    @objc func tappedToHideKeyboard() {
        view.endEditing(true)
    }
    
    func creatingSearhBar() {
        let searchController = UISearchController(searchResultsController: nil)
        //searchController.searchResultsUpdater =
        searchController.searchBar.delegate = self
        searchController.searchBar.returnKeyType = .done
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func createUsers() {
       
        if UserDefaults.standard.bool(forKey: "loggedInBefore") == false{
            let user1 = Usuario(value: ["Alfredo","Fregoso",23,3139626452])
            RealmService.shared.create(user1)
            let user2 = Usuario(value: ["José","Verduzco",14,4123234234])
            RealmService.shared.create(user2)
            let user3 = Usuario(value: ["Pablo","Herrera",54,5345345])
            RealmService.shared.create(user3)
            let user4 = Usuario(value: ["Ángel","Salazar",34,456456456])
            RealmService.shared.create(user4)
            let user5 = Usuario(value: ["Antonio","Hernandez",76,64564564])
            RealmService.shared.create(user5)
            let user6 = Usuario(value: ["Everardo","Fregoso",54,3453453])
            RealmService.shared.create(user6)
            let user7 = Usuario(value: ["Joel","Fregoso",54,78978978])
            RealmService.shared.create(user7)
            let user8 = Usuario(value: ["Alejandro","Fregoso",64,34534])
            RealmService.shared.create(user8)
            let user9 = Usuario(value: ["Gabriel","Fregoso",53,890890])
            RealmService.shared.create(user9)
            let user10 = Usuario(value: ["Adriana","Fregoso",12,234234234])
            RealmService.shared.create(user10)
        }
    }

}

extension FirstViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredUsers.count
        }
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserTableViewCell
        cell.selectionStyle = .none
        
        if isSearching {
            cell.usuario = filteredUsers[indexPath.row]
        }else {
            cell.usuario = users[indexPath.row]
        }
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "¿Desea eliminar a \(users[indexPath.row].name)?", message: "Una vez eliminado el usuario, no se podrá recuperar", preferredStyle: .alert)
            let actionOk = UIAlertAction(title: "Ok", style: .default) { (_) in
                let user = self.users[indexPath.row]
                RealmService.shared.delete(user)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
            }
            let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(actionOk)
            alert.addAction(actionCancel)
            present(alert, animated: true, completion: nil)
        }
    }
}

extension FirstViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            isSearching = true
            let predicate = NSPredicate(format: "name BEGINSWITH %@",searchText)
            filteredUsers = RealmService.shared.realm.objects(Usuario.self).filter(predicate)
        } else {
            isSearching = false
            filteredUsers = users
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isEditing = false
        filteredUsers = users
        tableView.reloadData()
    }
}
