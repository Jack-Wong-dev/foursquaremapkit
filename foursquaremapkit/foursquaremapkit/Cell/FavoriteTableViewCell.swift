//
//  FavoriteCollectionViewCell.swift
//  foursquaremapkit
//
//  Created by Jack Wong on 11/12/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    public lazy var venueImage: UIImageView = {
        var image = UIImageView(image: UIImage(named: "food"))
        image.contentMode = .scaleAspectFit
        return image
        
    }()
    
    public lazy var favoriteLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    public lazy var addressLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 0
        return label
    }()
    
    public lazy var venueTip: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 0
        return label
        
    }()
    
    public lazy var view: UIView = {
        var view = UIView()
        view.backgroundColor = .cyan
        return view
    }()
    
    public lazy var hStack: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    
    public lazy var stackView: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    
    
//    private func setStackViewConstraints(){
//        self.stackView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            self.stackView.topAnchor.constraint(equalTo: self.locationImageView.bottomAnchor, constant: 10),
//            self.stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
//            self.stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 20),
//            self.stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
//        ])
//    }
    
    func setConstraints() {
        
        view.translatesAutoresizingMaskIntoConstraints = false
        venueImage.translatesAutoresizingMaskIntoConstraints = false
        favoriteLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        venueTip.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
              venueImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
              venueImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -260),
              venueImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
              venueImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])
        
        
        NSLayoutConstraint.activate([
            favoriteLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
            favoriteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150),
            favoriteLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            favoriteLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
            ]
        )
        
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: favoriteLabel.bottomAnchor, constant: 0),
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150),
            addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            addressLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)]
        )
        
        
        NSLayoutConstraint.activate([
            venueTip.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 5),
            venueTip.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150),
            venueTip.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            venueTip.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
    }
    
    private func setUpEverything() {
        addSubview(view)
        view.addSubview(addressLabel)
        view.addSubview(venueImage)
        view.addSubview(favoriteLabel)
        view.addSubview(venueTip)
        setConstraints()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpEverything()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpEverything()
    }
    
    
    
    
}
