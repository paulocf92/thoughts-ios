//
//  StorageManager.swift
//  ThoughtsApp
//
//  Created by Paulo Filho on 23/08/22.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    static let shared = StorageManager()
    
    private let storage = Storage.storage()
    
    private init() {}
}
