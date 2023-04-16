//
//  NSKitAppDelegate.swift
//  Transactional-Key-Value-Store
//
//  Created by Damian Smakulski on 16/04/2023.
//
#if os(macOS)
import Cocoa

class NSKitAppDelegate: NSObject, NSApplicationDelegate {
    var persistanceController: PersistenceController? = nil
    
    func applicationWillTerminate(_ notification: Notification) {
        if let persistanceController = persistanceController {
            persistanceController.saveContext(context: persistanceController.persistentContainer.viewContext)
        }
    }
}
#endif
