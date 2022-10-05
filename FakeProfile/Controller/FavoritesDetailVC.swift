//
//  FavoritesDetailVC.swift
//  FakeProfile
//
//  Created by Ali Demirtaş on 5.10.2022.
//

import UIKit

class FavoritesDetailVC: UIViewController {

    let profileImage = FPImageView(frame: .zero)
    let nameLabel = FPLabel(textAlignment: .left, fontSize: 15, weight: .semibold)
    let countryLabel = FPLabel(textAlignment: .left, fontSize: 15, weight: .semibold)
    let emailLabel = FPLabel(textAlignment: .left, fontSize: 15, weight: .semibold)
    let phoneLabel = FPLabel(textAlignment: .left, fontSize: 15, weight: .semibold)
    let adressLabel = FPLabel(textAlignment: .center, fontSize: 15, weight: .semibold)
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        view.backgroundColor = .systemBrown
        configureUI()
    }
    
    
    func configureUI() {
        view.addSubview(profileImage)
        view.addSubview(nameLabel)
        view.addSubview(countryLabel)
        view.addSubview(emailLabel)
        view.addSubview(phoneLabel)
        view.addSubview(adressLabel)
       
        
        let height: CGFloat = 30
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.50),
            profileImage.heightAnchor.constraint(equalTo: profileImage.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor,constant: padding),
            nameLabel.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor, constant: -40),
            nameLabel.trailingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 40),
            nameLabel.heightAnchor.constraint(equalToConstant: height),
            
            countryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: padding),
            countryLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            countryLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            countryLabel.heightAnchor.constraint(equalToConstant: height),
            
            emailLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor,constant: padding),
            emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            emailLabel.heightAnchor.constraint(equalToConstant: height),
            
            phoneLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor,constant: padding),
            phoneLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            phoneLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            phoneLabel.heightAnchor.constraint(equalToConstant: height),
            
            adressLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor,constant: padding),
            adressLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            adressLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            adressLabel.heightAnchor.constraint(equalToConstant: height*3),
            
        ])
    }

}
