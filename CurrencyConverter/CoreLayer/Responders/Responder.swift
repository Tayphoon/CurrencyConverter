//
//  Responder.swift
//  CurrencyConverter
//
//  Created by Tayphoon on 11/09/2018.
//  Copyright © 2018 Tayphoon. All rights reserved.
//

import Foundation

public protocol Responder {
    
    var nextResponder: Responder? { get }
}

extension Responder {
    
    func proxy<T>() -> T? {
        for responder in responderChain() {
            if let proxy = responder as? T {
                return proxy
            }
        }
        
        return nil
    }

    fileprivate func responderChain() -> [Responder] {
        var responderChain: [Responder] = [self]
        
        var iterator = ResponderIterator(self)
        while let responder = iterator.next()  {
            responderChain.append(responder)
        }
        
        return responderChain;
    }
}

struct ResponderIterator: IteratorProtocol {
    
    private(set) var current: Responder?
    
    init(_ initial: Responder) {
        current = initial
    }
    
    mutating func next() -> Responder? {
        current = current?.nextResponder
        return current
    }
}
