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
    
    func testSetCommandExecuteWithFail() throws {
        let args = ["foo"]
        var testCommand = SetCommand(store: store)
        
        XCTAssertFalse(store.setCalled)
            
        XCTAssertThrowsError(try testCommand.run(parameters: args)) { error in
            XCTAssertEqual(error as! CommandParser.ArgumentParserError, CommandParser.ArgumentParserError.invalidCommand)
        }
        
        XCTAssertFalse(store.setCalled)
    }
    
    func testGetCommandExecuteWithSuccess() throws {
        let args = ["foo"]
        let testCommand = GetCommand(store: store)
        
        XCTAssertFalse(store.getCalled)
        
        try testCommand.run(parameters: args)
        
        XCTAssertTrue(store.getCalled)
        XCTAssertEqual(store.getParam, args.first)
    }
    
    func testGetCommandExecuteWithFail() throws {
        let args = [String]()
        let testCommand = GetCommand(store: store)
        
        XCTAssertFalse(store.getCalled)
            
        XCTAssertThrowsError(try testCommand.run(parameters: args)) { error in
            XCTAssertEqual(error as! CommandParser.ArgumentParserError, CommandParser.ArgumentParserError.invalidCommand)
        }
        
        XCTAssertFalse(store.getCalled)
    }
    
    func testDeleteCommandExecuteWithSuccess() throws {
        let args = ["foo"]
        let testCommand = DeleteCommand(store: store)
        
        XCTAssertFalse(store.deleteCalled)
        
        try testCommand.run(parameters: args)
        
        XCTAssertTrue(store.deleteCalled)
        XCTAssertEqual(store.deleteParam, args.first)
    }
    
    func testDeleteCommandExecuteWithFail() throws {
        let args = [String]()
        let testCommand = DeleteCommand(store: store)
        
        XCTAssertFalse(store.deleteCalled)
            
        XCTAssertThrowsError(try testCommand.run(parameters: args)) { error in
            XCTAssertEqual(error as! CommandParser.ArgumentParserError, CommandParser.ArgumentParserError.invalidCommand)
        }
        
        XCTAssertFalse(store.deleteCalled)
    }
    
    func testCountCommandExecuteWithSuccess() throws {
        let args = ["foo"]
        let testCommand = CountCommand(store: store)
        
        XCTAssertFalse(store.countCalled)
        
        try testCommand.run(parameters: args)
        
        XCTAssertTrue(store.countCalled)
        XCTAssertEqual(store.countParam, args.first)
    }
    
    func testCountCommandExecuteWithFail() throws {
        let args = [String]()
        let testCommand = CountCommand(store: store)
        
        XCTAssertFalse(store.countCalled)
            
        XCTAssertThrowsError(try testCommand.run(parameters: args)) { error in
            XCTAssertEqual(error as! CommandParser.ArgumentParserError, CommandParser.ArgumentParserError.invalidCommand)
        }
        
        XCTAssertFalse(store.countCalled)
    }
    
    func testCommitCommandExecuteWithSuccess() throws {
        let testCommand = CommitCommand(store: store)
        
        XCTAssertFalse(store.commitCalled)
        
        try testCommand.run(parameters: [])
        
        XCTAssertTrue(store.commitCalled)
    }
    
    func testCommitCommandExecuteWithFail() throws {
        let testCommand = CommitCommand(store: store)
        
        XCTAssertFalse(store.commitCalled)
        
        store.throwError = true
        XCTAssertThrowsError(try testCommand.run(parameters: [])) { error in
            XCTAssertEqual(error as! StoreInstanceSpy.TestError, StoreInstanceSpy.TestError.testError )
        }
        
        XCTAssertTrue(store.commitCalled)
    }
    
    func testRollbackCommandExecuteWithSuccess() throws {
        let testCommand = RollbackCommand(store: store)
        
        XCTAssertFalse(store.rollbackCalled)
        
        try testCommand.run(parameters: [])
        
        XCTAssertTrue(store.rollbackCalled)
    }
    
    func testRollbackCommandExecuteWithFail() throws {
        let testCommand = RollbackCommand(store: store)
        
        XCTAssertFalse(store.rollbackCalled)
        
        store.throwError = true
        XCTAssertThrowsError(try testCommand.run(parameters: [])) { error in
            XCTAssertEqual(error as! StoreInstanceSpy.TestError, StoreInstanceSpy.TestError.testError )
        }
        
        XCTAssertTrue(store.rollbackCalled)
    }

    func testBeginCommandExecuteWithSuccess() throws {
        let testCommand = BeginCommand(store: store)
        
        XCTAssertFalse(store.beginCalled)
        
        try testCommand.run(parameters: [])
        
        XCTAssertTrue(store.beginCalled)
    }
    
    func testBeginCommandExecuteWithFail() throws {
        let testCommand = BeginCommand(store: store)
        
        XCTAssertFalse(store.beginCalled)
        
        store.throwError = true
        XCTAssertThrowsError(try testCommand.run(parameters: [])) { error in
            XCTAssertEqual(error as! StoreInstanceSpy.TestError, StoreInstanceSpy.TestError.testError )
        }
        
        XCTAssertTrue(store.beginCalled)
    }
}
