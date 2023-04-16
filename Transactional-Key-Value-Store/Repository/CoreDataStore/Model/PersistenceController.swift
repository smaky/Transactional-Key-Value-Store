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
    var persistentContainer: NSPersistentContainer
    
    init(isInMemory: Bool = false) {
        TransactionTransformer.register()
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
    
    func saveContext (context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func drop() throws {
        let storeContainer =
            persistentContainer.persistentStoreCoordinator

        for store in storeContainer.persistentStores {
            try storeContainer.destroyPersistentStore(
                at: store.url!,
                ofType: store.type,
                options: nil
            )
        }

        persistentContainer = NSPersistentContainer(
            name: containerName
        )

        persistentContainer.loadPersistentStores {
            (store, error) in
        }

    }
}
