//
//  Transactional_Key_Value_StoreApp.swift
//  Transactional-Key-Value-Store
//
//  Created by Damian Smakulski on 26/03/2023.
//

import SwiftUI

@main
struct Transactional_Key_Value_StoreApp: App {
#if os(macOS)
    @NSApplicationDelegateAdaptor(NSKitAppDelegate.self) var appDelegate
#else
    @UIApplicationDelegateAdaptor(UIKitAppDelegate.self) var appDelegate
#endif
    
    @Environment(\.scenePhase) private var scenePhase
    
    private let persistanceController = PersistenceController(isInMemory: false)
    private var store: StoreInterface
    
    init() {
        persistanceController.persistentContainer.newBackgroundContext()
        self.store = CoreDataStore(persistanceController: persistanceController)
        appDelegate.persistanceController = persistanceController
        
//        self.store = VirtualStore()
    }
    
    var body: some Scene {
        WindowGroup {
        #if os(macOS)
            ConsoleView(store: store).frame(width: 500, height: 800)
        #else
            ConsoleView(store: store)
        #endif
        }
        .onChange(of: scenePhase) { phase in
            if phase == .background {
                persistanceController.saveContext(context: persistanceController.persistentContainer.viewContext)
            }
        }
    }
}
