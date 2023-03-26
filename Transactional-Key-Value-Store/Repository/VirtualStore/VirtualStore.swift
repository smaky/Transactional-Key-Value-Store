//
//  VirtualStore.swift
//  Transactional-Key-Value-Store
//
//  Created by Damian Smakulski on 26/03/2023.
//

import Foundation

final class VirtualStore: StoreInterface {
    private var stackList = StackList<Transaction>()
    
    func count(for value: String) -> Int? {
        let transaciton = stackList.peek()
        return transaciton?.count(value: value)
    }
    
    func begin() throws {
        if stackList.isEmpty() {
            stackList.push(element: Transaction())
        }
        if let transaction = stackList.peek() {
            stackList.push(element: transaction.copy() as! Transaction)
        } else {
            throw StoreInterfaceError.noTransaction
        }
    }
    
    func commit() throws {
        if stackList.count == 1 {
            throw StoreInterfaceError.noTransaction
        }
        if let transaction = stackList.pop() {
            stackList.pop()
            stackList.push(element: transaction)
        } else {
            throw StoreInterfaceError.noTransaction
        }
    }
    
    func rollback() throws {
        if stackList.count == 1 {
            throw StoreInterfaceError.noTransaction
        }
        stackList.pop()
    }
    
    func set(value: String, for key: String) {
        if stackList.isEmpty() {
            stackList.push(element: Transaction())
        }
        let transaction = stackList.peek()
        transaction?.set(value: value, for: key)
    }
    
    func get(for key: String) throws -> String {
        let transaciton = stackList.peek()
        guard let value = transaciton?.getValue(for: key)
        else { throw StoreInterfaceError.keyNoSet }
        return value
    }
    
    func delete(for key: String) {
        let transaciton = stackList.peek()
        transaciton?.delete(for: key)
    }
    
}
