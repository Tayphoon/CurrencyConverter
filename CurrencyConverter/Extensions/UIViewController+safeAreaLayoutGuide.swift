//
//  UIViewController+safeAreaLayoutGuide.swift
//  CurrencyConverter
//
//  Created by Tayphoon on 10/05/2018.
//  Copyright © 2018 Tayphoon. All rights reserved.
//

import UIKit

extension UIViewController {
    /// Use safeAreaLayoutGuide on iOS 11+, otherwise default to dummy layout guide
    var safeAreaLayoutGuide: UILayoutGuide {
        if #available(iOS 11, *) {
            return view.safeAreaLayoutGuide
        }
        else if let layoutGuide = self.associatedLayoutGuide {
            return layoutGuide
        }
        else {
            let layoutGuide = UILayoutGuide()
            view.addLayoutGuide(layoutGuide)
            NSLayoutConstraint.activate([layoutGuide.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
                                         layoutGuide.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor),
                                         layoutGuide.leftAnchor.constraint(equalTo: view.leftAnchor),
                                         layoutGuide.rightAnchor.constraint(equalTo: view.rightAnchor)])
            self.associatedLayoutGuide = layoutGuide
            
            return layoutGuide
        }
    }
    
    var topInset: CGFloat {
        if #available(iOS 11, *) {
            return view.safeAreaInsets.top
        }
        else {
            return topLayoutGuide.length
        }
    }

    fileprivate struct AssociatedKeys {
        static var layoutGuide = "safeAreaLayoutGuide"
    }

    fileprivate var associatedLayoutGuide: UILayoutGuide? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.layoutGuide) as? UILayoutGuide
        }

        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self, &AssociatedKeys.layoutGuide,
                    newValue as UILayoutGuide?,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }
}
