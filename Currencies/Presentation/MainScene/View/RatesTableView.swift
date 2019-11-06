//
//  MainTableView.swift
//  Currencies
//
//  Created by unostraniero on 06.11.2019.
//  Copyright © 2019 unostraniero. All rights reserved.
//

import UIKit

final class RatesTableView: UIView {
    
    private var tableView: UITableView = .init()
    var titleNavigationItem = " Rates "
    var navigationItems: NavigationItems = .addButton
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RatesCell.self, forCellReuseIdentifier: RatesCell.identifier)
        
        addSubviews()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Table View Implementation
extension RatesTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RatesCell.identifier,
                                                 for: indexPath) as! RatesCell

        return cell
    }
}

extension RatesTableView: UITableViewDelegate { }
    
//MARK: - View Protocol
extension RatesTableView: ViewProtocol {
    typealias DataType = RatesType
    
    func setData(data: RatesType) {
        
    }
    
}
//MARK: - Setup Layout
extension RatesTableView {
    
    private func addSubviews() {
        self.addSubview(tableView)
    }
    
    private func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
}
