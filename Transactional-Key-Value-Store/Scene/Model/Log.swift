//
//  Log.swift
//  Transactional-Key-Value-Store
//
//  Created by Damian Smakulski on 26/03/2023.
//

import Foundation

struct Log: Hashable, Codable, Identifiable {
    var id: String = UUID().uuidString
    var text: String
}
