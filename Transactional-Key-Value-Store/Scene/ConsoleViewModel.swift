//
//  ConsoleViewModel.swift
//  Transactional-Key-Value-Store
//
//  Created by Damian Smakulski on 26/03/2023.
//

import Foundation

final class ConsoleViewModel: ObservableObject {
    private var store: StoreInterface
    private var commandExecutor: CommandExecutorInterface
    
    init(store: StoreInterface) {
        self.store = store
        commandExecutor = StoreCommandExecutor(store: store)
    }
    
    func executeCommand(_ commandText: String) {
        if commandText.isEmpty { return }
        
        commandExecutor.executeCommand(commandText)
    }
}
