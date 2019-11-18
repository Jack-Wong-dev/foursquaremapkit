//
//  CollectionViewController.swift
//  foursquaremapkit
//
//  Created by Jack Wong on 11/11/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import UIKit

class CollectionsViewController: UIViewController {
    
    private var favView = FavoriteView()
    private var collections = [CollectionsModel]() {
        didSet {
            favoriteVenues.removeAll()
            for collection in collections {
                favoriteVenues.append(VenueManager.fetchFavoriteFromDocumentsDirectory(collection: collection.collectionName))
            }
            favView.tableView.reloadData()
        }
    }
    private var favoriteVenues: [[FaveRestaurant]] = []
    
    var detailVC: DetailViewController!

    fileprivate func fetchCollections() {
        collections = CollectionsDataManager.fetchCollections()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchCollections()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Favorite Venues"
        view.addSubview(favView)
        self.favView.tableView.dataSource = self
        self.favView.tableView.delegate = self
        fetchCollections()
    }

    
}

extension CollectionsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteVenues[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let faveSelection = favoriteVenues[indexPath.section][indexPath.row]
        guard let tvCell = favView.tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? FavoriteTableViewCell else {return UITableViewCell()}
        tvCell.favoriteLabel.text = faveSelection.restaurantName
        tvCell.addressLabel.text = faveSelection.address
        if let imageData = faveSelection.imageData {
             tvCell.venueImage.image = UIImage(data: imageData)
        }
        tvCell.venueTip.text = faveSelection.venueTip ?? ""
        return tvCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return collections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return collections[section].collectionName
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        VenueManager.deleteVenue(atIndex: indexPath.row, collection: favoriteVenues[indexPath.section][indexPath.row].collectionName)
        if favoriteVenues[indexPath.section].isEmpty {
            CollectionsDataManager.removeCollection(atIndex: indexPath.section)
        }
        fetchCollections()
    }
    
    
}
