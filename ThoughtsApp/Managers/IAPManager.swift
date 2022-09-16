//
//  IAPManager.swift
//  ThoughtsApp
//
//  Created by Paulo Filho on 23/08/22.
//

import Foundation
import Purchases
import StoreKit

final class IAPManager {
    static let shared = IAPManager()
    
    private var postEligibleViewDate: Date?
    
    private init() {}
    
    func isPremium() -> Bool {
        // Save locally in user defaults to avoid querying everytime
        return UserDefaults.standard.bool(forKey: "premium")
    }
    
    public func getSubscriptionStatus(completion: ((Bool) -> Void)?) {
        Purchases.shared.purchaserInfo { info, error in
            guard let entitlements = info?.entitlements,
                  error == nil else {
                return
            }
            
            if entitlements.all["Premium"]?.isActive == true {
                print("Got updated status of subscribed")
                UserDefaults.standard.set(true, forKey: "premium")
                completion?(true)
            } else {
                print("Got updated status of NOT subscribed")
                UserDefaults.standard.set(false, forKey: "premium")
                completion?(false)
            }
        }
    }
    
    public func fetchPackages(completion: @escaping (Purchases.Package?) -> Void) {
        Purchases.shared.offerings { offerings, error in
            guard let package = offerings?.offering(identifier: "default")?.availablePackages.first,
                  error == nil else {
                completion(nil)
                return
            }
            
            completion(package)
        }
    }
    
    public func subscribe(
        package: Purchases.Package,
        completion: @escaping (Bool) -> Void
    ) {
        guard !isPremium() else {
            print("User already subscribed")
            completion(true)
            return
        }
        
        print("Trying to purchase package")
        
        Purchases.shared.purchasePackage(package) { transaction, info, error, userCancelled in
            guard let transaction = transaction,
                  let entitlements = info?.entitlements,
                  error == nil,
                  !userCancelled else {
                return
            }
            
            switch transaction.transactionState {
            case .purchasing:
                print("purchasing")
            case .purchased:
                if entitlements.all["Premium"]?.isActive == true {
                    print("Purchased!")
                    UserDefaults.standard.set(true, forKey: "premium")
                    completion(true)
                } else {
                    print("Purchase failed")
                    UserDefaults.standard.set(false, forKey: "premium")
                    completion(false)
                }
            case .failed:
                print("failed")
            case .restored:
                print("restored")
            case .deferred:
                print("deferred")
            @unknown default:
                print("default")
            }
        }
    }
    
    public func restorePurchases(completion: @escaping (Bool) -> Void) {
        Purchases.shared.restoreTransactions { info, error in
            guard let entitlements = info?.entitlements,
                  error == nil else {
                return
            }
            
            if entitlements.all["Premium"]?.isActive == true {
                UserDefaults.standard.set(true, forKey: "premium")
                completion(true)
            } else {
                UserDefaults.standard.set(false, forKey: "premium")
                completion(false)
            }
        }
    }
}

extension IAPManager {
    var canViewPost: Bool {
        guard let date = postEligibleViewDate else {
            return true
        }
        
        UserDefaults.standard.set(0, forKey: "post_views")
        return Date() >= date
    }
    
    public func logPostViewed() {
        let total = UserDefaults.standard.integer(forKey: "post_views")
        UserDefaults.standard.set(total+1, forKey: "post_views")
        
        if total == 2 {
            let hour: TimeInterval = 60 * 60
            postEligibleViewDate = Date().addingTimeInterval(hour * 24)
        }
    }
}
