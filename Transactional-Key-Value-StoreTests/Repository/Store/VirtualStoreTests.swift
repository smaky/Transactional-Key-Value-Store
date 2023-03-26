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
        XCTAssertEqual(value, try store.get(for: key))
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
        let retrivedValue = try store.get(for: key)
        
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
        XCTAssertThrowsError(try store.get(for: key)) { error in
            XCTAssertEqual(error as! StoreInterfaceError, StoreInterfaceError.keyNoSet)
        }
    }
    
    func testCountValuesInTransaction() throws {
        let value = "123"
        let key1 = "foo"
        let key2 = "bar"
        let key3 = "baz"
        // > SET foo 123
        store.set(value: value, for: key1)
        // > SET bar 123
        store.set(value: value, for: key2)
        // > SET baz 123
        store.set(value: value, for: key3)
        
        XCTAssertEqual(3, store.count(for: value)!)
    }
    
    func testCommitTransaction() throws {
        let value = "456"
        let key = "foo"
        // > BEGIN
        try store.begin()
        // > SET foo 456
        store.set(value: value, for: key)
        
        XCTAssertEqual(value, try store.get(for: key))
        // > COMMIT
        try store.commit()
        // > ROLLBACK
        XCTAssertThrowsError(try store.rollback()) { error in
            XCTAssertEqual(error as! StoreInterfaceError, StoreInterfaceError.noTransaction)
        }
        // > GET foo
        XCTAssertEqual(value, try store.get(for: key))
    }
    
    func testRollbackTransaction() throws {
        let value1 = "123"
        let key1 = "foo"
        let value2 = "abc"
        let key2 = "bar"
        let value3 = "456"
        let value4 = "def"
        // > SET foo 123
        store.set(value: value1, for: key1)
        // > SET bar abc
        store.set(value: value2, for: key2)
        XCTAssertEqual(value1, try store.get(for: key1))
        XCTAssertEqual(value2, try store.get(for: key2))
        
        // > BEGIN
        try store.begin()
        
        // > SET foo 456
        store.set(value: value3, for: key1)
        // > GET foo
        XCTAssertEqual(value3, try store.get(for: key1))
        
        // > SET bar def
        store.set(value: value4, for: key2)
        // > GET bar
        XCTAssertEqual(value4, try store.get(for: key2))
        
        // > ROLLBACK
        try store.rollback()
        
        // > GET foo
        XCTAssertEqual(value1, try store.get(for: key1))
        // > GET bar
        XCTAssertEqual(value2, try store.get(for: key2))
        // > COMMIT
        XCTAssertThrowsError(try store.commit()) { error in
            XCTAssertEqual(error as! StoreInterfaceError, StoreInterfaceError.noTransaction)
        }
    }
    
    
    func testNestedTransaction() throws {
        let value1 = "123"
        let key1 = "foo"
        let value2 = "456"
        let key2 = "bar"
        let value3 = "789"
        
        //> SET foo 123
        store.set(value: value1, for: key1)
        XCTAssertEqual(value1, try store.get(for: key1))
        //> BEGIN
        try store.begin()
        //> SET bar 456
        store.set(value: value2, for: key2)
        XCTAssertEqual(value2, try store.get(for: key2))
        //> SET foo 456
        store.set(value: value2, for: key1)
        XCTAssertEqual(value2, try store.get(for: key1))
        //> BEGIN
        try store.begin()
        //> COUNT 456
        XCTAssertEqual(2, store.count(for: value2)!)
        
        //> GET foo
        XCTAssertEqual(value2, try store.get(for: key1))
        //> SET foo 789
        store.set(value: value3, for: key1)
        //> GET foo
        XCTAssertEqual(value3, try store.get(for: key1))
        
        //> ROLLBACK
        try store.rollback()
        //> GET foo
        XCTAssertEqual(value2, try store.get(for: key1))
        //> ROLLBACK
        try store.rollback()
        //> GET foo
        XCTAssertEqual(value1, try store.get(for: key1))
    }
}
