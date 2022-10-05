//
//  FavoritesCell.swift
//  FakeProfile
//
//  Created by Ali Demirtaş on 4.10.2022.
//

import UIKit

class FavoritesCell: UITableViewCell {

    static let reuseID = "FavoritesCell"
    
    let profileImage = FPImageView(frame: .zero)
    let nameLabel = FPLabel(textAlignment: .left, fontSize: 15, weight: .semibold)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemBrown
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure() {
        addSubview(profileImage)
        addSubview(nameLabel)
        selectionStyle = .none
        accessoryType = .disclosureIndicator
        
        
        
        nameLabel.layer.borderWidth = 0
       
      
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: topAnchor,constant: padding),
            profileImage.leadingAnchor.constraint(equalTo: leadingAnchor,constant: padding),
            profileImage.heightAnchor.constraint(equalToConstant: 75),
            profileImage.widthAnchor.constraint(equalToConstant: 75),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor,constant: padding),
            nameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor,constant: padding),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -padding),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -padding),
            
        ])
    }

}
