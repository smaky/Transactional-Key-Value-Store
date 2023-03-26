//
//  StoreInterface.swift
//  Transactional-Key-Value-Store
//
//  Created by Damian Smakulski on 26/03/2023.
//

import Foundation

protocol StoreInterface {
    func set(value: String, for key: String)
    func get(for key: String) -> String?
    func delete(for key: String)
}
