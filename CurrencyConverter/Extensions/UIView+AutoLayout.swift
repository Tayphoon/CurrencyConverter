//
//  UIView+AutoLayout.swift
//  Tayphoon
//
//  Created by Tayphoon on 21/03/2018.
//  Copyright © 2018 Tayphoon. All rights reserved.
//

import UIKit

extension UIView {
    static func autoLayoutInstance() -> Self {
        let autoLayoutView = self.init()
        autoLayoutView.translatesAutoresizingMaskIntoConstraints = false

        return autoLayoutView
    }
}
