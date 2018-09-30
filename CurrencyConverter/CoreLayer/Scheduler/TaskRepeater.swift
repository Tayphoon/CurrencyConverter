//
//  TaskRepeater.swift
//  CurrencyConverter
//
//  Created by Tayphoon on 08/09/2018.
//  Copyright © 2018 Tayphoon. All rights reserved.
//

import Foundation

class TaskRepeater {
    
    private enum State {
        case suspended
        case resumed
    }
    
    private var timer: Timer!
    
    private var state: State = .suspended

    private(set) var timeInterval: TimeInterval

    var eventHandler: (() -> Void)?
    
    init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }
    
    func resume() {
        guard state != .resumed else {
            return
        }
        
        state = .resumed
        timer = Timer.scheduledTimer(withTimeInterval: self.timeInterval, repeats: true, block: { _ in
            if let handler = self.eventHandler {
                handler()
            }
        })
        //RunLoop.main.add(timer, forMode: .common)
    }
    
    func suspend() {
        guard state != .suspended else {
            return
        }
        
        state = .suspended
        timer.invalidate()
    }
    
    deinit {
        timer.invalidate()
    }
}
