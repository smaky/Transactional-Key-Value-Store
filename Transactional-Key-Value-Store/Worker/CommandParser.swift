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

extension Command {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.baseArg == rhs.baseArg
    }
}

struct CommandParser {
    private(set) var commands: [any Command] = []
    
    enum ArgumentParserError: Error, LocalizedError {
        case invalidCommand
        
        var errorDescription: String? {
            switch self {
            case .invalidCommand:
                return "Invalid command"
            }
        }
    }
    
    func parse(command: String) throws -> (command: any Command, args: [String]) {
        let args = try argsFrom(command: command)
        let command = try getCommand(for: args)
        return (command: command, args: Array(args.dropFirst()))
    }
    
    private func getCommand(for args: [String]) throws -> any Command {
        guard let command = commands.first(where: { $0.baseArg.lowercased() == args.first?.lowercased() })
        else { throw ArgumentParserError.invalidCommand }
        return command
    }
    
    private func argsFrom(command: String) throws -> [String] {
        let args = command
            .components(separatedBy: .whitespaces)
            .filter { !$0.isEmpty }
        if args.count == 0 { throw ArgumentParserError.invalidCommand }
        return args
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
