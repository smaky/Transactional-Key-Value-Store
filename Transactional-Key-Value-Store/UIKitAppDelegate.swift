//
//  UIKitAppDelegate.swift
//  Transactional-Key-Value-Store
//
//  Created by Damian Smakulski on 16/04/2023.
//
#if !os(macOS)
import UIKit

class UIKitAppDelegate: NSObject, UIApplicationDelegate {
    var persistanceController: PersistenceController? = nil
    
    func applicationWillResignActive(_ application: UIApplication) {
        if let persistanceController = persistanceController {
            persistanceController.saveContext(context: persistanceController.persistentContainer.viewContext)
        }
    }
}
#endif
