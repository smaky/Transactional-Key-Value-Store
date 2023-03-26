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
        
    }
}
