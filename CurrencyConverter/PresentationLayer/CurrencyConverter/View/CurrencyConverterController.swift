//
//  CurrencyConverterController.swift
//  CurrencyConverter
//
//  Created by Tayphoon on 19/08/2018.
//  Copyright 2018 Tayphoon. All rights reserved.
//

import Collections
import DifferenceKit

fileprivate struct ConverterController {
    
    static let connectionLabelHeight: CGFloat = 44.0
}

/**
 *  View 
 *	
 */
class CurrencyConverterController: CollectionController<CurrencyConverterViewModel>, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private var connectionLabel: UILabel!
    private var connectionLabelXConstraint: NSLayoutConstraint!
    
	var output: CurrencyConverterViewOutput?

	override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumLineSpacing = 10
        collectionView.collectionViewLayout = collectionViewLayout
        
        connectionLabel = UILabel.autoLayoutInstance()
        connectionLabel.textAlignment = .center
        connectionLabel.backgroundColor = UIColor.lightGray
        connectionLabel.textColor = UIColor.white
        connectionLabel.text = "Connection lost..."
        view.addSubview(connectionLabel)

        configureConstraints()
        
        output?.setupView()
    }
    
    // MARK: - UICollectionViewDatasource

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath)
        
        if var editableCell = cell as? EditableCell {
            editableCell.editable = viewModel.isItemEditable(at: indexPath)
        }
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = viewModel.currencyAtIndexPath(indexPath) {
            output?.didSelect(item)
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel?.size(for: indexPath, constrainedToSize: collectionView.bounds.size) ?? .zero
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.endEditing(true)
    }
    
    // MARK: - TransitionCoordinator methods
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func configureCollectionViewLayoutConstraints() {
        collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    // MARK: - Private methods
    
    private func reload<C>(using stagedChangeset: StagedChangeset<C>) {
        guard collectionView.window != .none else {
            collectionView.reloadData()
            return
        }

        self.collectionView.performBatchUpdates({
            for changeset in stagedChangeset {
                if !changeset.elementDeleted.isEmpty {
                    collectionView.deleteItems(at: changeset.elementDeleted.map { IndexPath(item: $0.element, section: $0.section) })
                }
                
                if !changeset.elementInserted.isEmpty {
                    collectionView.insertItems(at: changeset.elementInserted.map { IndexPath(item: $0.element, section: $0.section) })
                }
                
                //ignore first item
                let elementUpdated = changeset.elementUpdated.filter { $0.element != 0 }
                if !elementUpdated.isEmpty {
                    collectionView.reloadItems(at: elementUpdated.map { IndexPath(item: $0.element, section: $0.section) })
                }
            }
        })
    }
    
    private func isConnectionLabelVisible() -> Bool {
        return connectionLabelXConstraint.constant != 0
    }
    
    private func configureConstraints() {
        connectionLabelXConstraint = connectionLabel.bottomAnchor.constraint(equalTo: view.topAnchor)
        connectionLabelXConstraint.isActive = true
        connectionLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
        connectionLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor).isActive = true
        connectionLabel.heightAnchor.constraint(equalToConstant: ConverterController.connectionLabelHeight).isActive = true
    }
}

extension CurrencyConverterController: CurrencyConverterViewInput {
    
    func configureView(with currencies: [Currency]) {
        let changeset = StagedChangeset(source: viewModel.currencies, target: currencies)
        //let itmesCout = viewModel.currencies.count
        viewModel.configure(with: currencies)
        self.reload(using: changeset)
    }
    
    func moveCurrencyToTop(currency: Currency) {
        if let index = viewModel?.moveCurrencyToTop(currency: currency) {
            collectionView.performBatchUpdates({
                self.collectionView.deleteItems(at: [IndexPath(row: index, section: 0)])
                self.collectionView.insertItems(at: [IndexPath(row: 0, section: 0)])
            })
        }
    }
    
    func setNoConnectionLostLable(_ visible: Bool) {
        if visible != isConnectionLabelVisible() {
            let labelHeight = ConverterController.connectionLabelHeight
            let inset = labelHeight + topInset
            
            connectionLabelXConstraint.constant = (visible) ? inset : 0
            
            UIView.animate(withDuration: 0.3) {
                self.collectionView.contentInset = (visible) ? UIEdgeInsets(top: labelHeight, left: 0, bottom: 0, right: 0) : .zero
                self.collectionView.contentOffset = (visible) ? CGPoint(x: 0, y: -labelHeight) : .zero
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func scrollToTop() {
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    func makeFirstCellAsFirstResponder() {
        DispatchQueue.main.async {
            if let cell = self.collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as? EditableCell {
                cell.becomeFirstResponder()
            }
        }
    }
}

extension CurrencyConverterController: CurrencyCellActions {

    func didChangeValue(_ value: Double?) {
        output?.didUpdateCurrency(value)
    }
}
