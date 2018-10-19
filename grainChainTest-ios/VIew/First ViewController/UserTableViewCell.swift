//
//  UserTableViewCell.swift
//  grainChainTest-ios
//
//  Created by Alfredo Fregoso  on 10/18/18.
//  Copyright © 2018 Alfredo Fregoso . All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    var usuario: Usuario? {
        didSet {
            if let user = usuario {
                nameLabel.text = user.fullName
                extraInfoLabel.text = "Edad: \(user.edad)  -  Tel: \(user.phoneNumber)"
            }
        }
    }
    lazy var imageViewUser: UIImageView = {
        let i = UIImageView(frame: .zero)
        i.translatesAutoresizingMaskIntoConstraints = false
        i.image = UIImage(named: "usuario")
        return i
    }()
    
    lazy var nameLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 2
        l.font = UIFont.boldSystemFont(ofSize: 18.0)
        l.text = "Usuario Desconocido"
        
        return l
    }()
    
    lazy var extraInfoLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = " 0 años - Teléfono: 0000000000"
        l.textColor = UIColor.lightGray
        l.font = l.font.withSize(15.0)
        l.numberOfLines = 2
        
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        [imageViewUser,nameLabel,extraInfoLabel].forEach(contentView.addSubview)
        
        NSLayoutConstraint.activate([
            
            imageViewUser.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            imageViewUser.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageViewUser.widthAnchor.constraint(equalToConstant: 50.0),
            imageViewUser.heightAnchor.constraint(equalToConstant: 50.0),

            nameLabel.leadingAnchor.constraint(equalTo: imageViewUser.trailingAnchor, constant: 20.0),
            nameLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 10.0),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            
            extraInfoLabel.leadingAnchor.constraint(equalTo: imageViewUser.trailingAnchor, constant: 20.0),
            extraInfoLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5.0),
            extraInfoLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            extraInfoLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -20.0)
            ])
    }
}
