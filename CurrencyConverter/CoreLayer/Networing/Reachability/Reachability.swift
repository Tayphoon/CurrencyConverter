//
//  Reachability.swift
//  CurrencyConverter
//
//  Created by Tayphoon on 16/09/2018.
//  Copyright © 2018 Tayphoon. All rights reserved.
//

import Alamofire

class Reachability {

    private let reachabilityManager: NetworkReachabilityManager!

    private var status: NetworkReachabilityManager.NetworkReachabilityStatus = .unknown

    public typealias NetworkReachable = (Reachability) -> ()
    public typealias NetworkUnreachable = (Reachability) -> ()
    
    public var whenReachable: NetworkReachable?
    
    public var whenUnreachable: NetworkUnreachable?

    public enum Connection: CustomStringConvertible {
        case none, wifi, cellular, unknown
        public var description: String {
            switch self {
            case .cellular: return "Cellular"
            case .wifi: return "WiFi"
            case .none: return "No Connection"
            case .unknown: return "Unknown"
            }
        }
    }
    
    public var connection: Connection {
        switch status {
        case .reachable(.ethernetOrWiFi):
            return .wifi
        case .reachable(.wwan):
            return .cellular
        case .notReachable:
            return .none
        case .unknown :
            return .unknown
        }
    }
    
    var isReachable: Bool {
        return connection != .unknown && connection != .none
    }

    init() {
        reachabilityManager = NetworkReachabilityManager(host: "www.apple.com")
        reachabilityManager.listener = { status in
            self.status = status
            
            let block = status != .notReachable ? self.whenReachable : self.whenUnreachable
            block?(self)
        }
    }
    
    @discardableResult public func startListen() -> Bool {
        return reachabilityManager.startListening()
    }
    
    public func stopListening() {
        reachabilityManager.stopListening()
    }
}
