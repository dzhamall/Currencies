//
//  FirstuCurrencyCell.swift
//  Currencies
//
//  Created by unostraniero on 06.11.2019.
//  Copyright © 2019 unostraniero. All rights reserved.
//

import UIKit

final class CurrencyCell: UITableViewCell {
    static let identifier = "CurrencyCell"
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Setup Layout
extension CurrencyCell {
    private func addViews() {
        self.addSubview(currencyLabel)
        self.addSubview(fromCurrency)
    }
    
    private func setupLayout() {
        self.addViews()
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        fromCurrency.translatesAutoresizingMaskIntoConstraints = false
        
        currencyLabel.leftAnchor.constraint(equalTo: self.leftAnchor,
                                            constant: +12).isActive = true
        currencyLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                              constant: 12).isActive = true
        currencyLabel.topAnchor.constraint(equalTo: self.topAnchor,
                                           constant: 12).isActive = true
        
        fromCurrency.leftAnchor.constraint(equalTo: currencyLabel.rightAnchor,
                                           constant: +12).isActive = true
        fromCurrency.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                              constant: 12).isActive = true
        fromCurrency.topAnchor.constraint(equalTo: self.topAnchor,
                                           constant: 12).isActive = true
    }
}
