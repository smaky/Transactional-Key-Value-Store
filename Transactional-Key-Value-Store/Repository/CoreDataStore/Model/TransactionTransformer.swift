//
//  TransactionTransformer.swift
//  Transactional-Key-Value-Store
//
//  Created by Damian Smakulski on 16/04/2023.
//

import UIKit

class TransactionTransformer: NSSecureUnarchiveFromDataTransformer {
    override static var allowedTopLevelClasses: [AnyClass] {
        [Transaction.self]
    }
    static func register() {
        let className = String(describing: TransactionTransformer.self)
        let name = NSValueTransformerName(className)
        
        let transformer = TransactionTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
}
