//
//  VirtualStore.swift
//  Transactional-Key-Value-Store
//
//  Created by Damian Smakulski on 26/03/2023.
//

import Foundation

final class VirtualStore: StoreInterface {
    private var bucket: Dictionary<String, String> = [:]
    
    func count(for value: String) -> Int? {
        return 0
    }
    
    func begin() throws {
        
    }
    
    func commit() throws {
        
    }
    
    func rollback() throws {
        
    }
    
    func set(value: String, for key: String) {
        bucket[key] = value
    }
    
    func get(for key: String) -> String? {
        return bucket[key]
    }
    
    func delete(for key: String) {
        bucket[key] = nil
    }
    
}
