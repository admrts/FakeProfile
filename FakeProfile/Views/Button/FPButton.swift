//
//  FPButton.swift
//  FakeProfile
//
//  Created by Ali Demirtaş on 4.10.2022.
//

import UIKit

class FPButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(color: UIColor, title: String, systemName: String) {
        self.init(frame: .zero)
        configuration?.baseBackgroundColor = color
        configuration?.baseForegroundColor = .white
        configuration?.image = UIImage(systemName: systemName)
        configuration?.title = title
    }
     func configure() {
        configuration = .filled()

        translatesAutoresizingMaskIntoConstraints = false
        configuration?.cornerStyle = .large
        configuration?.imagePadding = 5
        configuration?.imagePlacement = .leading
       
    }
}
