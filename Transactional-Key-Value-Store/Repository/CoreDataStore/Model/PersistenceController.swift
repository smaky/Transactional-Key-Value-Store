//
//  PersistenceController.swift
//  Transactional-Key-Value-Store
//
//  Created by Damian Smakulski on 16/04/2023.
//

import Foundation
import CoreData

final class PersistenceController: NSObject {
    private let containerName = "Transactional-Key-Value-Store"
    let persistentContainer: NSPersistentContainer
    
    init(isInMemory: Bool = false) {
        persistentContainer = NSPersistentContainer(name: containerName)
        if isInMemory {
            persistentContainer.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        persistentContainer.loadPersistentStores(completionHandler: { storeDescription, error in
            if let error = error as NSError? {
                fatalError("\(storeDescription),Unresolved error \(error), \(error.userInfo)")
            }
        })
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        persistentContainer.viewContext.name = "viewContext"
        persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        persistentContainer.viewContext.shouldDeleteInaccessibleFaults = true
    }
    
}
