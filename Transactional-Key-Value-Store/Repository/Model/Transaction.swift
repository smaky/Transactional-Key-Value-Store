//
//  Transaction.swift
//  Transactional-Key-Value-Store
//
//  Created by Damian Smakulski on 26/03/2023.
//

import Foundation

final class Transaction: NSCopying {
    private struct HashableKey: Hashable {
        var name: String
    }
    
    private var bucket: Dictionary<HashableKey, String> = [:]
    
    init() {}
    
    private init(bucket: Dictionary<HashableKey, String>) {
        self.bucket = bucket
    }
    
    func set(value: String, for key: String) {
        bucket[HashableKey(name: key)] = value
    }
    
    func delete(for key: String) {
        bucket[HashableKey(name: key)] = nil
    }
    
    func getValue(for key: String) -> String? {
        return bucket[HashableKey(name: key)]
    }
    
    func count(value: String) -> Int? {
        bucket.filter { $0.value == value }.count
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Transaction(bucket: bucket)
    }
}
