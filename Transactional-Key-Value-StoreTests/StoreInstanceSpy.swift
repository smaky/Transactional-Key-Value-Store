//
//  VirtualSotreSpy.swift
//  Transactional-Key-Value-StoreTests
//
//  Created by Damian Smakulski on 26/03/2023.
//

import Foundation
@testable import Transactional_Key_Value_Store

final class StoreInstanceSpy: StoreInterface {
    enum TestError: Error {
        case testError
    }
    
    var countCalled = false
    var countParam = ""
    func count(for value: String) -> Int? {
        countParam = value
        countCalled = true
        return nil
    }
    
    var beginCalled = false
    var throwError = false
    func begin() throws {
        beginCalled = true
        if throwError {
            throw TestError.testError
        }
    }
    
    var commitCalled = false
    func commit() throws {
        commitCalled = true
        if throwError {
            throw TestError.testError
        }
    }
    
    var rollbackCalled = false
    func rollback() throws {
        rollbackCalled = true
        if throwError {
            throw TestError.testError
        }
    }
    
    var setCalled = false
    var setParams = [String]()
    func set(value: String, for key: String) {
        setParams = [key, value]
        setCalled = true
    }
    
    var getCalled = false
    var getParam = ""
    func get(for key: String) throws -> String {
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
