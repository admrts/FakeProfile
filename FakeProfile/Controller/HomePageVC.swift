//
//  HomePageVC.swift
//  FakeProfile
//
//  Created by Ali Demirtaş on 4.10.2022.
//

import UIKit

class HomePageVC: UIViewController {

   
    let createButton = FPButton(color: .black, title: "Create Profile",systemName: "plus.app")
    let favoriteButton = FPButton(color: .systemRed, title: "Favorite Profiles", systemName: "heart.fill")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBrown
        
        configureUI()
        actions()
    }
    
    func actions() {
        createButton.addTarget(self, action: #selector(tapCreate), for: .touchUpInside)
        favoriteButton.addTarget(self, action: #selector(tapFavorite), for: .touchUpInside)
    }
    
    @objc func tapCreate() {
        navigationController?.pushViewController(RandomProfileVC(), animated: true)
    }
    @objc func tapFavorite() {
        navigationController?.pushViewController(FavoritesVC(), animated: true)
    }

    
    private func configureUI() {
        view.addSubview(createButton)
        view.addSubview(favoriteButton)

        
        
        NSLayoutConstraint.activate([
            createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            createButton.heightAnchor.constraint(equalToConstant: 50),
            createButton.widthAnchor.constraint(equalToConstant: 200),
            
            favoriteButton.topAnchor.constraint(equalTo: createButton.bottomAnchor,constant: 20),
            favoriteButton.leadingAnchor.constraint(equalTo: createButton.leadingAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: createButton.trailingAnchor),
            favoriteButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
