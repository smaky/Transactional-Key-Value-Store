//
//  StoreCommandExecutor.swift
//  Transactional-Key-Value-Store
//
//  Created by Damian Smakulski on 26/03/2023.
//

import Foundation

final class StoreCommandExecutor: CommandExecutorInterface {
    private var store: StoreInterface
    
    init(store: StoreInterface) {
        self.store = store
    }
    
    func executeCommand(_ commandText: String) {
        let args = commandText.lowercased().components(separatedBy: " ")
        if args.count == 3, args[0] == "set" {
            store.set(value: args[2], for: args[1])
        }
    }
}
