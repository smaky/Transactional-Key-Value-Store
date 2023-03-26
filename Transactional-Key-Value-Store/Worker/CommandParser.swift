//
//  CommandParser.swift
//  Transactional-Key-Value-Store
//
//  Created by Damian Smakulski on 26/03/2023.
//

import Foundation

protocol Command: Equatable {
    var baseArg: String { get }
    mutating func run(parameters: [String]) throws -> String?
}

struct CommandParser {
    enum ArgumentParserError: Error, LocalizedError {
        case invalidCommand
        
        var errorDescription: String? {
            switch self {
            case .invalidCommand:
                return "Invalid command"
            }
        }
    }
    
    private(set) var commands: [any Command] = []
    
    func parse(command: String) throws -> String? {
        let args = command.lowercased().components(separatedBy: " ")
        if args.count > 0 {
            guard var command = commands.first(where: { $0.baseArg.lowercased() == args[0] })
            else { throw ArgumentParserError.invalidCommand }
            return try command.run(parameters: [])
        }
        return nil
    }
}

fileprivate extension CommandParser {
    mutating func register<T>(_ command: T) where T: Command {
        if commands.contains(where: { $0 as? T == command })  { return }
        commands.append(command)
    }
}

final class CommandParserBuilder  {
    private var commandParser = CommandParser()
    
    func with<T>(_ command: T) -> Self where T: Command {
        commandParser.register(command)
        return self
    }
    
    func build() -> CommandParser {
        return commandParser
    }
}
