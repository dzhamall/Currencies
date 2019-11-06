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
        
        currencyLabel.heightAnchor.constraint(equalToConstant: 26.5).isActive = true
        currencyLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        currencyLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor,
                                           constant: 12).isActive = true
        currencyLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,
                                            constant: +12).isActive = true
        currencyLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,
                                              constant: -43).isActive = true
        
        fromCurrency.heightAnchor.constraint(equalToConstant: 23).isActive = true
        fromCurrency.topAnchor.constraint(equalTo: contentView.topAnchor,
                                          constant: 45).isActive = true
        fromCurrency.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,
                                           constant: 12).isActive = true
        fromCurrency.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,
                                             constant: -12).isActive = true
        
        ratesLabel.heightAnchor.constraint(equalToConstant: 26.5).isActive = true
        ratesLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        ratesLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor,
                                        constant: 8).isActive = true
        ratesLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,
                                          constant: +5).isActive = true
        ratesLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,
                                         constant: contentView.frame.width - ratesLabel.frame.width).isActive = true
        
        fromRates.heightAnchor.constraint(equalToConstant: 26.5).isActive = true
        fromRates.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,
                                          constant: -12).isActive = true
        fromRates.topAnchor.constraint(equalTo: contentView.topAnchor,
                                          constant: 45).isActive = true
        fromRates.rightAnchor.constraint(equalTo: self.ratesLabel.rightAnchor,
                                         constant: -3).isActive = true
        fromRates.leftAnchor.constraint(equalTo: self.fromCurrency.rightAnchor,
                                        constant: 0).isActive = true
        
    }
}
