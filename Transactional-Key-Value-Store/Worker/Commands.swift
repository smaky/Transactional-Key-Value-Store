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
