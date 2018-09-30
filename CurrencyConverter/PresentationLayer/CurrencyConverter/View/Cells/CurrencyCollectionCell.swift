//
//  CurrencyCollectionCell.swift
//  CurrencyConverter
//
//  Created by Tayphoon on 09/09/2018.
//  Copyright © 2018 Tayphoon. All rights reserved.
//

import UIKit
import Collections

fileprivate struct CellView {
    
    static let cellInset: CGFloat = 10
    
    static let textFieldSize: CGFloat = 44
}

class CurrencyCollectionCell: UICollectionViewCell, CollectionCell {
    
    private var formatter: NumberFormatter!
    
    private(set) var countryFlagLabel: UILabel!
    private(set) var countryLabel: UILabel!
    private(set) var currencyTextField: UITextField!
    
    private weak var actionProxy: CurrencyCellActions?
    
    var editable: Bool = false {
        willSet {
            currencyTextField.isUserInteractionEnabled = newValue
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        contentView.layoutMargins = UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 15)
        
        formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2

        countryFlagLabel = UILabel.autoLayoutInstance()
        countryFlagLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        countryFlagLabel.numberOfLines = 1
        contentView.addSubview(countryFlagLabel)
        
        countryLabel = UILabel.autoLayoutInstance()
        countryLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        countryLabel.numberOfLines = 1
        contentView.addSubview(countryLabel)

        currencyTextField = UITextField.autoLayoutInstance()
        currencyTextField.textAlignment = .right
        currencyTextField.keyboardType = .decimalPad
        currencyTextField.placeholder = "0"
        currencyTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        contentView.addSubview(currencyTextField)

        setupConstarints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with currency: Currency) {
        countryFlagLabel.text = currency.flag
        countryLabel.text = currency.name
        if let value = currency.value {
            currencyTextField.text = formatter.string(from: value as NSNumber)
        }
        else {
            currencyTextField.text = nil
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        actionProxy = proxy()
    }

    // MARK: - Private methods
    
    @objc
    private func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            actionProxy?.didChangeValue(formatter.number(from: text)?.doubleValue)
        }
    }
    
    private func setupConstarints() {
        let marginsGuide = contentView.layoutMarginsGuide
        countryFlagLabel.leftAnchor.constraint(equalTo: marginsGuide.leftAnchor).isActive = true
        countryFlagLabel.centerYAnchor.constraint(equalTo: marginsGuide.centerYAnchor).isActive = true
        countryFlagLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        countryFlagLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        countryLabel.leftAnchor.constraint(equalTo: countryFlagLabel.rightAnchor, constant:CellView.cellInset).isActive = true
        countryLabel.centerYAnchor.constraint(equalTo: marginsGuide.centerYAnchor).isActive = true

        currencyTextField.leftAnchor.constraint(equalTo: countryLabel.rightAnchor, constant:CellView.cellInset).isActive = true
        currencyTextField.rightAnchor.constraint(equalTo: marginsGuide.rightAnchor).isActive = true
        currencyTextField.centerYAnchor.constraint(equalTo: marginsGuide.centerYAnchor).isActive = true
        currencyTextField.heightAnchor.constraint(equalToConstant: CellView.textFieldSize).isActive = true
        currencyTextField.widthAnchor.constraint(greaterThanOrEqualToConstant: CellView.textFieldSize).isActive = true
        currencyTextField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        currencyTextField.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
}

extension CurrencyCollectionCell: EditableCell {
    
    func becomeFirstResponder() {
        currencyTextField.becomeFirstResponder()
    }
}

extension CurrencyCollectionCell: SelfSizeCollectionCell {
    
    static func size(for item: Any, constrainedToSize size: CGSize) -> CGSize {
        return CGSize(width: size.width, height: 60)
    }
}
