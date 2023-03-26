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
    var logs: [Log]!
    
    override func setUpWithError() throws {
        store = StoreInstanceSpy()
        commandExecutor = StoreCommandExecutor(store: store)
        logs = [Log]()
    }

    func testExecuteSetCommandOnStore() throws {
        let command = "set foo 123"
        let result = "> SET foo 123"
        XCTAssertFalse(store.setCalled)
        commandExecutor.executeCommand(command, with: &logs)
        XCTAssertEqual(logs[0].text, result)
        XCTAssertTrue(store.setCalled)
    }
}
