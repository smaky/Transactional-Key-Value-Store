//
//  CommandExecutorInterface.swift
//  Transactional-Key-Value-Store
//
//  Created by Damian Smakulski on 26/03/2023.
//

import Foundation

protocol CommandExecutorInterface {
    func executeCommand(_ commandText: String)
}
