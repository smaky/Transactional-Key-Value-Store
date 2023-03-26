//
//  CommandsTests.swift
//  Transactional-Key-Value-StoreTests
//
//  Created by Damian Smakulski on 26/03/2023.
//

import XCTest
@testable import Transactional_Key_Value_Store

final class CommandsTests: XCTestCase {
    var store: StoreInstanceSpy!
    
    override func setUpWithError() throws {
        store = StoreInstanceSpy()
    }
    
    func testSetCommandExecuteWithSuccess() throws {
        let args = ["foo", "1234"]
        var testCommand = SetCommand(store: store)
        
        XCTAssertFalse(store.setCalled)
        
        try testCommand.run(parameters: args)
        
        XCTAssertTrue(store.setCalled)
        XCTAssertEqual(store.setParams, args)
    }
    
}
