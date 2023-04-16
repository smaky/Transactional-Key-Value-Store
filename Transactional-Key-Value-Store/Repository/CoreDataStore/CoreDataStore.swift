//
//  CoreDataStore.swift
//  Transactional-Key-Value-Store
//
//  Created by Damian Smakulski on 16/04/2023.
//

import Foundation

final class CoreDataStore: StoreInterface {
    func set(value: String, for key: String) {
        
    }
    
    func get(for key: String) throws -> String {
        ""
    }
    
    func delete(for key: String) {
        
    }
    
    func count(for value: String) -> Int? {
        0
    }
    
    func begin() throws {
        
    }
    
    func commit() throws {
        
    }
    
    func rollback() throws {
        
    }
}
