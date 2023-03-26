//
//  Transactional_Key_Value_StoreApp.swift
//  Transactional-Key-Value-Store
//
//  Created by Damian Smakulski on 26/03/2023.
//

import SwiftUI

@main
struct Transactional_Key_Value_StoreApp: App {
    var body: some Scene {
        WindowGroup {
        #if os(macOS)
            ConsoleView().frame(width: 500, height: 800)
        #else
            ConsoleView()
        #endif
        }
    }
}
