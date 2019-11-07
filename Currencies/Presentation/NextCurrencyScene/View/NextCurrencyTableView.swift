//
//  FirstCurrencyView.swift
//  Currencies
//
//  Created by unostraniero on 06.11.2019.
//  Copyright © 2019 unostraniero. All rights reserved.
//

import UIKit

final class NextCurrencyTableView: UIView {
    private var tableView: UITableView = .init()
    private var showNextCurrencyScene: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CurrencyCell.self, forCellReuseIdentifier: CurrencyCell.identifier)
        
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
       }
}

//MARK: - Table View Implementation
extension NextCurrencyTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currenciesDictionary.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.identifier,
                                                 for: indexPath) as! CurrencyCell
        cell.currencyLabel.text = Array(currenciesDictionary)[indexPath.row].key
        cell.fromCurrency.text = Array(currenciesDictionary)[indexPath.row].value
        return cell
    }
}

extension NextCurrencyTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showNextCurrencyScene?(Array(currenciesDictionary)[indexPath.row].key)
    }
}

//MARK: - View Protocol
extension NextCurrencyTableView: ViewProtocol {
    
    typealias DataType = CurrencyType
    
    func setData(data: DataType) {
        showNextCurrencyScene = data.showNextCurrencyScene
    }
    
    var titleNavigationItem: String {
        return " First currency"
    }
    
    var navigationItems: NavigationItems {
        return .clear
    }
}

//MARK: - Setup Layout
extension NextCurrencyTableView {
    private func setupLayout() {
        self.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
