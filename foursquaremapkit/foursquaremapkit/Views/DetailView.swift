//
//  DetailView.swift
//  foursquaremapkit
//
//  Created by Jack Wong on 11/12/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    public lazy var activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.style = .medium
        ai.hidesWhenStopped = true
        return ai
    }()
    
    public lazy var venueImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "placeholder"))
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 10.0
        return image
    }()
    
    public lazy var venueName: UILabel = {
        let venueName = UILabel()
        venueName.backgroundColor = .white
        venueName.textAlignment = .center
        venueName.textColor = .black
        venueName.font = UIFont.boldSystemFont(ofSize: 25)
        venueName.layer.cornerRadius = 5.0
        return venueName
    }()

    public lazy var venueDescription: UITextView = {
        let textView = UITextView()
        textView.dataDetectorTypes = [.address, .phoneNumber]
        textView.backgroundColor = .white
        textView.textAlignment = .center
        venueName.textColor = .black
        textView.font = UIFont.boldSystemFont(ofSize: 20)
        textView.isEditable = false
        return textView
    }()
    
    public lazy var noteView: UIView = {
        let view = UIView()
        return view
    }()
    
    public lazy var venueTip: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.boldSystemFont(ofSize: 15)
        textView.isEditable = true
        textView.backgroundColor = .black
        textView.textColor = .white
        textView.text = "Enter tip"
        return textView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setUpEverything()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpEverything()
    }
    
    private func setUpEverything() {
        SetConstrains()
    }
}

extension DetailView{
    private func SetConstrains(){
        addSubview(venueImage)
        addSubview(venueName)
        addSubview(venueDescription)
        addSubview(activityIndicator)
        addSubview(noteView)
        addSubview(venueTip)
        
        venueImage.translatesAutoresizingMaskIntoConstraints = false
        venueName.translatesAutoresizingMaskIntoConstraints = false
        venueDescription.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        noteView.translatesAutoresizingMaskIntoConstraints = false
        venueTip.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            venueImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            venueImage.bottomAnchor.constraint(equalTo: centerYAnchor),
            venueImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            venueImage.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            venueName.topAnchor.constraint(equalTo: venueImage.bottomAnchor),
            venueName.leadingAnchor.constraint(equalTo: leadingAnchor),
            venueName.trailingAnchor.constraint(equalTo: trailingAnchor),
            venueName.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05)
        ])
        
        NSLayoutConstraint.activate([
            venueDescription.topAnchor.constraint(equalTo: venueName.bottomAnchor),
            venueDescription.leadingAnchor.constraint(equalTo: leadingAnchor),
            venueDescription.trailingAnchor.constraint(equalTo: trailingAnchor),
            venueDescription.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.08)]
        )
        
        NSLayoutConstraint.activate([
            noteView.topAnchor.constraint(equalTo: venueDescription.bottomAnchor),
            noteView.leadingAnchor.constraint(equalTo: leadingAnchor),
            noteView.trailingAnchor.constraint(equalTo: trailingAnchor),
            noteView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        
        NSLayoutConstraint.activate([
            venueTip.topAnchor.constraint(equalTo: noteView.topAnchor),
            venueTip.leadingAnchor.constraint(equalTo: noteView.leadingAnchor),
            venueTip.trailingAnchor.constraint(equalTo: noteView.trailingAnchor),
            venueTip.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            
            activityIndicator.centerYAnchor.constraint(equalTo: venueImage.centerYAnchor, constant: 0),
            activityIndicator.centerXAnchor.constraint(equalTo: venueImage.centerXAnchor, constant: 0)
            
        ])
        
        
    }
    
}
