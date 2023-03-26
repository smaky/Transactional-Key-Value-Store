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
    
    func executeCommand(_ commandText: String, with logs: inout [Log] ) {
        do {
            let commandWithArgs = try commandParser.parse(command: commandText)
            var command = commandWithArgs.command
            let args = commandWithArgs.args
            logs.append(Log(text: "> " + command.baseArg.uppercased() + " " + args.joined(separator: " ")))
            if let log = try command.run(parameters: args) {
                logs.append(Log(text: log))
            }
        } catch (let error) {
            logs.append(Log(text: "> " + commandText))
            logs.append(Log(text: error.localizedDescription))
        }
    }
}
