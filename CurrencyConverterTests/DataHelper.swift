//
//  DataHelper.swift
//  StolichkiTests
//
//  Created by Tayphoon on 14/01/2018.
//  Copyright © 2018 Inostudio. All rights reserved.
//

import Foundation

extension Data {
    
    init(reading input: InputStream) {
        
        self.init()
        input.open()
        
        let bufferSize = 1024
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
        while input.hasBytesAvailable {
            let read = input.read(buffer, maxLength: bufferSize)
            self.append(buffer, count: read)
        }
        buffer.deallocate()
        
        input.close()
    }
}
