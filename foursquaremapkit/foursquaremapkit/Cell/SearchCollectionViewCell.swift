//
//  SearchCollectionViewCell.swift
//  foursquaremapkit
//
//  Created by Jack Wong on 11/12/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    public lazy var activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.style = .medium
        ai.hidesWhenStopped = true
        return ai
    }()
    
    public lazy var imageView: UIImageView = {
        let restuarantImageView = UIImageView()
        restuarantImageView.image = UIImage.init(named: "placeholder")
        return restuarantImageView
        
    }()
    
    public lazy var nameLabel: UILabel = {
        let venueName = UILabel()
        venueName.numberOfLines = 0
        venueName.backgroundColor = .black
        venueName.textAlignment = .center
        venueName.font = UIFont.boldSystemFont(ofSize: 17)
        venueName.textColor = .white
        return venueName
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInt()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInt()
    }
    private func commonInt(){
        addSubViews()
        setConstraints()
    }
    
    private func addSubViews(){
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(activityIndicator)
    }
    
    private func setImageView(){
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
        ])
    }
    
    private func setNameLabel(){
        nameLabel.translatesAutoresizingMaskIntoConstraints =  false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            nameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1)
        ])
    }
    private func setActiviyIndicator(){
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 0),
            activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 0)
        ])
        
    }
    
    private func setConstraints() {
        setImageView()
        setNameLabel()
        setActiviyIndicator()
    }
}

