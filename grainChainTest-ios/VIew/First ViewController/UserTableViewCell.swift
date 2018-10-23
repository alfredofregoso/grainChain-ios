//
//  UserTableViewCell.swift
//  grainChainTest-ios
//
//  Created by Alfredo Fregoso  on 10/18/18.
//  Copyright © 2018 Alfredo Fregoso . All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var imageViewUser: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var extraInfoLabel: UILabel!
    
    var usuario: Usuario? {
        didSet {
            if let user = usuario {
                nameLabel.text = user.fullName
                extraInfoLabel.text = "Edad: \(user.edad)  -  Tel: \(user.phoneNumber)"
                imageViewUser.image = UIImage(named: "usuario")
            }
        }
    }
}
