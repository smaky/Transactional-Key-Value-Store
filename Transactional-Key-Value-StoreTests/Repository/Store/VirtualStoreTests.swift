//
//  VirtualStoreTests.swift
//  Transactional-Key-Value-StoreTests
//
//  Created by Damian Smakulski on 26/03/2023.
//

import XCTest
@testable import Transactional_Key_Value_Store

final class VirtualStoreTests: XCTestCase {

    var store: StoreInterface!
    
    override func setUpWithError() throws {
        store = VirtualStore()
    }

    func testSetAndGetInTransaction() throws {
        let value = "123"
        let key = "foo"
        
        // > SET foo 123
        store.set(value: value, for: key)
        // > GET foo
        XCTAssertEqual(value, store.get(for: key))
    }
    
    func testOverrideSetInTransaction() throws {
        let value = "123"
        let overrideValue = "456"
        let key = "foo"
        
        // > SET foo 123
        store.set(value: value, for: key)
        // > SET foo 456
        store.set(value: overrideValue, for: key)
        // > GET foo
        let retrivedValue =  store.get(for: key)
        
        XCTAssertEqual(overrideValue, retrivedValue)
        XCTAssertNotEqual(value, retrivedValue)
    }
    
    func testDeleteInTransaction() throws {
        let value = "123"
        let key = "foo"
        
        // > SET foo 123
        store.set(value: value, for: key)
        // > DELETE foo
        store.delete(for: key)
        // > GET foo
        let retrivedValue =  store.get(for: key)
        XCTAssertNil(retrivedValue)
    }
}
