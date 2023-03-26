//
//  StoreCommandExecutorTests.swift
//  Transactional-Key-Value-StoreTests
//
//  Created by Damian Smakulski on 26/03/2023.
//

import XCTest
@testable import Transactional_Key_Value_Store

final class StoreCommandExecutorTests: XCTestCase {
    var store: StoreInstanceSpy!
    var commandExecutor: CommandExecutorInterface!
    
    override func setUpWithError() throws {
        store = StoreInstanceSpy()
        commandExecutor = StoreCommandExecutor(store: store)
    }

    override func tearDownWithError() throws {
        
    }

    func testExecuteSetCommandOnStore() throws {
        XCTAssertFalse(store.setCalled)
        commandExecutor.executeCommand("set foo 123")
        XCTAssertTrue(store.setCalled)
    }
}
