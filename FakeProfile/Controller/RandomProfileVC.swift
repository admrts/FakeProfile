//
//  RandomProfileVC.swift
//  FakeProfile
//
//  Created by Ali Demirtaş on 4.10.2022.
//

import UIKit

class RandomProfileVC: UIViewController {

    let profileImage = FPImageView(frame: .zero)
    let nameLabel = FPLabel(textAlignment: .left, fontSize: 15, weight: .semibold, textColor: .label)
    let countryLabel = FPLabel(textAlignment: .left, fontSize: 15, weight: .semibold, textColor: .label)
    let emailLabel = FPLabel(textAlignment: .left, fontSize: 15, weight: .semibold, textColor: .label)
    let phoneLabel = FPLabel(textAlignment: .left, fontSize: 15, weight: .semibold, textColor: .label)
    let adressLabel = FPLabel(textAlignment: .center, fontSize: 15, weight: .semibold, textColor: .label)
    let addButton = FPButton(color: .systemRed, title: "Add Favorite",systemName: "heart.fill")
    var profile: FakeProfile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRandomProfile()
        view.backgroundColor = .systemBackground
        title = "Random Profile"
        configureUI()
       
    }
    
    func getRandomProfile() {
        NetworkManager.shared.getRandomProfile { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let profile):
                self.profile = profile
                print(profile)
                DispatchQueue.main.async {
                    self.profileImage.downloadImage(urlString: profile.results[0].picture.large)
                    self.nameLabel.text = "  Name: \(profile.results[0].name.title) \(profile.results[0].name.first) \(profile.results[0].name.last)"
                    self.countryLabel.text = "  Country: \(profile.results[0].location.country)"
                    self.emailLabel.text = "  Email: \(profile.results[0].email)"
                    self.phoneLabel.text = "  Phone: \(profile.results[0].phone)"
                    self.adressLabel.text = "  Adress: \(profile.results[0].location.street.number) \(profile.results[0].location.street.name)  \(profile.results[0].location.city) / \(profile.results[0].location.country)"
                }
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
   
    
    func configureUI() {
        view.addSubview(profileImage)
        view.addSubview(nameLabel)
        view.addSubview(countryLabel)
        view.addSubview(emailLabel)
        view.addSubview(phoneLabel)
        view.addSubview(adressLabel)
        view.addSubview(addButton)
        
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
            
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -padding),
            addButton.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor),
            addButton.trailingAnchor.constraint(equalTo: profileImage.trailingAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
