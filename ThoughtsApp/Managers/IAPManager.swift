//
//  IAPManager.swift
//  ThoughtsApp
//
//  Created by Paulo Filho on 23/08/22.
//

import Foundation
import Purchases

final class IAPManager {
    static let shared = IAPManager()
    
    // RevenueCat Shared Secret
    // 9eb0501030a848b2bcd519ef0c3941c0
    
    private init() {}
    
    func isPremium() -> Bool {
        return false
    }
    
    func subscribe() {
        
    }
    
    func restorePurchases() {
        
    }
}
