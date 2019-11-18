
import UIKit
import MapKit

class MainView: UIView {
    
    public lazy var search: UISearchBar = {
        let sB = UISearchBar()
        sB.backgroundColor = UIColor.blue.withAlphaComponent(0.1)
        sB.layer.cornerRadius = 10.0
        sB.placeholder = "Search"
        return sB
        
    }()
    
    public lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.layer.cornerRadius = 5.0
        return map
    }()
    
    public lazy var collectionView: UICollectionView = {
        
        print("Collection View exists")
        
        let cellLayout = UICollectionViewFlowLayout()
        cellLayout.scrollDirection = .horizontal
        //        cellLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 5)
        cellLayout.itemSize = CGSize.init(width: 200, height: 150)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: cellLayout)
        
        collectionView.backgroundColor = .clear
        collectionView.layer.cornerRadius = 10.0
        return collectionView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInt()
        self.collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "SearchCollectionViewCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func commonInt(){
        addSubviews()
        setConstrains()
    }
    
    func addSubviews(){
        addSubview(search)
        addSubview(mapView)
        addSubview(collectionView)
    }
    
    func setSearch(){
        search.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            search.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            search.leadingAnchor.constraint(equalTo: leadingAnchor),
            search.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func setMapView(){
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: search.bottomAnchor, constant: 0),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
        
    }
    
    func setCollectionView(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        //        NSLayoutConstraint.activate([
        //            collectionView.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 0),
        //            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
        //            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
        //            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        //        ])
        
        NSLayoutConstraint.activate([
            collectionView.heightAnchor.constraint(equalToConstant: 150),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setConstrains() {
        setSearch()
        setMapView()
        setCollectionView()
    }
    
}


