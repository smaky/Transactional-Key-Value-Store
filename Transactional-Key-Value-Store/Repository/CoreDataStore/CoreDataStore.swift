//
//  CoreDataStore.swift
//  Transactional-Key-Value-Store
//
//  Created by Damian Smakulski on 16/04/2023.
//

import Foundation
import CoreData

final class CoreDataStore: StoreInterface {
    private let persistanceController: PersistenceController
    
    var context: NSManagedObjectContext {
        persistanceController.persistentContainer.viewContext
    }
    
    init(persistanceController: PersistenceController) {
        self.persistanceController = persistanceController
    }
    
    func set(value: String, for key: String) {
        if let number = try? context.count(for: StoredTransaction.fetchRequest()), number == 0 {
            createNewTransaction()
        }
        let storedTransaction = getLastStoredTransaction()
        if let transaction = storedTransaction?.transaction {
            transaction.set(value: value, for: key)
            storedTransaction?.transaction = transaction
        }
    }
    
    func get(for key: String) throws -> String {
        let storedTransaction = getLastStoredTransaction()
        guard let value = storedTransaction?.transaction?.getValue(for: key)
        else { throw StoreInterfaceError.keyNoSet }
        return value
    }
    
    func delete(for key: String) {
        let storedTransaction = getLastStoredTransaction()
        if let transaction = storedTransaction?.transaction {
            transaction.delete(for: key)
            storedTransaction?.transaction = transaction
        }
    }
    
    func count(for value: String) -> Int? {
        let storedTransaction = getLastStoredTransaction()
        return storedTransaction?.transaction?.count(value: value)
    }
    
    func begin() throws {
        if let number = try? context.count(for: StoredTransaction.fetchRequest()), number == 0 {
            createNewTransaction()
        }
        let storedTransaction = getLastStoredTransaction()
        if let transaction = storedTransaction?.transaction {
            let storedTransaction =  StoredTransaction(context: context)
            storedTransaction.transaction = transaction.copy() as? Transaction
        } else {
            throw StoreInterfaceError.noTransaction
        }
    }
    
    func commit() throws {
        if let number = try? context.count(for: StoredTransaction.fetchRequest()), number == 1 {
            throw StoreInterfaceError.noTransaction
        }
        if let storedTransaction = getLastStoredTransaction(),
           let transaction = storedTransaction.transaction {
            context.delete(storedTransaction)
            if let previousStoredTransaction = getLastStoredTransaction() {
                previousStoredTransaction.transaction = transaction.copy() as? Transaction
            }
        } else {
            throw StoreInterfaceError.noTransaction
        }
    }
    
    func rollback() throws {
        if let number = try? context.count(for: StoredTransaction.fetchRequest()), number == 1 {
            throw StoreInterfaceError.noTransaction
        }
        if let storedTransaction = getLastStoredTransaction() {
            context.delete(storedTransaction)
        } else {
            throw StoreInterfaceError.noTransaction
        }
    }
    
    private func getLastStoredTransaction() -> StoredTransaction? {
        let request = StoredTransaction.fetchRequest()
        if let allElementsCount = try? context.count(for: request), allElementsCount > 0 {
            request.fetchOffset = allElementsCount - 1
        }
        request.fetchLimit = 1
        request.returnsObjectsAsFaults = false
        let result = try? context.fetch(request)
        return result?.last
    }
    
    private func createNewTransaction() {
        let storedTransaction =  StoredTransaction(context: context)
        storedTransaction.transaction = Transaction()
    }
    
    func drop() {
        try? persistanceController.drop()
    }
}
