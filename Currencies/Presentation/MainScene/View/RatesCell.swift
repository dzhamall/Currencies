//
//  RatesCell.swift
//  Currencies
//
//  Created by unostraniero on 06.11.2019.
//  Copyright © 2019 unostraniero. All rights reserved.
//

import UIKit

final class RatesCell: UITableViewCell {
    static let identifier = "RatesCell"
    
    var currencyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 22.0)
        return label
    }()
    
    var fromCurrency: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        return label
    }()
    
    var ratesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 22.0)
        return label
    }()
    
    var fromRates: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Setup Layout
extension RatesCell {
    private func addViews() {
        self.addSubview(currencyLabel)
        self.addSubview(fromCurrency)
        self.addSubview(ratesLabel)
        self.addSubview(fromRates)
    }
    private func setupLayout() {
        self.addViews()
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        fromCurrency.translatesAutoresizingMaskIntoConstraints = false
        ratesLabel.translatesAutoresizingMaskIntoConstraints = false
        fromRates.translatesAutoresizingMaskIntoConstraints = false
        
        
        currencyLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        currencyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        currencyLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        
        fromCurrency.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        fromCurrency.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        fromCurrency.leadingAnchor.constraint(equalTo: currencyLabel.leadingAnchor,
                                              constant: 0).isActive = true
        fromCurrency.topAnchor.constraint(equalTo: currencyLabel.bottomAnchor, constant: 12).isActive = true
                
        ratesLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12).isActive = true
        ratesLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        ratesLabel.topAnchor.constraint(equalTo: currencyLabel.topAnchor, constant: 0).isActive = true
        
        fromRates.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        fromRates.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12).isActive = true
        fromRates.trailingAnchor.constraint(equalTo: ratesLabel.trailingAnchor, constant: 0).isActive = true
        fromRates.topAnchor.constraint(equalTo: ratesLabel.bottomAnchor, constant: 12).isActive = true
        fromRates.topAnchor.constraint(equalTo: fromCurrency.topAnchor, constant: 0).isActive = true
        fromCurrency.bottomAnchor.constraint(equalTo: fromCurrency.bottomAnchor, constant: 0).isActive = true
    }
}
