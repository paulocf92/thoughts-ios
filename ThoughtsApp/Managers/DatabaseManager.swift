//
//  DatabaseManager.swift
//  ThoughtsApp
//
//  Created by Paulo Filho on 23/08/22.
//

import Foundation
import FirebaseFirestore

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let database = Firestore.firestore()
    
    private init() {}
}
