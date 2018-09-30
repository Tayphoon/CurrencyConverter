//
//  SelfSizeCollectionCell.swift
//  CurrencyConverter
//
//  Created by Tayphoon on 09/09/2018.
//  Copyright © 2018 Tayphoon. All rights reserved.
//

import UIKit

protocol SelfSizeCollectionCell {
    
    static func size(for item: Any, constrainedToSize size: CGSize) -> CGSize
}
