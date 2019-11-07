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
    private var refresher: UIRefreshControl!
    private var refreshHandling: (([RatesModel]) -> Void)?

    private var items: [RatesModel?] = .init() {
        didSet {
            reload()
            self.refresher.endRefreshing()
        }
    }
    
    var navigationItems: NavigationItems = .addButton

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RatesCell.self, forCellReuseIdentifier: RatesCell.identifier)
        tableView.tableFooterView = UIView()
        
        self.refresher = UIRefreshControl()
        self.tableView.alwaysBounceVertical = true
        self.refresher.tintColor = UIColor.darkGray
        self.refresher.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        addSubviews()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc func refreshData() {
        guard items.count > 0 else {
            return
        }
        refreshHandling?(items as! [RatesModel])
    }

}

//MARK: - Table View Implementation
extension RatesTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RatesCell.identifier,
                                                 for: indexPath) as! RatesCell
        cell.currencyLabel.text = items[indexPath.row]?.currency
        cell.fromCurrency.text = items[indexPath.row]?.from
        cell.ratesLabel.text = items[indexPath.row]?.rates
        cell.fromRates.text = items[indexPath.row]?.fromRates

        return cell
    }
}

extension RatesTableView: UITableViewDelegate { }
    
//MARK: - View Protocol
extension RatesTableView: ViewProtocol {
    typealias DataType = RatesType
    
    func setData(data: RatesType?) {
        guard let data = data else {
            items = currArray
            return
        }
        currArray.insert(contentsOf: data.setCurrrency!, at: 0)
        items.insert(contentsOf: currArray, at: 0)
    }
    
    func updateData(data: RatesType) {
        refreshHandling = data.refreshHandling
    }
    
}
//MARK: - Setup Layout
extension RatesTableView {
    
    private func addSubviews() {
        self.addSubview(tableView)
        self.tableView.addSubview(refresher)
    }
    
    private func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
}


