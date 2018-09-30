//
//  CurrencyConverterViewModel.swift
//  CurrencyConverter
//
//  Created by Tayphoon on 19/08/2018.
//  Copyright © 2018 Tayphoon. All rights reserved.
//

import Collections

class CurrencyConverterViewModel {

    private var cellObjects = [CellObject]()
    
    private(set) var currencies = [Currency]()

    var builder: CollectionObjectBuilder?
    
    var delegate: CollectionViewModelDelegate?
    
    func configure(with currencies: [Currency]) {
        self.currencies = currencies
        
        cellObjects.removeAll()
        for currency in currencies {
            if let cellObject = builder?.buildCellObject(for: currency) {
                cellObjects.append(cellObject)
            }
        }
    }
    
    func moveCurrencyToTop(currency: Currency) -> Int? {
        guard let index = currencies.firstIndex(of: currency) else {
            return nil
        }
        
        let cellObject = cellObjects.remove(at: index)
        cellObjects.insert(cellObject, at: 0)
        
        currencies.remove(at: index)
        currencies.insert(currency, at: 0)
        
        return index
    }
    
    func isItemEditable(at indexPath: IndexPath) -> Bool {
        return indexPath.row == 0
    }
}

extension CurrencyConverterViewModel: CollectionViewModel {
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return cellObjects.count
    }
    
    func reuseIdentifierForCellAtIndexPath(_ indexPath: IndexPath) -> String {
        let cellObject = itemAtIndexPath(indexPath) as? CellObject
        
        if let reuseIdentifier = cellObject?.reuseIdentifier {
            return reuseIdentifier
        }
        
        return "CellIdenty"
    }
    
    func size(for indexPath: IndexPath, constrainedToSize size: CGSize) -> CGSize {
        guard let cellObject = itemAtIndexPath(indexPath) as? CellObject,
              let item = currencyAtIndexPath(indexPath) else {
            return .zero
        }
        
        if let cell = cellObject.cellClass as? SelfSizeCollectionCell.Type {
            return cell.size(for:item, constrainedToSize:size)
        }

        return .zero
    }
    
    func itemAtIndexPath(_ indexPath: IndexPath) -> Any? {
        guard indexPath.row < cellObjects.count else {
            return nil
        }
        
        return cellObjects[indexPath.row]
    }
    
    func indexPathOfObject(_ object: Any) -> IndexPath? {
        return nil
    }
    
    func currencyAtIndexPath(_ indexPath: IndexPath) -> Currency? {
        guard indexPath.row < currencies.count else {
            return nil
        }
        
        return currencies[indexPath.row]
    }
}
