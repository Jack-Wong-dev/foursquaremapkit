//
//  DetailViewController.swift
//  foursquaremapkit
//
//  Created by Jack Wong on 11/12/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    private let detailView = DetailView()
    private var venue: VenueStruct!
    private let placeholder = "Enter tip"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailView)
        view.backgroundColor = .white
        detailView.venueTip.delegate = self

        detailView.venueName.text = venue.name
        detailView.venueDescription.text =  venue.location.formattedAddress[0] + "\n" + venue.location.formattedAddress[1]
        getVenueImage()
        addVenue()
        setupKeyboardToolbar()
    }
    
    
    private func getVenueImage() {
        if let linkExists = venue.imageLink {
            if let imageIsInCache = ImageHelper.fetchImageFromCache(urlString: linkExists) {
                detailView.venueImage.image = imageIsInCache
                detailView.activityIndicator.stopAnimating()
            } else {
                ImageHelper.fetchImageFromNetwork(urlString: linkExists) { (appError, image) in
                    if let appError = appError {
                        print("imageHelper in detail vc error = \(appError)")
                    } else if let image = image {
                        self.detailView.venueImage.image = image
                        self.detailView.activityIndicator.stopAnimating()
                        print("Detail VC made network call for image")
                    }
                }
            }
        } else {
            FourSquareAPIClient.getImages(venueID: venue.id) { (appError, link) in
                if let appError = appError {
                    print("detailVC imageAPIClient error = \(appError)")
                } else if let link = link {
                    if let imageIsInCache = ImageHelper.fetchImageFromCache(urlString: link) {
                        self.detailView.venueImage.image = imageIsInCache
                        self.detailView.activityIndicator.stopAnimating()
                    } else {
                        ImageHelper.fetchImageFromNetwork(urlString: link) { (appError, image) in
                            if let appError = appError {
                                print("imageHelper in detail vc error = \(appError)")
                            } else if let image = image {
                                self.detailView.venueImage.image = image
                                self.detailView.activityIndicator.stopAnimating()
                                print("Detail VC made network call for image bc link wasn't available")
                            }
                        }
                    }
                }
            }
        }
    }
    

    private func setupKeyboardToolbar() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done
            , target: self, action: #selector(doneButtonAction))
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        detailView.venueTip.inputAccessoryView = toolbar
    }
    
    @objc private func doneButtonAction() {
        self.view.endEditing(true)
    }
    

    private func addVenue(){
        if let _ = venue {
            let tabBarButton =  UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addToCollection))
            navigationItem.rightBarButtonItem = tabBarButton
        }
    }
    
    @objc private func addToCollection(){
        
    let alertController =  UIAlertController(title: "", message: "Please enter a category name", preferredStyle: .alert)
        
        let save = UIAlertAction(title: "Submit", style: .default) { (alert) in
            guard let collectionName = alertController.textFields?.first?.text else {return}
            var venueTip: String?
            if self.detailView.venueTip.text != self.placeholder {
                venueTip = self.detailView.venueTip.text
            }
            if let imageData = self.detailView.venueImage.image {
                let favoritedVenueImage = imageData.jpegData(compressionQuality: 0.5)
                let collectionToSave = CollectionsModel.init(collectionName: collectionName)
                CollectionsDataManager.add(newCollection: collectionToSave)
                let venueToSet = FaveRestaurant.init(collectionName: collectionName, restaurantName: self.venue.name, imageData: favoritedVenueImage , venueTip: venueTip, description: self.venue.name, address: self.venue.location.modifiedAddress)
                VenueManager.addVenue(newFavoriteRestaurant: venueToSet, collection: "\(collectionName).plist")
                self.showAlert(title: "Saved", message: "Successfully favorited to \(collectionName) collection")
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addTextField {(textfield) in
            textfield.placeholder = "Enter collection name"
            textfield.textAlignment =  .center
        }
        alertController.addAction(save)
        alertController.addAction(cancel)
        present(alertController, animated: true)
    }
    

    init(restuarant: VenueStruct){
        super.init(nibName: nil, bundle: nil)
        self.venue = restuarant
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
}

extension DetailViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholder {
            textView.text = ""
        }
    }
}
