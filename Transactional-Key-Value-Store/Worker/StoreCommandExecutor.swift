//
//  StoreCommandExecutor.swift
//  Transactional-Key-Value-Store
//
//  Created by Damian Smakulski on 26/03/2023.
//

import Foundation

final class StoreCommandExecutor: CommandExecutorInterface {
    private var commandParser: CommandParser
    
    init(store: StoreInterface) {
        self.commandParser = CommandParserBuilder()
            .with(HelpCommand())
            .with(SetCommand(store: store))
            .build()
    }
    
    func executeCommand(_ commandText: String) {
        do {
            let commandWithArgs = try commandParser.parse(command: commandText)
            var command = commandWithArgs.command
            let args = commandWithArgs.args
            let _ = try command.run(parameters: args)
        } catch {
            
        }
    }
}
