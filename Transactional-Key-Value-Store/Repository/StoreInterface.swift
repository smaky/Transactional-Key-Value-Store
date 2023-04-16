//
//  StoreInterface.swift
//  Transactional-Key-Value-Store
//
//  Created by Damian Smakulski on 26/03/2023.
//

import Foundation

protocol StoreInterface {
    func set(value: String, for key: String)
    func get(for key: String) throws -> String
    func delete(for key: String)
    func count(for value: String) -> Int?
    func begin() throws
    func commit() throws
    func rollback() throws
    func drop()
}

extension StoreInterface {
    func drop() {}
}

enum StoreInterfaceError: Error, LocalizedError {
    case noTransaction
    case keyNoSet
    
    var errorDescription: String? {
        switch self {
        case .noTransaction:
            return "no transaction"
        case .keyNoSet:
            return "key no set"
        }
    }
}
