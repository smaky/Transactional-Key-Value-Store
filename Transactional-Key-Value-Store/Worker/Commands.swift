//
//  Commands.swift
//  Transactional-Key-Value-Store
//
//  Created by Damian Smakulski on 26/03/2023.
//

import Foundation

struct HelpCommand: Command {
    let baseArg: String = "help"
    
    @discardableResult
    func run(parameters: [String] = []) throws -> String? {
        return """
                SET <key> <value> // store the value for key
                GET <key>         // return the current value for key
                DELETE <key>      // remove the entry for key
                COUNT <value>     // return the number of keys that have the given value
                BEGIN             // start a new transaction
                COMMIT            // complete the current transaction
                ROLLBACK          // revert to state prior to BEGIN call
                DROP              // drop all database (if exist)
                """
    }
}

struct SetCommand: Command {
    let baseArg: String = "set"
    private var store: StoreInterface
    
    init (store: StoreInterface) {
        self.store = store
    }
    
    @discardableResult
    mutating func run(parameters: [String]) throws -> String? {
        guard parameters.count == 2 else { throw CommandParser.ArgumentParserError.invalidCommand }
        store.set(value: parameters[1], for: parameters[0])
        return nil
    }
}

struct GetCommand: Command {
    let baseArg: String = "get"
    private var store: StoreInterface
    
    init (store: StoreInterface) {
        self.store = store
    }
    
    @discardableResult
    func run(parameters: [String]) throws -> String? {
        guard parameters.count == 1 else { throw CommandParser.ArgumentParserError.invalidCommand }
        return try store.get(for: parameters[0])
    }
}

struct DeleteCommand: Command {
    let baseArg: String = "delete"
    private var store: StoreInterface
    
    init (store: StoreInterface) {
        self.store = store
    }
    
    @discardableResult
    func run(parameters: [String]) throws -> String? {
        guard parameters.count == 1 else { throw CommandParser.ArgumentParserError.invalidCommand }
        store.delete(for: parameters[0])
        return nil
    }
}

struct CountCommand: Command {
    let baseArg: String = "count"
    private var store: StoreInterface
    
    init (store: StoreInterface) {
        self.store = store
    }
    
    @discardableResult
    func run(parameters: [String]) throws -> String? {
        guard parameters.count == 1 else { throw CommandParser.ArgumentParserError.invalidCommand }
        if let count = store.count(for: parameters[0]) {
            return String(count)
        } else {
            return nil
        }
    }
}

struct BeginCommand: Command {
    let baseArg: String = "begin"
    private var store: StoreInterface
    
    init (store: StoreInterface) {
        self.store = store
    }
    
    @discardableResult
    func run(parameters: [String]) throws -> String? {
        try store.begin()
        return nil
    }
}
struct CommitCommand: Command {
    let baseArg: String = "commit"
    private var store: StoreInterface
    
    init (store: StoreInterface) {
        self.store = store
    }
    
    @discardableResult
    func run(parameters: [String]) throws -> String? {
        try store.commit()
        return nil
    }
}
struct RollbackCommand: Command {
    let baseArg: String = "rollback"
    private var store: StoreInterface
    
    init (store: StoreInterface) {
        self.store = store
    }
    
    @discardableResult
    func run(parameters: [String]) throws -> String? {
        try store.rollback()
        return nil
    }
}

struct DropCommand: Command {
    let baseArg: String = "drop"
    private var store: StoreInterface
    
    init (store: StoreInterface) {
        self.store = store
    }
    
    @discardableResult
    func run(parameters: [String]) throws -> String? {
        store.drop()
        return nil
    }
}
