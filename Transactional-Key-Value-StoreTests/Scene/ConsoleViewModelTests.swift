//
//  ConsoleViewModelTests.swift
//  Transactional-Key-Value-StoreTests
//
//  Created by Damian Smakulski on 26/03/2023.
//

import XCTest
@testable import Transactional_Key_Value_Store

final class ConsoleViewModelTests: XCTestCase {

    private var consoleViewModel: ConsoleViewModel!
    private var store: StoreInstanceSpy!
    
    override func setUpWithError() throws {
        store = StoreInstanceSpy()
        consoleViewModel = ConsoleViewModel(store: store)
    }

    override func tearDownWithError() throws {
        
    }

    func testExecuteCommandProduceLog() throws {
        let command1 = "Some command"
        let command2 = "Another command"
        
        let result1 = "> " + command1
        let result2 = "Invalid command"
        
        consoleViewModel.executeCommand(command1)
        consoleViewModel.executeCommand(command2)
        
        XCTAssertEqual(consoleViewModel.logs[0].text, result1)
        XCTAssertEqual(consoleViewModel.logs[1].text, result2)
    }
}
