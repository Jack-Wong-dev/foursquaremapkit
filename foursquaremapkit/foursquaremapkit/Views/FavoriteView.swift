//
//  FavoriteView.swift
//  foursquaremapkit
//
//  Created by Jack Wong on 11/12/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import UIKit

class FavoriteView: UIView {
    
    public lazy var tableView: UITableView = {
        var tv = UITableView()
        tv = UITableView(frame: .zero, style: .plain)
        tv.backgroundColor = .black
        tv.rowHeight = 150
        tv.allowsSelection = false
        return tv
    }()
    
    
    
    override init(frame: CGRect){
        super.init(frame: UIScreen.main.bounds)
        setEverything()
        self.tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: "favoriteCell")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setEverything()
    }
    
    
    func setEverything(){
        addSubview(tableView)
        setConstraints()
    }
    
    func setConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    
}
