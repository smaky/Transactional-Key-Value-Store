//
//  VirtualSotreSpy.swift
//  Transactional-Key-Value-StoreTests
//
//  Created by Damian Smakulski on 26/03/2023.
//

import Foundation
@testable import Transactional_Key_Value_Store

final class StoreInstanceSpy: StoreInterface {

    var setCalled = false
    var setParams = [String]()
    func set(value: String, for key: String) {
        setParams = [key, value]
        setCalled = true
    }
    
    var getCalled = false
    var getParam = ""
    func get(for key: String) -> String? {
        getCalled = true
        getParam = key
        return ""
    }
    
    var deleteCalled = false
    var deleteParam = ""
    func delete(for key: String) {
        deleteParam = key
        deleteCalled = true
    }
}
