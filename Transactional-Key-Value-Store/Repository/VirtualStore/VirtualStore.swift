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
    
    func begin() {
        
    }
    
    func commit() throws {
        throw StoreInterfaceError.noTransaction
    }
    
    func rollback() throws {
        throw StoreInterfaceError.noTransaction
    }
    
    func set(value: String, for key: String) {
        bucket[key] = value
    }
    
    func get(for key: String) throws -> String {
        guard let value = bucket[key]
        else { throw StoreInterfaceError.keyNoSet }
        return value
    }
    
    func delete(for key: String) {
        bucket[key] = nil
    }
    
}
