import UIKit
import MapKit
import CoreLocation


class MainViewController: UIViewController {
    
    let mainSearchView = MainView()
    private let locationManager = CLLocationManager()
    private var coordinateToSearch = CLLocationCoordinate2D(latitude: 40.626994, longitude: -74.009727)
    private var venues = [VenueStruct]()
    private var annotations = [MKAnnotation]()
    
    private var myCurrentRegion = MKCoordinateRegion() {
        didSet {
            getVenues(keyword: userDefaultsSearchTerm())
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(DataPersistenceManager.documentsDirectory())
        title = "Search Venue"
        view.addSubview(mainSearchView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Locate Me", style: .plain, target: self, action: #selector(LocateMeButtonPressed))
        
        setDelegates()
        
        checkLocationServices()
        setupKeyboardToolbar()
    }
    
    private func setDelegates(){
        mainSearchView.collectionView.delegate = self
        mainSearchView.collectionView.dataSource = self
        locationManager.delegate = self
        mainSearchView.search.delegate = self
        mainSearchView.mapView.delegate = self
    }
    
    private func getVenues(keyword: String) {
        FourSquareAPIClient.getVenue(latitude: myCurrentRegion.center.latitude.description, longitude: myCurrentRegion.center.longitude.description, category: keyword) { (appError, venues) in
            if let appError = appError {
                print("Getting Venues - \(appError)")
            } else if let venues = venues {
                self.venues = venues
                DispatchQueue.main.async {
                    self.addAnnotations()
                    self.mainSearchView.collectionView.reloadData()
                }
            }
        }
    }
    
    fileprivate func addAnnotations() {
        mainSearchView.mapView.removeAnnotations(annotations)
        annotations.removeAll()
        for venue in venues {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: venue.location.lat ?? 0.0, longitude: venue.location.lng ?? 0.0)
            annotation.title = venue.name
            annotations.append(annotation)
        }
        mainSearchView.mapView.showAnnotations(annotations, animated: true)
    }
    
    private func userDefaultsSearchTerm() -> String {
        if let searchTermFromUserDefaults = UserDefaults.standard.object(forKey: UserDefaultsKey.searchTerm) as? String {
            return searchTermFromUserDefaults
        } else {
            return "taco"
        }
    }
    
    @objc private func LocateMeButtonPressed() {
        mainSearchView.mapView.setCenter(myCurrentRegion.center, animated: true)
    }
    
    func checkLocationServices(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            mainSearchView.mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            mainSearchView.mapView.showsUserLocation = true
        }
    }
    
    fileprivate func setupKeyboardToolbar() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done
            , target: self, action: #selector(doneButtonAction))
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        mainSearchView.search.inputAccessoryView = toolbar
    }
    
    @objc private func doneButtonAction() {
        self.view.endEditing(true)
    }
}



extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("There's \(venues.count) venues")
        return venues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionViewcell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        let venueToSet = venues[indexPath.row]
        collectionViewcell.activityIndicator.startAnimating()
        collectionViewcell.nameLabel.text = venueToSet.name
        print(venueToSet.name)
        
        FourSquareAPIClient.getImages(venueID: venueToSet.id) { (appError, imageLink) in
            if let appError = appError {
                print("imageClient - \(appError)")
            } else if let imageLink = imageLink {
                self.venues[indexPath.row].imageLink = imageLink
                if let imageIsInCache = ImageHelper.fetchImageFromCache(urlString: imageLink) {
                    DispatchQueue.main.async {
                        collectionViewcell.imageView.image = imageIsInCache
                    }
                } else {
                    ImageHelper.fetchImageFromNetwork(urlString: imageLink, completion: { (appError, image) in
                        if let appError = appError {
                            print("imageHelper error - \(appError)")
                        } else if let image = image {
                            collectionViewcell.imageView.image = image
                            print("mainVC - got image from network")
                        }
                    })
                }
                DispatchQueue.main.async {
                    collectionViewcell.activityIndicator.stopAnimating()
                }
            }
        }
        return collectionViewcell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let venue = venues[indexPath.row]
        let destination = DetailViewController(restuarant: venue)
        self.navigationController?.pushViewController(destination, animated: true)
    }
}


extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            coordinateToSearch = myCurrentRegion.center
        }
        let currentRegion = MKCoordinateRegion(center: coordinateToSearch, latitudinalMeters: 500, longitudinalMeters: 500)
        mainSearchView.mapView.setRegion(currentRegion, animated: true)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        myCurrentRegion = MKCoordinateRegion()
        if let currentLocation = locations.last {
            myCurrentRegion = MKCoordinateRegion(center: currentLocation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
            
        } else {
            myCurrentRegion = MKCoordinateRegion(center: coordinateToSearch, latitudinalMeters: 500, longitudinalMeters: 500)
        }
    }
    
    
}

extension MainViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "Callouts") as? MKMarkerAnnotationView
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "Callouts")
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView = UIButton(type: .infoLight)
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let calloutClicked = view.annotation else {
            return
        }
        if let venueName = calloutClicked.title, let venue = (venues.filter{ $0.name == venueName}).first {
            let destination = DetailViewController(restuarant: venue)
            self.navigationController?.pushViewController(destination, animated: true)
        }
    }
    
}

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text else { return }
        getVenues(keyword: searchText)
        UserDefaults.standard.set(searchText, forKey: UserDefaultsKey.searchTerm)
    }
}



